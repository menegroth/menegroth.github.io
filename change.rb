def partition_all word, target
  if Regexp === target && target.inspect == '//'
    ['', ''] + word.chars.zip([''].cycle).flatten + ['']
  else
    before, middle, after = word.partition(target)
    return [word] if before == word
    [before, middle] + partition_all(after, target)
  end
end

class ChangeFactory
  attr_reader :macros

  def initialize macros
    @macros = macros
    yield self
  end

  def build find, replace, context
    find = apply_macros find
    context = apply_macros context

    context_before, _, context_after = context.partition('_')
    context_before = Regexp.new(context_before + '$')
    context_after = Regexp.new('^' + context_after)

    Change.new(Regexp.new(find), replace, context_before, context_after)
  end

  private

  def apply_macros s
    macros.reduce(s) do |s, (find, replace)|
      s.gsub(find, replace)
    end
  end
end

class Change < Struct.new(:find, :replacement, :context_before, :context_after)

  def self.build(find, transformation, context)
    context_before, _, context_after = context.partition('_')
    context_before = Regexp.new(context_before + '$')
    context_after = Regexp.new('^' + context_after)

    new(Regexp.new(find), transformation, context_before, context_after)
  end


  def apply_to words
    if !(String === words)
      words.map { |word| apply_to_one word }.flatten
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

    out_parts.join
  end

  def replace(part)
    if Proc === replacement
      replacement.call(part)
    else
      replacement
    end
  end
end

words = {
  'folon' => 'fulon',
  'bad' => 'beid',
  'bat' => 'bat',
  'bazork' => 'bjork',
  'batzog' => 'batzug',
  'dazod' => 'djud',
  'baiiiar' => 'baar'
}

lengthen = ->(v) {
  v + v
}

changes = []
ChangeFactory.new(
  'C' => '[tpkdbglrsnmhwyjkzxcvq]',
  'V' => '[aeiou]'
) do |c|
  changes << c.build('V', lengthen, '_[dbgzl]')
  changes << c.build('aa', 'ei', '_')
  changes << c.build('ee', 'i', '_')
  changes << c.build('oo', 'u', '_')
  changes << c.build('z', '', 'V_V')
  changes << c.build('i', '', 'V_V')
  changes << c.build('e', 'i', '_[aou]')
  changes << c.build('i', 'j', '_V')
end

problems = []
words.each do |word, expected_result_of_change|
  result = changes.reduce(word) do |word, change|
    change.apply_to word
  end
  if result != expected_result_of_change
    problems << "expected #{word} -> #{expected_result_of_change} but got #{result}"
  end
  puts result
end

puts problems.compact
