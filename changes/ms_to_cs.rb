require_relative './change'

changes = ChangeSequence.new(
 'V' => '[aeiouāēīōūáéíóúâêîôû]'
) do |s|
  s.change 'V', '', '_$'
end

apply_changes(changes)
