require_relative './change'

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
    'ú' => 'û'
  }[v] || v
}


remove_stress_marking = -> (v) {
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

spirantize = -> (c) {
  {
    't' => 'þ',
    'p' => 'f',
    'k' => 'x',
  }[c] || c
}

syncopate = -> (s) {
  s[0 .. -4] + s[-2 .. -1]
}

degeminate = -> (xx) {
  xx[0]
}

respell_long_vowels_with_acutes = -> (v) {
  { 'ā' => 'á',
    'ē' => 'é',
    'ī' => 'í',
    'ō' => 'ó',
    'ū' => 'ú'
  }[v] || v
}

changes = ChangeSequence.new(
  'C' => '[tpkdbgfþxvðʒlrszhwjnmñ]',
  'V' => '[aeiouāēīōūáéíóúâêîôû]',
  '<voiced consonant>' => '[dbgvðʒlrznwjnmñ]',
  '<long vowel>' => '[āēīōūâêîôû]',
  '<short vowel>' => '[aeiouáéíóú]',
  '<stressed vowel>' => '[áéíóúâêîôû]'
) do |s|
  s.change '<long vowel>', shorten, '\+.*_$' # Fauskanger:23
  s.change 'i', 'e', 'C_$' # Fauskanger:24
  s.change 'dl', 'ld', '_' # Fauskanger:24 - maybe optional?
  s.change '', 'h', '^s[tpk]_' # Fauskanger:24
  s.change 's', '', '^_[tpknm]' # Fauskanger:24,25
  s.change 's', 'h', '^_[lrw]' # Fauskanger:24-25
  s.change 'ph', 'hw', '_[uúūû]', optional: true # Fauskanger:25; apparently variants of a word with and without this change could coexist, cf. huine vs. fuine.
  s.change '<stressed vowel>', remove_stress_marking, '_' # Fauskanger:25-26
  s.change '^C*(<short vowel>)[lr]\1CV', syncopate, '_' # Fauskanger:26 TODO: the environment for this syncope needs to be clarified. e.g. abaro did not syncopate to **abro
  s.change 'j', 'i', '_C' # Fauskanger:27
  s.change 'w', 'u', '_C' # Fauskanger:27
  s.change 'dr', 'r', '^_' # Fauskanger:27
  s.change 'd', 'l', '^_', optional: true # Fauskanger:27
  s.change 'd', 'n', '^_' # Fauskanger:27

  s.change 'd', 'l', 'V_V', optional: true # Fauskanger:28; cf. g-lada -> Q. lala "laugh"
  s.change 'dj', 'lj', 'V_V' # Fauskanger:28; marya < madjā is noted as an exception
  s.change 'g', 'ʒ', '^_' # Fauskanger:28-29
  s.change 'g', 'ʒ', 'V|l_'
  s.change 'b', 'v', '^_'
  s.change 'b', 'v', 'V_'
  s.change 'd', 'ð', 'V_' # WJ:363
  s.change '[tpk]', spirantize, '_h' # Fauskanger:29
  s.change 'h', '', '[þfx]_'
  s.change 'x', 'h', '_[wj]'
  s.change '<long vowel>', shorten, 'V.*_$'
  s.change '[sz][td]', 'st', '_'
  s.change '[sz][kg]', 'sk', '_'
  s.change '[kg][td]', 'kt', '_'
  s.change '[pb][td]', 'ps', '_'
  s.change 'hw', 'h', '_[uū]'
  s.change '[dbg]', '', '^[nmñ]_' # Fauskanger:32
  s.change '[dbg]', '', '\+[nmñ]_', optional: true # Fauskanger:32
  s.change 'm', 'mb', '_r' # Fauskanger:34 cf. tamrō -> *tambro -> tambaro
  s.change 'nn', 'an', '^_' # Fauskanger:32-33
  s.change 'mm', 'um', '^_' # Fauskanger:32-33
  s.change 'ññ', 'uñ', '^_gw' # Fauskanger:32-33
  s.change 'ññ', 'iñ', '^_' # Fauskanger:32-33
  s.change 'll', 'il', 'C_$' # Fauskanger:33
  s.change 'll', 'il', '^_'
  s.change 'r', 'rr', 'CC+_V' # Fauskanger:34
  s.change 'lr', 'll', 'V_V' # Fauskanger:34
  s.change 'nl', 'll', 'V_V' # Fauskanger:34
  s.change 'ls', 'll', 'V_V' # Fauskanger:34
  s.change 'rs', 'ss', 'V_V' # Fauskanger:34
  s.change 'sm', 'mm', 'V_V', optional: true # Fauskanger:34
  s.change 'sm', 'rm', 'V_V' # Fauskanger:34
  s.change 'sr', 'rr', 'V_V' # Fauskanger:34
  s.change 'þr', 'þþ', 'V_V' # Fauskanger:34
  s.change 'ln', 'ld', 'V_V' # Fauskanger:34
  s.change '[pb]n', 'mn', 'V_V' # Fauskanger:35
  s.change 'm', 'w', 'V[nþ]_V' # Fauskanger:35
  s.change 'b', 'p', 'V_sV' # Fauskanger:35
  # Note also the unique change tf -> ff in etfir -> effir (Fauskanger:35)
  s.change 'kl', 'lk', 'V_V' # Fauskanger:35
  s.change 'kr', 'rk', 'V_V' # Fauskanger:35
  s.change 'tr', 'rt', 'V_V' # Fauskanger:35
  s.change 'tl', 'lt', 'V_V' # Fauskanger:35, cf. VT42:26
  s.change 'sk',' ks', 'V_V', optional: true # Fauskanger:35-36
  s.change 'kt', 'xt', 'V_V' # Fauskanger:36
  s.change '[kg]m', 'ñgw', 'V_V' # Fauskanger:37
  s.change '[nt]m', 'nw', 'V_V' # Fauskanger:37
  s.change 'w', '', '$_ō' # Fauskanger: 37
  s.change 's', 'z', 'V_(V|<voiced consonant>)'
  s.change 'ae', 'ē' # Fauskanger:39
  s.change 'ao', 'ō' # Fauskanger:39
  s.change 'ei', 'ī' # Fauskanger:39
  s.change 'xt', 't', '_$' # Fauskanger:39
  s.change 'k?st?', 's', '_$' # Fauskanger:39
  s.change 'd', '', 'C_$' # Fauskanger:39-40
  s.change 'ñg', 'n', '_$' # Fauskanger:40
  s.change 'm', 'n', '_$' # Fauskanger:40
  s.change 'k', 't', '_$' # Fauskanger:40
  s.change '(C)\1', degeminate, '_$' # Fauskanger:40
  s.change 'aj', 'ai' # Fauskanger:42
  s.change 'aw', 'au' # Fauskanger:42
  s.change 'ai', 'e', '_V' # Fauskanger:42
  s.change 'au', 'o', '_V' # Fauskanger:42
  # Hypothesis: long vowels in the penultimate syllable were shortened if
  # the consonants flanking them could plausibly form a cluster.
  # See: Fauskanger:43
  s.change '<long vowel>', shorten, '(V[lr]|V)_[tpkðvʒnmwj]V$'
  s.change '<long vowel>', shorten, 'V(nd|mb|ñg)_lV$'
  s.change '<short vowel>', lengthen, 'V[^ie](C|\+)*V[^ie]?(C|\+)*_CVC?$'

  s.change 'kj', 'tj'

  s.change 'ʒ', 'g', 'C_'

  s.change 'w', 'v', 'V_V'

  # Changes in Exilic Quenya only

  s.change 'z', 'r'

  #s.change '<short vowel>', '', '_$', optional: true # Fauskanger:24; short final vowels in the second element of a compound were regularly deleted.
  s.change '[aeoáéó]', '', '\+.*[nrt]_$' # Fauskanger:24
  s.change '[aeoáéó]', '', 'Vr_$' # cf. Endor, ohtar

  # orthographic changes
  s.change 'x', 'h'
  s.change 'j', 'y'
  s.change 'ks', 'x'
  s.change 'kw', 'qu'
  s.change 'k', 'c'
  s.change 'ñ', 'n'
  s.change '[āēīōū]', respell_long_vowels_with_acutes
  s.change '\+', ''
  s.change '-', ' '
end

apply_changes(changes)
