PatenteTest = {}

function PatenteTest.PatenteBmd(aIndex, Arguments)

    local player = User.new(aIndex)

	player:setPatent(2)
	
	player:setPatentType(0) --BMD

	SendMessage(string.format("bmd"), aIndex, 1)

end

function PatenteTest.PatenteJpg(aIndex, Arguments)

    local player = User.new(aIndex)
	
	local aValue = command:getNumber(Arguments, 1)

	player:setPatent(aValue)
	
	player:setPatentType(0) --BMD
	
	ViewportCreate(aIndex)

	SendMessage(string.format("%d", aValue), aIndex, 1)

end

Commands.Register("/patentebmd", PatenteTest.PatenteBmd)
Commands.Register("/patentejpg", PatenteTest.PatenteJpg)


return PatenteTest