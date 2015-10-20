def partition_all word, target
  if Regexp === target && target.inspect == '//'
    ['', ''] + word.chars.zip([''].cycle).flatten + ['']
  else
    before, middle, after = word.partition(target)
    return [word] if before == word
    [before, middle] + partition_all(after, target)
  end
end

class ChangeContext < Struct.new(:string)
  def before
    Regexp.new(partition_on_underscore[0] + '$')
  end

  def after
    Regexp.new('^' + partition_on_underscore[-1])
  end

  private

  def partition_on_underscore
    string.partition('_')
  end
end

class ChangeSequence
  attr_reader :macros

  def initialize macros={}
    @macros = macros
    @changes = []
    yield self if block_given?
  end

  def change find, replace, context='_', options={}
    build_change find, replace, context, options, Change
  end

  def debug find, replace, context='_', options={}
    build_change find, replace, context, options, DebugChange
  end

  def apply word
    @changes.reduce([word].flatten) do |word, change|
      change.apply_to word
    end
  end

  private

  def build_change find, replace, context, options, change_class
    find = apply_macros find
    context = ChangeContext.new apply_macros context

    @changes << change_class.new(Regexp.new(find), replace, context.before, context.after, options)
  end

  def apply_macros s
    macros.reduce(s) do |s, (find, replace)|
      s.gsub(find, replace)
    end
  end
end

class Change < Struct.new(:find, :replacement, :context_before, :context_after, :options)

  def apply_to words
    if !(String === words)
      words.map { |word| apply_to_one word }.flatten.uniq
    else
      apply_to_one words
    end
  end

  private

  def apply_to_one word
    parts = partition_all word, find
    out_parts = parts.dup

    (1 ... parts.length - 1).step(2) do |n|
      before = parts[0 ... n]
      after = parts[n+1 .. -1] || []
      out_parts[n] = replace(parts[n]) if context_before =~ before.join && context_after =~ after.join
    end

    if optional?
      [out_parts.join, word]
    else
      [out_parts.join]
    end
  end

  def optional?
    !!options[:optional]
  end

  def replace(part)
    if Proc === replacement
      replacement.call(part)
    else
      replacement
    end
  end
end

class DebugChange < Change
  def apply_to_one word
    out = super
    STDERR.puts "DEBUG: #{word} -> #{out}" if out.any? { |o| o != word }
    out
  end
end

def comment?(line_in_lexicon)
  line_in_lexicon[0] == '#'
end

def apply_changes(changes)
  output_lexicon_filename = ARGV[0] || '/dev/null'

  golden = File.read(output_lexicon_filename)
    .split("\n")
    .reject(&:empty?)
    .reject(&method(:comment?))
    .reject { |w| w[0] == '!' }
    .map { |w| w.split(' = ')[0].sub('*', '') }

  output = []

  while entry = STDIN.gets
    next if entry.strip.empty?
    next if comment? entry
    word, gloss = entry.chomp.split(' = ')
    word.sub!('*', '')
    word.sub!('!', '')
    out = changes.apply(word)
    out.each do |out|
      puts "#{out} = <- #{word} :: #{gloss}"
    end
    output << out
  end

  output.flatten!

  golden.each do |golden_word|
    if !output.include? golden_word
      STDERR.puts "NOT FOUND: #{golden_word}"
    end
  end
end

$voice = -> (c) {
  { 't' => 'd',
    'p' => 'b',
    'k' => 'g',
    's' => 'z'
  }[c] || c
}

$remove_stress_marking = -> (v) {
  {
    'á' => 'a',
    'é' => 'e',
    'í' => 'i',
    'ó' => 'o',
    'ú' => 'u',
    'â' => 'ā',
    'ê' => 'ē',
    'î' => 'ī',
    'ô' => 'ō',
    'û' => 'ū'
  }[v] || v
}

$shorten = -> (v) {
  { 'ā' => 'a',
    'ē' => 'e',
    'ī' => 'i',
    'ō' => 'o',
    'ū' => 'u',
    'â' => 'á',
    'ê' => 'é',
    'î' => 'í',
    'ô' => 'ó',
    'û' => 'ú',
  }[v] || v
}
