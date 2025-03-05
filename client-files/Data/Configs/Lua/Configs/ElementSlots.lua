OpenFolder("Definitions")

--[[
pet = work only in index 0 and 1
pet = funciona s� no index 0 e 1

for a pet to work it is necessary to add it in CharacterHelper.lua
para um pet funcionar � necess�rio adicionar ele no CharacterHelper.lua

active = if is 0 the slot don't will show in game and work!
active = se 0 o slot n�o vai mostrar no jogo e nem funcionar!

slot item.txt: 236 = element 0
slot item.txt: 237 = element 1
slot item.txt: 238 = element 2
slot item.txt: 239 = element 3
--]]

ELEMENT_SLOTS_CONFIG =
{
	{ index = 0, x = 59,  y = 44,  width = 20, height = 20, active = 1, pet = 1 },
	{ index = 1, x = 119, y = 175, width = 20, height = 20, active = 1, pet = 1 },
	{ index = 2, x = 59,  y = 115, width = 20, height = 20, active = 1, pet = 0 },
	{ index = 3, x = 119, y = 115, width = 20, height = 20, active = 1, pet = 0 },
}

function StartLoadElementSlots()
	for i = 1, #ELEMENT_SLOTS_CONFIG do
		local element = ELEMENT_SLOTS_CONFIG[i]

		SetElementSlot(element.index, element.x, element.y, element.width, element.height, element.active, element.pet)
	end
end

StartLoadElementSlots()
