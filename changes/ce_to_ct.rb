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

devoice = -> (s) {
  { 'd' => 't',
    'b' => 'p',
    'g' => 'k',
  }[s] || s
}

metathesis = -> (s) { s.reverse }

haplology = -> (s) {
  s.split(/[aeiou]/)[0]
}

changes = ChangeSequence.new(
  'C' => '[tpkdbglrszhwynmñ]',
  'V' => '[aeiouāēīōūáéíóúâêîôû]',
  '<unstressed vowel>' => '[aeiouāēīōū]',
  '<stressed vowel>' => '[áéíóúâêîôû]',
  '<long vowel>' => '[āēīōūâêîôû]'
) do |s|
  s.change('[dbg]', devoice, '_[st]') # Salo 4.7
  s.change('h', '', '[tpk]_[st]') # Salo 4.7
  s.change('tt', 'tst', '_') # Salo 4.8
  s.change('tst', 'st', '_') # Salo 4.9
  s.change('^etkelē$', 'ektelē', '_') # Salo 4.11
  s.change('t', 'p', '_[\+\.]?[pb]') # Salo 4.10
  s.change('t', 'k', '_[\+\.]?[kg]') # Salo 4.10
  s.change('d', 'b', '_[\+\.]?[pb]') # Salo 4.10
  s.change('d', 'g', '_[\+\.]?[kg]') # Salo 4.10
  s.change('[mñ]', 'n', '_[td]') # Salo 4.12
  # s.change 'i', 'è', '_$' # Salo 4.13
  # s.change 'u', 'ò', '_$' # Salo 4.13
  s.change '<long vowel>', shorten, '_.' # Salo 4.14
  s.change 'wō', 'wā', '_$' # Salo 4.15
  s.change 'ā', 'ē', 't[wm]_$' # Salo 4.16
  s.change 'āu', 'ā', '_' # Salo 4.17
  s.change '[nmñ]', syllabify, '^_', optional: true # Salo 4.18
  s.change 'j', 'i', 'V\+_' # Salo 4.20
  s.change 'V', '', '_\+V' # Salo 4.19
  s.change '(CC?)V\1', haplology, 'V_V' # Salo 4.21
end

apply_changes(changes, input_lexicon_filename, output_lexicon_filename)
