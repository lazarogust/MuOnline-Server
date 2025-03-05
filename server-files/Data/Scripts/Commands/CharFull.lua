--[[ Sistema CharFull ]]--

CharFull = {}

function CharFull.Command(aIndex, Arguments)
	if CHARFULL_COMMAND_SWITCH == 0
	then
		return
	end
	
	local player = User.new(aIndex)
	
	--if DataBase.GetValue(CHARFULL_TABLE, CHARFULL_COLUMN, CHARFULL_WHERE, player:getAccountID()) >= CHARFULL_MAX_USE 
	--then
	--	SendMessage(string.format("[Sistema] Voce atingiu o limite de uso do comando."), aIndex, 1)
	--	return
	--end
	
	player:setLevel(400)
	player:setStrength(32767)
	player:setDexterity(32767)
	player:setVitality(32767)
	player:setEnergy(32767)

	LevelUpSend(aIndex)
	--DataBase.SetAddValue(CHARFULL_TABLE, CHARFULL_COLUMN, 1, CHARFULL_WHERE, player:getAccountID())
	SendMessage(string.format("[Sistema] Char Full recebido com sucesso."), aIndex, 1)
	return
end

Commands.Register(CHARFULL_COMMAND, CharFull.Command)

return CharFull