require_relative './change'

changes = ChangeSequence.new(
 'V' => '[aeiouāēīōūáéíóúâêîôû]'
) do |s|
  s.change 'V', '', '_$'
  s.change 'ei', 'e', '_b' # cf. edeb instead of edaib TODO: this change might belong before MS.

  # ORTHOGRAPHIC CHANGES:
  s.change 'ñ', 'n'
end

apply_changes(changes)
