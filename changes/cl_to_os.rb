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

changes = ChangeSequence.new(
  'C' => '[tpkdbglrszhwynmñ]',
  'V' => '[aeiouāēīōūáéíóúâêîôû]',
  '<unstressed vowel>' => '[aeiouāēīōū]',
  '<stressed vowel>' => '[áéíóúâêîôû]',
  '<long vowel>' => '[āēīōūâêîôû]'
) do |s|
  s.change '[āēōaeo]i', 'ī', '_$' # Salo 4.33 TODO: figure out if final diphthongs were long or short at this point
  s.change 'V', stress, '^C<stressed vowel>r_C' # Salo 4.34
  s.change 'V', unstress, '^C_rVC' # Salo 4.34
  s.change '<unstressed vowel>', '', '^C_rVC' # Salo 4.35 TODO: should this be an optional change? Salo says the change applies "frequently" but gives no examples of words in which it does not occur.
  s.change 'mr', 'br', '^_' # Salo 4.36
  s.change 'ñl', 'gl', '^_' # Salo 4.36
  s.change '<long vowel>', shorten, 'VC+_$' # Salo 4.37
  s.change '^ñole$', 'ole', '_' # Salo 4.38
  s.change 'ñ', 'ñg', '^_' # Salo 4.38
  s.change '', 'h', '[lrptk][ptk]_V'
end

apply_changes(changes)
