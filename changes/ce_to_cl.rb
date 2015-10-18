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
  '<long vowel>' => '[āēīōūâêîôû]',
  '<back vowel>' => '[aouāōūáóúâôû]',
  '<front vowel>' => '[eiēīéíêî]'
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
  s.change 'j', 'i', 'V\+_' # Salo 4.20
  s.change 'V', '', '_\+V' # Salo 4.19
  s.change '(CC?)V\1', haplology, 'V_V' # Salo 4.21
  s.change 'ñkw', 'mp', '_' # Salo 4.23
  s.change 'kw', 'p', '_' # Salo 4.23
  s.change 'ñgw', 'mb', '_' # Salo 4.23
  s.change 'b', 'w', '_d' # Salo 4.24 TODO: could maybe be moved to CT->OS
  s.change 'g', 'w', '<back vowel>_d' # Salo 4.25 TODO: could maybe be moved to CT->OS
  s.change 'g', 'j', '<front vowel>_d' # Salo 4.26
  s.change 'z', 'j', '_[dbg]' # Salo 4.27
  s.change 'iw', 'jū', '[tdlsn]|th_' # Salo 4.28
  s.change 'j', '', '^[tdlsn]_' # Salo 4.30
  s.change 'm', 'n', '_[jw]' # Salo 4.31
  s.change 'j', 'i', '_V' # Salo 4.32
end

apply_changes(changes)
