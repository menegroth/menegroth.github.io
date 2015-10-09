class Change < Struct.new(:find, :replacement, :context_before, :context_after)
  def apply_to word, prefix=''
    parts = word.partition(find)
    if parts[0] == word
      return prefix + word
    end

    prefix = prefix + parts[0]

    replaced = context_before =~ prefix && context_after =~ parts[2] ? replace(parts[1]) : parts[1]

    apply_to(parts[2], prefix + replaced)
  end

  def replace(part)
    if Proc === replacement
      replacement.call(part)
    else
      replacement
    end
  end

  def self.build(find, transformation, context)
    context_before, _, context_after = context.partition('_')
    context_before = Regexp.new(context_before + '$')
    context_after = Regexp.new('^' + context_after)

    new(Regexp.new(find), transformation, context_before, context_after)
  end
end

words = [
  'folon',
  #'bad',
  #'bat',
  #'bazork',
  #'batzog',
  #'dazod',
  'baiiiar'
]

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

changed = words.map do |word|
  changes.reduce(word) do |word, change|
    change.apply_to word
  end
end

puts changed
