def partition_all word, target
  if Regexp === target && target.inspect == '//'
    ['', ''] + word.chars.zip([''].cycle).flatten + ['']
  else
    before, middle, after = word.partition(target)
    return [word] if before == word
    [before, middle] + partition_all(after, target)
  end
end

class ChangeSequence
  attr_reader :macros

  def initialize macros
    @macros = macros
    @changes = []
    yield self
  end

  def change find, replace, context, options={}
    find = apply_macros find
    context = apply_macros context

    context_before, _, context_after = context.partition('_')
    context_before = Regexp.new(context_before + '$')
    context_after = Regexp.new('^' + context_after)

    @changes << Change.new(Regexp.new(find), replace, context_before, context_after, options)
  end

  def apply word
    @changes.reduce(word) do |word, change|
      change.apply_to word
    end
  end

  private

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

def apply_changes(changes)
  output_lexicon_filename = ARGV[0] || '/dev/null'

  golden = File.read(output_lexicon_filename).split("\n").reject(&:empty?).map do |w|
    w.split(' = ')[0]
  end

  output = []

  while entry = STDIN.gets
    next if entry.strip.empty?
    word, gloss = entry.chomp.split(' = ')
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
