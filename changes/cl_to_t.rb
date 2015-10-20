require './change'

changes = ChangeSequence.new(
  'C' => '[tpkdbglrszhwjnmñ]',
  'V' => '[aeiouāēīōūáéíóúâêîôû]',
  '<unstressed vowel>' => '[aeiouāēīōū]',
  '<stressed vowel>' => '[áéíóúâêîôû]',
  '<long vowel>' => '[āēīōūâêîôû]',
  '<short vowel>' => '[aeiouáéíóú]'
) do |s|
  s.change '[tpk]', $voice, '_h'
  s.change 'h', '', '[dbg]_'
  s.change '<long vowel>', $shorten, '_$'
  s.change '<stressed vowel>', $remove_stress_marking
end

apply_changes changes
