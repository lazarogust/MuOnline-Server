NpcRescueItem = {}
--

function NpcRescueItem.Init()	
	if NpcRescueItem_Config.Enabled then
		GameServerFunctions.NpcTalk(NpcRescueItem.NpcTalk)
		GameServerFunctions.GameServerProtocol(NpcRescueItem.Protocol)
		GameServerFunctions.MonsterReload(NpcRescueItem.UpdateNpc)
		Timer.TimeOut(10, NpcRescueItem.UpdateNpc)
	end
end

function NpcRescueItem.UpdateNpc()
	for n = OBJECT_START_MONSTER, MAX_OBJECT_MONSTER do
		local monster = User.new(n)
		if monster:getConnected() > 0
		then
			if monster:getClass() == NpcRescueItem_Config.NpcClass
			then
				monster:setType(3)
			end
		end
	end
end

function NpcRescueItem.NpcTalk(Npc, aIndex)
	local m = User.new(Npc)
	local class = m:getClass()

	if NpcRescueItem_Config.NpcClass ~= class then return 0 end

	local player = User.new(aIndex)

	if player:getCacheInt("RescueItemDelay") >= os.time() then
		ChatTargetSend(Npc, NpcRescueItem_Config.Message[player:getLanguage()][1], aIndex)
		return 1
	end

	player:setCacheInt("RescueItemDelay", os.time()+5)

	if NpcRescueItem.SendItemList(player) == 0  then
		ChatTargetSend(Npc, NpcRescueItem_Config.Message[player:getLanguage()][2], aIndex)
	end

	return 1
end

function NpcRescueItem.Protocol(aIndex, Packet, PacketName)
	if Packet ~= NpcRescueItem_Config.Packet then return false end

	local player = User.new(aIndex)
	local playerInfo = Utils.GetPlayerInfo(player)

	if PacketName == string.format("2-%s-%d", playerInfo[1], playerInfo[2]) then
		local listID = GetDwordPacket(PacketName, -1)
		ClearPacket(PacketName)

		NpcRescueItem.Withdraw(playerInfo, listID)
		return true
	end
end

function NpcRescueItem.SendItemList(player)
	local playerInfo = Utils.GetPlayerInfo(player)

	local Query = string.format("select count(ListID) as totalItens from RescueItem where AccountID = '%s' and Retirado = 0", playerInfo[0])

	local ret = db:exec(Query)

	if ret == 0 then db:clear() return 0 end

	local nFecth = db:fetch()

	if nFecth == 100 then db:clear() return 0 end

	local itemCount = db:getInt("totalItens")

	db:clear()

	if itemCount == 0 then return 0 end

	Query = string.format("SELECT top 50 * FROM RescueItem WHERE AccountID = '%s' and Retirado = 0 ORDER BY ListID ASC", playerInfo[0])

	ret = db:exec(Query)

	if ret == 0 then db:clear() return 0 end

	nFecth = db:fetch()

	if nFecth == 100 then db:clear() return 0 end

	local itens = {}
	while nFecth ~= 100 do
		local ListID = db:getInt("ListID")
		local ItemIndex = db:getInt("ItemIndex")
		local Level = db:getInt("Level")
		local Durabilidade = db:getInt("Durabilidade")
		local Skill = db:getInt("Skill")
		local Luck = db:getInt("Luck")
		local Opt = db:getInt("Opt")
		local Excelente = db:getInt("Excelente")
		local Ancient = db:getInt("Ancient")
		local Harmony = db:getInt("Harmony")
		table.insert(itens, {ListID = ListID, ItemIndex = ItemIndex, Level = Level, Durabilidade = Durabilidade, Skill = Skill, Luck = Luck, Opt = Opt, Excelente = Excelente, Ancient = Ancient, Harmony = Harmony})
		nFecth = db:fetch()
	end

	db:clear()

	local PacketName = string.format("1-%s-%d", playerInfo[1], playerInfo[2])
	CreatePacket(PacketName, NpcRescueItem_Config.Packet)
	SetWordPacket(PacketName, itemCount)
	SetBytePacket(PacketName, #itens)
	for i, item in ipairs(itens) do
		SetDwordPacket(PacketName, item.ListID)
		SetWordPacket(PacketName, item.ItemIndex)
		SetBytePacket(PacketName, item.Level)
		SetBytePacket(PacketName, item.Durabilidade)
		SetBytePacket(PacketName, item.Skill)
		SetBytePacket(PacketName, item.Luck)
		SetBytePacket(PacketName, item.Opt)
		SetBytePacket(PacketName, item.Excelente)
		SetBytePacket(PacketName, item.Ancient)
		SetBytePacket(PacketName, item.Harmony)
		local x, y, w, h = 350, 100, 0, 0
		if NpcRescueItem_Config.Position[item.ItemIndex] ~= nil then
			x, y, w, h = NpcRescueItem_Config.Position[item.ItemIndex].X, NpcRescueItem_Config.Position[item.ItemIndex].Y, NpcRescueItem_Config.Position[item.ItemIndex].W, NpcRescueItem_Config.Position[item.ItemIndex].H
		end
		SetWordPacket(PacketName, x)
		SetWordPacket(PacketName, y)
		SetWordPacket(PacketName, w)
		SetWordPacket(PacketName, h)
	end
	SendPacket(PacketName, playerInfo[2])
	ClearPacket(PacketName)
end

function NpcRescueItem.Withdraw(playerInfo, listID)
	local withdrawResult = 0
	local item = {}

	local Query = string.format("Select * from RescueItem where AccountID = '%s' and Retirado = 0 and ListID = %d", playerInfo[0], listID)

	local ret = db:exec(Query)

	if ret == 0 then db:clear() goto bypassquery end

	if db:fetch() == 100 then db:clear() goto bypassquery end

	item.ItemIndex = db:getInt("ItemIndex")
	item.Level = db:getInt("Level")
	item.Durabilidade = db:getInt("Durabilidade")
	item.Skill = db:getInt("Skill")
	item.Luck = db:getInt("Luck")
	item.Opt = db:getInt("Opt")
	item.Excelente = db:getInt("Excelente")
	item.Ancient = db:getInt("Ancient")
	item.Harmony = db:getInt("Harmony")
	item.Dias = db:getInt("Dias")

	db:clear()

	withdrawResult = 1

	::bypassquery::

	if withdrawResult == 1 then
		if InventoryCheckSpaceByItem(playerInfo[2], item.ItemIndex) ~= 0 then
			CreateItemInventory(playerInfo[2], item.ItemIndex, item.Level, item.Durabilidade, item.Skill, item.Luck, item.Opt, item.Excelente, item.Ancient, item.Harmony, 255, 255, 255, 255, 255, 255, item.Dias)
			db:exec(string.format("UPDATE RescueItem set Retirado = 1, DataRetirado = GETDATE() WHERE AccountID = '%s' and Retirado = 0 and ListID = %d", playerInfo[0], listID))
			db:clear()
		else
			withdrawResult = 2
		end
	end
	local PacketName = string.format("3-%s-%d", playerInfo[1], playerInfo[2])
	CreatePacket(PacketName, NpcRescueItem_Config.Packet)
	SetBytePacket(PacketName, withdrawResult)
	SendPacket(PacketName, playerInfo[2])
	ClearPacket(PacketName)
end

function NpcRescueItem.InsertItem(Account, ItemIndex, Level, Dur, Skill, Luck, Opt, Exc, Ancient, Harmony, Dias)
	db:exec(string.format("INSERT INTO RescueItem (AccountID, ItemIndex, Level, Durabilidade, Skill, Luck, Opt, Excelente, Ancient, Harmony, Dias, DataAdicionado) VALUES ('%s', %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, GETDATE())", Account, ItemIndex, Level, Dur, Skill, Luck, Opt, Exc, Ancient, Harmony, (Dias*86400)))
	db:clear()


	
end

NpcRescueItem.Init()

return NpcRescueItem