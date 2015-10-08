#class Word < Struct.new(:pronunciations, :gloss)
#  def with_changed_pronunciations(word, pronunciations)
#    Word.new(pronunciations, word.gloss)
#  end
#
#  def each_pronunciation
#    if block_given?
#      pronunciations.each do |p|
#        yield p
#      end
#    else
#      pronunciations.each
#    end
#  end
#
#  def == other_word
#    other_word.gloss == gloss
#    other_word.each_pronunciation.all? do |p|
#      pronunciations.include? p
#    end
#  end
#end
#
#class Change
#  def apply_to word
#    word
#  end
#end
#
#class Checkpoint
#  def golden_wordlist= wordlist
#    @wordlist = wordlist
#  end
#
#  def ok? word
#    golden_word = wordlist.find_by_gloss word.gloss
#    word == golden_word
#  end
#end

class Change < Struct.new(:find, :replacement, :context_before, :context_after)
  def apply_to word
    Application.new(word, self).result
    #parts = word.partition(find)
    #return word if parts[0] == word
    #
    #replaced = context_before =~ parts[0] && context_after =~ parts[2] ? replace : parts[1]
    #
    #parts[0] + replaced + apply_to(parts[2])
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

  class Application < Struct.new(:word, :change)
    def result
      # TODO: passing in the suffix might not be enough; what if the beginning of the word has necessary context?
      return word if element_to_change_not_found?
      prefix + changed_part + result_of_changing_suffix
    end

    private

    def element_to_change_not_found?
      prefix == word
    end

    def changed_part
      change_applies? ? change.replace(part_to_change) : part_to_change
    end

    def result_of_changing_suffix
      Application.new(suffix, change).result
    end

    def prefix
      parts[0]
    end

    def part_to_change
      parts[1]
    end

    def suffix
      parts[2]
    end

    def parts
      @parts ||= word.partition(change.find)
    end

    def change_applies?
      change.context_before =~ prefix && change.context_after =~ suffix
    end
  end
end

words = [
  'folon',
  'bad',
  'bat',
  'bazork',
  'batzog'
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
