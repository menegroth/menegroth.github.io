require_relative './change'

input_lexicon_filename, output_lexicon_filename = ARGV

shorten = -> (v) {
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

metathesis = -> (s) { s.reverse }

changes = ChangeSequence.new(
  'C' => '[tpkdbglrszhwynmñ]',
  'V' => '[aeiouāēīōūáéíóúâêîôû]',
  '<unstressed vowel>' => '[aeiouāēīōū]',
  '<stressed vowel>' => '[áéíóúâêîôû]',
  '<long vowel>' => '[āēīōūâêîôû]'
) do |s|
  s.change('ñw', 'ñgw', '_') # Salo 4.2
  s.change('<unstressed vowel>', '', '<stressed vowel>C+_C', optional: true) # Salo 4.3
  s.change('s', 'z', '_[dbg]') # Salo 4.4
  s.change('bm|dn|gñ', metathesis, '_') # Salo 4.5
  s.change('<long vowel>', shorten, '_CC') # Salo 4.6
end

input = File.read(input_lexicon_filename).split("\n")
golden = File.read(output_lexicon_filename).split("\n").map do |w|
  w.split(' = ')[0]
end

output = input.map do |entry|
  word, gloss = entry.split(' = ')
  out = changes.apply(word)
  puts "#{out.join(', ')} <- #{word} '#{gloss}'"
  out
end.flatten

golden.each do |golden_word|
  if !output.include? golden_word
    puts "NOT FOUND: #{golden_word}"
  end
end
