def partition_all word, target
  if Regexp === target && target.inspect == '//'
    ['', ''] + word.chars.zip([''].cycle).flatten + ['']
  else
    before, middle, after = word.partition(target)
    return [word] if before == word
    [before, middle] + partition_all(after, target)
  end
end

class Change < Struct.new(:find, :replacement, :context_before, :context_after)

  def self.build(find, transformation, context)
    context_before, _, context_after = context.partition('_')
    context_before = Regexp.new(context_before + '$')
    context_after = Regexp.new('^' + context_after)

    new(Regexp.new(find), transformation, context_before, context_after)
  end


  def apply_to word
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

changes = [
  Change.new(/o/, 'oo', /[flo]$/, /^[l]/),
  Change.build('[aeiou]', lengthen, '_[dbgz]'),
  Change.build('aa', 'ei', '_'),
  Change.build('ee', 'i', '_'),
  Change.build('oo', 'u', '_'),
  Change.build('z', '', '[aeiou]_[aeiou]'),
  Change.build('i', '', '[aeiou]_[aeiou]'),
  Change.build('e', 'i', '_[aou]'),
  Change.build('i', 'j', '_[aeiou]')
]

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
