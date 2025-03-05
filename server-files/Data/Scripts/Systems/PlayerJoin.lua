PatentJoin = {}

function PatentJoin.EnterCharacter(aIndex)

	local player = User.new(aIndex)
	
	local Name = player:getName()

	local Resets = DataBase.GetValue("Character", "ResetCount", "Name", Name)
	
	if Resets > 5
	then
		player:setPatent(2)
	
		player:setPatentType(0) --JPG
		--player:setPatentType(1) --BMD

		SendMessage(string.format("Patente > 5"), aIndex, 1)
	elseif Resets < 5
	then
		player:setPatent(1)
	
		player:setPatentType(0) --JPG
		--player:setPatentType(1) --BMD

		SendMessage(string.format("Patente < 5"), aIndex, 1)
	end

	--ViewportCreate(aIndex)

end

--GameServerFunctions.EnterCharacter(PatentJoin.EnterCharacter)

return PatentJoin