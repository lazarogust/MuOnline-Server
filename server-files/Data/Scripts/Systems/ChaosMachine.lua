--[[
Configs
]]--

local CHAOS_BOX_GENESIS_MONSTER_ID = 249
local CHAOS_BOX_GENESIS_MONSTER_MAP = 3
local CHAOS_BOX_GENESIS_MONSTER_MAPX = 185
local CHAOS_BOX_GENESIS_MONSTER_MAPY = 105

local CHAOS_MACHINE_CONFIG_COMB_SELECTION = {
	{ Combination = 1, CombinationSuccessRate = 100.0, CombinationName = "Set Dragon Knight - FULL" },
	{ Combination = 2, CombinationSuccessRate = 100.0, CombinationName = "Set Venon Mist - FULL" },
}

local CHAOS_MACHINE_CONFIG_COMB_INGREDIENTS = { }

CHAOS_MACHINE_CONFIG_COMB_INGREDIENTS[1] = {
	{ Level = -1, Exc = -1, Luck = 0, Life = 0, Skill = 0, Quantity = 1, ItemIndex = GET_ITEM(12, 15), ItemName = "Jewel of Chaos" },
	--{ Level = -1, Exc = -1, Luck = 0, Life = 0, Skill = 0, Quantity = 2, ItemIndex = GET_ITEM(14, 14), ItemName = "Jewel of Soul" },
	--{ Level = -1, Exc = -1, Luck = 0, Life = 0, Skill = 0, Quantity = 8, ItemIndex = GET_ITEM(14, 13), ItemName = "Jewel of Bless" },
	--{ Level = -1, Exc = -1, Luck = 0, Life = 0, Skill = 0, Quantity = 4, ItemIndex = GET_ITEM(14, 16), ItemName = "Jewel of Life" },
	--{ Level = -1, Exc = -1, Luck = 0, Life = 0, Skill = 0, Quantity = 3, ItemIndex = GET_ITEM(14, 22), ItemName = "Jewel of Creation" },
	--{ Level = -1, Exc = -1, Luck = 0, Life = 0, Skill = 0, Quantity = 2, ItemIndex = GET_ITEM(0, 0), ItemName = "Kriss" },
	--[[{ Level = -1, Exc = -1, Luck = 1, Life = 7, Skill = 0, Quantity = 2, ItemIndex = GET_ITEM(7, 0), ItemName = "Bronze Helm" },
	{ Level = -1, Exc = -1, Luck = 0, Life = 0, Skill = 0, Quantity = 2, ItemIndex = GET_ITEM(8, 0), ItemName = "Bronze Armor" },
	{ Level = -1, Exc = -1, Luck = 0, Life = 0, Skill = 0, Quantity = 2, ItemIndex = GET_ITEM(9, 0), ItemName = "Bronze Pants" },
	{ Level = -1, Exc = -1, Luck = 0, Life = 0, Skill = 0, Quantity = 2, ItemIndex = GET_ITEM(10, 0), ItemName = "Bronze Gloves" },
	{ Level = -1, Exc = -1, Luck = 0, Life = 0, Skill = 0, Quantity = 2, ItemIndex = GET_ITEM(11, 0), ItemName = "Bronze Boots" },--]]
}

CHAOS_MACHINE_CONFIG_COMB_INGREDIENTS[2] = {
	{ Level = -1, Exc = -1, Luck = 0, Life = 0, Skill = 0, Quantity = 1, ItemIndex = GET_ITEM(12, 15), ItemName = "Jewel of Chaos" },
}

local CHAOS_MACHINE_CONFIG_COMB_ITEM_REWARD = { }

CHAOS_MACHINE_CONFIG_COMB_ITEM_REWARD[1] = {
	{ ItemIndex = GET_ITEM(7, 29), Level = 15, Dur = 255, Skill = 1, Luck = 1, Life = 7, Exc = 63, Op380 = 1, Ancient = 0, JoH = 0, Socket = 0, timer = 0},
	{ ItemIndex = GET_ITEM(8, 29), Level = 15, Dur = 255,  Skill = 1, Luck = 1, Life = 7, Exc = 63, Op380 = 1, Ancient = 0, JoH = 0, Socket = 0, timer = 0},
	{ItemIndex = GET_ITEM(9, 29), Level = 15, Dur = 255,  Skill = 1, Luck = 1, Life = 7, Exc = 63, Op380 = 1, Ancient = 0, JoH = 0, Socket = 0, timer = 0},
	{ ItemIndex = GET_ITEM(10, 29), Level = 15, Dur = 255,  Skill = 1, Luck = 1, Life = 7, Exc = 63, Op380 = 1, Ancient = 0, JoH = 0, Socket = 0, timer = 0},
	{ ItemIndex = GET_ITEM(11, 29), Level = 15, Dur = 255,  Skill = 1, Luck = 1, Life = 7, Exc = 63, Op380 = 1, Ancient = 0, JoH = 0, Socket = 0, timer = 0},
}

CHAOS_MACHINE_CONFIG_COMB_ITEM_REWARD[2] = {
	{ ItemIndex = GET_ITEM(7, 30), Level = 15, Dur = 255,  Skill = 1, Luck = 1, Life = 7, Exc = 63, Op380 = 1, Ancient = 0, JoH = 0, Socket = 0, timer = 0},
	{ ItemIndex = GET_ITEM(8, 30), Level = 15, Dur = 255,  Skill = 1, Luck = 1, Life = 7, Exc = 63, Op380 = 1, Ancient = 0, JoH = 0, Socket = 0, timer = 0},
	{ ItemIndex = GET_ITEM(9, 30), Level = 15, Dur = 255,  Skill = 1, Luck = 1, Life = 7, Exc = 63, Op380 = 1, Ancient = 0, JoH = 0, Socket = 0, timer = 0},
	{ ItemIndex = GET_ITEM(10, 30), Level = 15, Dur = 255,  Skill = 1, Luck = 1, Life = 7, Exc = 63, Op380 = 1, Ancient = 0, JoH = 0, Socket = 0, timer = 0},
	{ ItemIndex = GET_ITEM(11, 30), Level = 15, Dur = 255,  Skill = 1, Luck = 1, Life = 7, Exc = 63, Op380 = 1, Ancient = 0, JoH = 0, Socket = 0, timer = 0},
}

CHAOS_MACHINE_MESSAGES = { }

CHAOS_MACHINE_MESSAGES["Por"] = {
[1] = "Falta itens para a combina��o!",
[2] = "Ocorreu algum erro de configura��o desse mix!",
[3] = "Sua combina��o falhou!",
[4] = "Sua combina��o foi bem sucedida!",
}

CHAOS_MACHINE_MESSAGES["Eng"] = {
[1] = "Missing items for the combination!",
[2] = "There was an error in the configuration of this mix!",
[3] = "Your combination failed!",
[4] = "Your combination was successful!",
}

CHAOS_MACHINE_MESSAGES["Spn"] = {
[1] = "�Elementos faltantes para la combinaci�n!",
[2] = "�Hubo un error en la configuraci�n de esta mezcla!",
[3] = "�Tu combinaci�n fall�!",
[4] = "�Tu combinaci�n fue exitosa!",
}

--[[
System don't touch
--]]

ChaosMachineGenesis = { }

local ChaosMachineIngredients = { }
local ChaosMachineItensReward = { }

function ChaosMachineGenesis.NpcTalk(NpcIndex, PlayerIndex)
	local npc = User.new(NpcIndex)
	local player = User.new(PlayerIndex)
	local map = npc:getMapNumber()
	local x = npc:getX()
	local y = npc:getY()
	
	if (npc:getClass() == CHAOS_BOX_GENESIS_MONSTER_ID and map == CHAOS_BOX_GENESIS_MONSTER_MAP and x == CHAOS_BOX_GENESIS_MONSTER_MAPX and y == CHAOS_BOX_GENESIS_MONSTER_MAPY)
	then
		OpenChaosMachineGenesis(PlayerIndex)
	end
	
	npc = nil
	
end

function ChaosMachineGenesis.SetIngredientItens(key)
	if CHAOS_MACHINE_CONFIG_COMB_INGREDIENTS[key] == nil
	then
		return
	end

	local value = 1
	
	for i in ipairs(CHAOS_MACHINE_CONFIG_COMB_INGREDIENTS[key]) do
		ChaosMachineIngredients[value] = { Ingredients = CHAOS_MACHINE_CONFIG_COMB_INGREDIENTS[key][i] }
		
		value = value + 1
	end
end

function ChaosMachineGenesis.SetRewardItens(key)
	if CHAOS_MACHINE_CONFIG_COMB_ITEM_REWARD[key] == nil
	then
		return
	end

	local value = 1
	
	for i in ipairs(CHAOS_MACHINE_CONFIG_COMB_ITEM_REWARD[key]) do
		ChaosMachineItensReward[value] = { Rewards = CHAOS_MACHINE_CONFIG_COMB_ITEM_REWARD[key][i] }
		
		value = value + 1
	end
end

function ChaosMachineGenesis.CheckItens(item, ItemIndex, Quantity, Level, Exc, Luck, Skill, Life)
	local itemFind = 0
	local itemQuantity = 0

	if item == nil
	then
		return 0
	end
	
	for i = 0, 119 do
		if item:isItem(i) == 0
		then
			goto continue
		end

		if item:getIndex(i) ~= ItemIndex
		then
			goto continue
		end

		if Exc ~= -1
		then
			if item:getItemTable(i, 1) <= 0
			then
				goto continue
			end
		end

		if Luck ~= 0
		then
			if item:getItemTable(i, 3) <= 0
			then
				goto continue 
			end
		end

		if Skill ~= 0
		then
			if item:getItemTable(i, 2) <= 0
			then
				goto continue 
			end
		end

		if Life ~= 0
		then
			if item:getItemTable(i, 4) < Life
			then
				goto continue 
			end
		end

		if (Level == -1 or item:getLevel(i) == Level)
		then
			itemFind = 1

			if GetStackItem(item:getIndex(i)) ~= 0
			then
				itemQuantity = itemQuantity + item:getDurability(i)
			else
				itemQuantity = itemQuantity + 1
			end
		end

		::continue::
	end
	
	--clear stack from muserver
	collectgarbage()
	
	if itemFind == 1 and itemQuantity == Quantity
	then
		return 1
	end
	
	return 0
end

function ChaosMachineGenesis.CheckCanMix(player)
	local itemMissing = 0

	local chaosMachineGenesis = ChaosBoxGenesis.new(player:getIndex())
	
	for i in ipairs(ChaosMachineIngredients) do
		local itens = ChaosMachineIngredients[i].Ingredients
		
		if itens ~= nil
		then
			if ChaosMachineGenesis.CheckItens(chaosMachineGenesis, itens.ItemIndex, itens.Quantity, itens.Level, itens.Exc, itens.Luck, itens.Skill, itens.Life) == 0
			then
				itemMissing = itemMissing + 1
			end
		end
	end

	chaosMachineGenesis = nil
	
	if itemMissing == 0
	then
		return 1
	end
	
	return 0
end

function ChaosMachineGenesis.getSerialForNewItem()
	--local db = DataBase.getDb()
	
	db:exec('EXEC WZ_GetItemSerial')
	
	if db:fetch() ~= SQL_NO_DATA
	then
		local result = db:getResult(1)
		db:clear()
		return result
	else
		db:clear()
		return -1
	end
end

function ChaosMachineGenesis.CombFail(player)
	ChaosBoxGenesisInit(player:getIndex())
	
	ChaosBoxGenesisMixSend(player:getIndex(), 2)
	
	player:setChaosBoxGenesisState(2)
	
	ChaosBoxGenesisItemListSend(player:getIndex())

	SaveChaosBoxGenesis(player:getIndex())
end

function ChaosMachineGenesis.CombSucess(player)
	ChaosBoxGenesisInit(player:getIndex())
	
	ChaosBoxGenesisMixSend(player:getIndex(), 1)
	
	player:setChaosBoxGenesisState(1)

	
	--insert itens
	for i in ipairs(ChaosMachineItensReward) do
		local itens = ChaosMachineItensReward[i].Rewards
		
		if itens ~= nil
		then
			local serial = ChaosMachineGenesis.getSerialForNewItem()
			
			if serial ~= -1
			then
				ChaosBoxGenesisCreateItem(player:getIndex(), itens.ItemIndex, itens.Level, itens.Dur, itens.Skill, itens.Luck, itens.Life, itens.Exc, itens.Op380, itens.Ancient, itens.JoH, itens.Socket, itens.timer, serial)
			end
		end
	end
	
	ChaosBoxGenesisItemListSend(player:getIndex())

	SaveChaosBoxGenesis(player:getIndex())
end

function ChaosMachineGenesis.Mixar(aIndex)
	local player = User.new(aIndex)
	local Language = player:getLanguage()

	if player:getChaosBoxGenesisState() ~= 0
	then
		return
	end

	ChaosMachineIngredients = { }
	
	ChaosMachineGenesis.SetIngredientItens(player:getChaosBoxGenesisSelectedComb())
	
	ChaosMachineItensReward = { }
	
	ChaosMachineGenesis.SetRewardItens(player:getChaosBoxGenesisSelectedComb())
	
	if (ChaosMachineGenesis.CheckCanMix(player) == 0)
	then
		SendMessage(string.format(CHAOS_MACHINE_MESSAGES[Language][1]), player:getIndex(), 1)
		return
	end

	local MixInfo = CHAOS_MACHINE_CONFIG_COMB_SELECTION[player:getChaosBoxGenesisSelectedKey()]
	
	if MixInfo == nil
	then
		SendMessage(string.format(CHAOS_MACHINE_MESSAGES[Language][2]), player:getIndex(), 1)
		return
	end

	math.randomseed(os.time())
	
	local randValue = math.random(0, 100)
	
	if MixInfo.CombinationSuccessRate < randValue
	then
		ChaosMachineGenesis.CombFail(player, mixInfo)
		
		SendMessage(string.format(CHAOS_MACHINE_MESSAGES[Language][3]), player:getIndex(), 1)
	else
		ChaosMachineGenesis.CombSucess(player)
		
		SendMessage(string.format(CHAOS_MACHINE_MESSAGES[Language][4]), player:getIndex(), 1)
	end
	
	collectgarbage()
end

GameServerFunctions.NpcTalk(ChaosMachineGenesis.NpcTalk)
GameServerFunctions.ChaosMachineGenesisMix(ChaosMachineGenesis.Mixar)

return ChaosMachineGenesis