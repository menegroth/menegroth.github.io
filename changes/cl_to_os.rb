require_relative './change'

stress = -> (v) {
  { 'a' => 'á',
    'e' => 'é',
    'i' => 'í',
    'o' => 'ó',
    'u' => 'ú',
    'ā' => 'â',
    'ē' => 'ê',
    'ī' => 'î',
    'ō' => 'ô',
    'ū' => 'û',
  }[v] || v
}

unstress = -> (v) {
  { 'á' => 'a',
    'é' => 'e',
    'í' => 'i',
    'ó' => 'o',
    'ú' => 'u',
    'â' => 'ā',
    'ê' => 'ē',
    'î' => 'ī',
    'ô' => 'ō',
    'û' => 'ū',
  }[v] || v
}

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

voice = -> (c) {
  {
    't' => 'd',
    'p' => 'b',
    'k' => 'g',
  }[c] || c
}

nasalize = -> (c) {
  {
    't' => 'n',
    'd' => 'n',
    'p' => 'm',
    'b' => 'm',
    'k' => 'ñ',
    'g' => 'ñ',
  }[c] || c
}

devoice = -> (s) {
  { 'd' => 't',
    'b' => 'p',
    'g' => 'k',
    'l' => 'L',
    'r' => 'R',
    'w' => 'ƕ',
    'j' => 'x',
  }[s] || s
}

geminate = -> (x) {
  x + x
}

changes = ChangeSequence.new(
  'C' => '[tpkdbglrszhwjnmñ]',
  'V' => '[aeiouāēīōūáéíóúâêîôû]',
  '<unstressed vowel>' => '[aeiouāēīōū]',
  '<stressed vowel>' => '[áéíóúâêîôû]',
  '<long vowel>' => '[āēīōūâêîôû]',
  '<short vowel>' => '[aeiouáéíóú]'
) do |s|
  s.change '[āēōaeo]i', 'ī', '_$' # Salo 4.33 TODO: figure out if final diphthongs were long or short at this point
  s.change 'V', stress, '^C<stressed vowel>r_C' # Salo 4.34
  s.change 'V', unstress, '^C_rVC' # Salo 4.34
  s.change '<unstressed vowel>', '', '^C_rVC' # Salo 4.35 TODO: should this be an optional change? Salo says the change applies "frequently" but gives no examples of words in which it does not occur.

  # After this point, stress may no longer be relevant, or it might regularize. TODO remove stress marking?

  s.change 'mr', 'br', '^_' # Salo 4.36
  s.change 'ñl', 'gl', '^_' # Salo 4.36
  s.change '<long vowel>', shorten, 'VC+_$' # Salo 4.37
  s.change '^ñole$', 'ole', '_' # Salo 4.38
  s.change 'ñ', 'ñg', '^_(V|w|j)' # Salo 4.38
  s.change 'j', '', '[kg]h?_' # Salo 4.39
  s.change '[nmñ]', 'a', '^_[nmñ]' # Salo 4.40
  s.change 'h', '_', '(^|V)_V' # Salo 4.41
  s.change 'h', 'g', '_[nmñ]' # Salo 4.42
  s.change 'h', 't', '_t' # Salo 4.43
  s.change 'h', 's', '_s' # Salo 4.43
  s.change '<short vowel>', lengthen, '_h[r$]' # Salo 4.44, 4.45
  s.change 'h', '', 'V_[r$]' # Salo 4.44, 4.45
  s.change '[tpk]', voice, '_[\-\+]?[nmñ]' # Salo 4.46
  s.change 'd', 'n', '_[\-\+]?[nmñ]' # Salo 4.47
  s.change 'b', 'm', '_[\-\+]?[nmñ]' # Salo 4.47
  s.change 'ln', 'll' # Salo 4.48
  s.change 'thn', 'tth' # Salo 4.49-50
  s.change 'thth', 'tth' # Salo 4.50
  s.change 'm', 'w', '[tdnñ]h?_' # Salo 4.51
  s.change 'lanta', 'landa' # Salo 4.52
  s.change '[tpkm]', '', '_$' # Salo 4.53-4
  s.change 'th', 't', '_$' # Salo 4.55
  s.change 'ē', 'ī' # Salo 4.56
  s.change 'ê', 'î'
  s.change 'ō', 'ū'
  s.change 'ô', 'û'
  s.change 'j', 'i', '_C'
  s.change '[íî][iī]', 'î' # Salo 4.57
  s.change '[iī][íî]', 'î' # Salo 4.57
  s.change '[iī][iī]', 'ī' # Salo 4.57
  # I exclude Salo's 4.58, ā > ō̧, because it is non-contrastive.
  s.change 'ei', 'ī' # Salo 4.59
  s.change 'éi', 'î' # Salo 4.59
  s.change 'oi', 'ui' # Salo 4.59
  s.change 'ói', 'úi' # Salo 4.59
  s.change 'eu', 'iu' # Salo 4.60
  s.change 'ūi', 'ui' # Salo 4.61
  s.change '[ij]', '', '_ui' # Salo 4.62
  s.change 'n', 'm', '_[\+\-]?[pbm]' # Salo 4.63
  s.change 'n', 'ñ', '_[\+\-]?[kgñ]' # Salo 4.63
  s.change '', 'h', '[lrptk][\-\+]?[ptk]_V' # Salo 4.64
  s.change '', 'h', '^s[tpk]_' # Salo 4.65
  s.change '[lrwj]', devoice, 's_' # Salo 4.66
  s.change 's', '', '^_[LRƕxmn]'
  s.change 's', 'm', '_m'
  s.change 's', 'n', '_n'
  s.change '[LRƕxmn]', geminate, 's_' # Salo 4.70
  s.change 's', '', '_[LRƕxmn]' # Salo 4.70
  s.change 's', 'h', 'V_V' # Salo 4.71
  s.change 's', '', '_($|\+C)' # Salo 4.72-3
  s.change 'wó', 'wá' # Salo 4.74
end

apply_changes(changes)
