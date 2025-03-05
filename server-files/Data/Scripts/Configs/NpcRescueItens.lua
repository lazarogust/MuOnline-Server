
NpcRescueItem_Config = {
	Enabled = true,

	Packet = 22,

	NpcClass = 254,

	Position = {},

	Message = {
		["Por"] = {
			[1] = "Calma, estou procurando seus itens",
			[2] = "Não tenho nada para você aqui",
		},

		["Eng"] = {
			[1] = "Hold on, i'm looking for your itens",
			[2] = "I have nothing for you here",
		},

		["Spn"] = {
			[1] = "Espera, estoy buscando tus itens",
			[2] = "No tengo nada para ti aquí",
		}
	}
}

for ALL = 0, 512 do
	NpcRescueItem_Config.Position[Utils.GetItem(0, ALL)] = {X = 330, Y = 45, W = 40, H = 90}  --SWORD
	NpcRescueItem_Config.Position[Utils.GetItem(1, ALL)] = {X = 330, Y = 60, W = 45, H = 90}  --SCEPTER
	NpcRescueItem_Config.Position[Utils.GetItem(3, ALL)] = {X = 330, Y = 60, W = 45, H = 90}  --HAMMER
	NpcRescueItem_Config.Position[Utils.GetItem(4, ALL)] = {X = 330, Y = 85, W = 45, H = 55}  --BOW
	NpcRescueItem_Config.Position[Utils.GetItem(5, ALL)] = {X = 330, Y = 60, W = 45, H = 90}  --STAFF
	NpcRescueItem_Config.Position[Utils.GetItem(6, ALL)] = {X = 330, Y = 80, W = 45, H = 55}  --SHIELD
	NpcRescueItem_Config.Position[Utils.GetItem(7, ALL)] = {X = 335, Y = 65, W = 45, H = 55}  --HELM
	NpcRescueItem_Config.Position[Utils.GetItem(8, ALL)] = {X = 335, Y = 75, W = 45, H = 55}  --ARMOR
	NpcRescueItem_Config.Position[Utils.GetItem(9, ALL)] = {X = 335, Y = 75, W = 45, H = 55}  --PANTS
	NpcRescueItem_Config.Position[Utils.GetItem(10,ALL)] = {X = 335, Y = 75, W = 45, H = 55}  --GLOVES 
	NpcRescueItem_Config.Position[Utils.GetItem(11,ALL)] = {X = 335, Y = 75, W = 45, H = 55}  --BOOTS 
	NpcRescueItem_Config.Position[Utils.GetItem(12,ALL)] = {X = 335, Y = 75, W = 45, H = 55}  --WINGS/CAPAS
	NpcRescueItem_Config.Position[Utils.GetItem(13,ALL)] = {X = 330, Y = 80, W = 45, H = 55}  --PET'S/RINGS
	NpcRescueItem_Config.Position[Utils.GetItem(14,ALL)] = {X = 330, Y = 80, W = 45, H = 55}  --ESPECIAL
	NpcRescueItem_Config.Position[Utils.GetItem(15,ALL)] = {X = 330, Y = 80, W = 45, H = 55}  --ESPECIAL2
end

return NpcRescueItem_Config