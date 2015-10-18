require_relative './change'

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

voice = -> (c) {
  {
    't' => 'd',
    'p' => 'b',
    'c' => 'g',
  }[c] || c
}

changes = ChangeSequence.new(
  'C' => '[tpkdbglrszhwynmñ]',
  'V' => '[aeiouāēīōūáéíóúâêîôû]' # TODO: trim this set if stress is no longer marked in MS
) do |s|
  s.change '[áéíóúâêîôû]', remove_stress_marking, '_'
  s.change 'k', 'c', '_'
  s.change '', 'i', 'V_C+i$' # Salo 4.99
  s.change 'a', 'e', '_i'
  s.change 'a', 'e', '_C+V?i'
  s.change '[tpc]', voice, 'V_V'
end

apply_changes(changes)
