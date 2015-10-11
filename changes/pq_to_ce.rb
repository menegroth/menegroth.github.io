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

lengthen = -> (v) {
  { 'a' => 'ā',
    'e' => 'ē',
    'i' => 'ī',
    'o' => 'ō',
    'u' => 'ū',
    'á' => 'â',
    'é' => 'ê',
    'í' => 'î',
    'ó' => 'ô',
    'ú' => 'û',
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

syllabify = -> (nasal) {
  nasal * 2
}

collapse_into_long_vowel = -> (vv) {
  lengthen.call vv[0]
}

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
  s.change('<long vowel>', shorten, '_\+') # Salo 4.6
  s.change('<long vowel>', shorten, '<long vowel>_') # cf. plural -ī shortening to -i after long vowels
  s.change('<long vowel>', shorten, '_i') # cf. Lindāi -> Lindai (WJ:378,385)
  s.change('ii', 'ī', '_') # hypothetical: *tārīī "queens" probably became *tārī
  s.change('[dbg]', devoice, '_[st]') # Salo 4.7
  s.change('h', '', '[tpk]_[st]') # Salo 4.7
  s.change('tt', 'tst', '_') # Salo 4.8 - but this change only occurred if the second t was part of a derivational suffix: cf. puttā "stop (n)" vs. pustā "stop (v)"
  s.change('tst', 'st', '_') # Salo 4.9
  s.change('^etkelē$', 'ektelē', '_') # Salo 4.11
  s.change('t', 'p', '_[\+\.]?[pb]') # Salo 4.10
  s.change('t', 'k', '_[\+\.]?[kg]') # Salo 4.10
  s.change('d', 'b', '_[\+\.]?[pb]') # Salo 4.10
  s.change('d', 'g', '_[\+\.]?[kg]') # Salo 4.10
  s.change('[mñ]', 'n', '_[td]') # Salo 4.12
  # s.change 'i', 'è', '_$' # Salo 4.13
  # s.change 'u', 'ò', '_$' # Salo 4.13
  s.change '[āēīōū]', shorten, '_.' # Salo 4.14
  s.change 'wō', 'wā', '_$' # Salo 4.15
  s.change 'ā', 'ē', 't[wm]_$' # Salo 4.16
  s.change 'āu', 'ā', '_' # Salo 4.17
  s.change '[nmñ]', syllabify, '^_[dbg]', optional: true # Salo 4.18
  s.change 'j', 'i', 'V\+_' # Salo 4.20
  s.change 'V', '', '_\+V' # Salo 4.19
  s.change '(CC?)V\+?\1', haplology, 'V_$?' # Salo 4.21
  s.change '(CC?)V\+?\1', haplology, '^?_V' # Salo 4.21

  s.change '[ñh]', '', 'V_V'
  s.change '(V)\1', collapse_into_long_vowel, '_'
  s.change 'e', 'i', '_ē'
  s.change 'ē', 'ī', '_ē'

  s.change '[aeo]', '', '_$' # cf. abaro -> abar, pl. abarī, ontâro -> Q. ontar "parent". It might be that the -o suffix of masculine nouns in -ro was dropped to form a gender-neutral term which could survive alongside the masculine form. *Avaro might be the masc. Q. form of Avar.
  #s.change 'a', '', '_$' # HKF http://folk.uib.no/hnohf/primelv.htm "original short final -a was lost in Common Eldarin"
  s.change 'w', 'u', '_$' # cf. angwa -> angu -> ango
  s.change 'āu', 'ā', '_$' # cf. rāw-?a -> rāu -> rā
  s.change 'u', 'o', '_$'
  s.change 'u', 'w', '[kg]_ī'

end

apply_changes(changes, input_lexicon_filename, output_lexicon_filename)
