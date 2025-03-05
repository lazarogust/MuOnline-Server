--Configuração do sistema
DeathChangeConfigs = {

    Switch = true,
    IncreaseCommand = "/addkill",
	DecreaseCommand = "/removekill",
	
	CheckAuth = {
	"teste",
	"hyon",
	}
}
--Fim configurações



--System
DeathChange = {}

function DeathChange.CheckAuth(aIndex)
    local p = User.new(aIndex)
    local accountID = p:getAccountID()

    for _, authLogin in ipairs(DeathChangeConfigs.CheckAuth) do
        if authLogin == accountID then
		    p = nil
            return true
        end
    end

    p = nil
    return false
end

function DeathChange.IncreaseKill(aIndex, Arguments)
    local p = User.new(aIndex)
    local pInv = Inventory.new(aIndex)
	local ItemIndex = pInv:getIndex(12)
	local Serial = pInv:getSerial(12)

    if DeathChange.CheckAuth(aIndex) and Serial ~= 0 then
        if ItemIndex >= GET_ITEM(0, 0) and ItemIndex <= GET_ITEM(3, 511) then
	    	local aValue = command:getNumber(Arguments, 1)
	    	
	    	if aValue <= 0 then
	    	    SendMessage(string.format("[DeathSystem] Você precisa digitar um valor maior que 0"), aIndex, 38)
	    		pInv = nil
	    	    return 
	    	end
	    	
	        InsertCounter(aIndex, 12, aValue)
	        UpdateCounter(aIndex)
            SendMessage(string.format("[DeathSystem] %d mortes adicionadas com sucesso", aValue), aIndex, 37)
	    	LogAddC(2, string.format("[%s] Adicionou %d mortes (Serial do Item: %s)", p:getName(), aValue, Serial))
	    	pInv = nil
	    else
	        SendMessage(string.format("[DeathSystem] Obrigatório algum item com contador ativo no 1º slot do inventário"), aIndex, 38)
	    	pInv = nil
	    end
    end
end

function DeathChange.DecreaseKill(aIndex, Arguments)
    local p = User.new(aIndex)
    local pInv = Inventory.new(aIndex)
	local ItemIndex = pInv:getIndex(12)
	local Serial = pInv:getSerial(12)

    if DeathChange.CheckAuth(aIndex) then
        if ItemIndex >= GET_ITEM(0, 0) and ItemIndex <= GET_ITEM(3, 511) then
	    	local aValue = command:getNumber(Arguments, 1)
	    	
	    	local bValue = DataBase.GetValue("DeathSystem", "Deaths", "m_Serial", Serial)
	    	if aValue <= 0 then
	    	    SendMessage(string.format("[DeathSystem] Você precisa digitar um valor maior que 0"), aIndex, 38)
	    		pInv = nil
	    	    return 
	    	end
	    	
	    	if bValue >= aValue then
	            DecreaseCounter(aIndex, 12, aValue)
	    		SendMessage(string.format("[DeathSystem] %d mortes removidas com sucesso", aValue), aIndex, 37)
	    		LogAddC(2, string.format("[%s] Removeu %d mortes (Serial do Item: %s)", p:getName(), aValue, Serial))
	    	else
	    	    DecreaseCounter(aIndex, 12, bValue)
	    		SendMessage(string.format("[DeathSystem] %d mortes removidas com sucesso", bValue), aIndex, 37)
	    		LogAddC(2, string.format("[%s] Removeu %d mortes (Serial do Item: %s)", p:getName(), bValue, Serial))
	    	end
	    	
	        UpdateCounter(aIndex)
	    	pInv = nil
	    else
	        SendMessage(string.format("[DeathSystem] Obrigatório algum item com contador ativo no 1º slot do inventário"), aIndex, 38)
	    	pInv = nil
	    end
	end
end

function DeathChange.Init()
    if not DeathChangeConfigs.Switch then return end
    Commands.Register(DeathChangeConfigs.IncreaseCommand, DeathChange.IncreaseKill)
	Commands.Register(DeathChangeConfigs.DecreaseCommand, DeathChange.DecreaseKill)
end

DeathChange.Init()
return DeathChange