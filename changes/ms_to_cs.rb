require_relative './change'

changes = ChangeSequence.new(
  'C' => '[tpkdbgðvʒlrszhwynmñ]',
  'V' => '[aeiouāēīōūáéíóúâêîôû]'
) do |s|
  s.change 'V', '', '_$'
  s.change 'h', '', 'V_$'
  s.change 'ei', 'e', '_b' # cf. edeb instead of edaib TODO: this change might belong before MS.
  s.change 'ei', 'ai', '_C$'

  # ORTHOGRAPHIC CHANGES:
  s.change 'ñ', 'n'
end

apply_changes(changes)
