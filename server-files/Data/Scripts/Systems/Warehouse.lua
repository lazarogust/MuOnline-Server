Warehouse = {}

function Warehouse.Init()
    GameServerFunctions.RequestWarehouseCost(Warehouse.RequestCost)
    GameServerFunctions.PlayerBuyVaultOk(Warehouse.BuyVault)
end

function Warehouse.RequestCost(aIndex)
    local player = User.new(aIndex)
    local vip = player:getVip()

    if Warehouse_Config.VaultCost[vip] == nil then return end

    if Warehouse_Config.Coins[Warehouse_Config.VaultCost[vip].Coin] == nil then return end

    SendWarehouseCost(aIndex, Warehouse_Config.VaultCost[vip].Price, Warehouse_Config.Coins[Warehouse_Config.VaultCost[vip].Coin].Name)
end

function Warehouse.BuyVault(aIndex)
    local player = User.new(aIndex)
    local playerInfo = Utils.GetPlayerInfo(player)

    local vaultCount = player:getWarehouseCount()

    if Warehouse_Config.MaxVault[playerInfo[4]] == nil or vaultCount >= Warehouse_Config.MaxVault[playerInfo[4]] then
        SendMessage(Warehouse_Config.Message[playerInfo[3]][1], aIndex, 1)
		return
    end

    if Warehouse_Config.VaultCost[playerInfo[4]] == nil then
        SendMessage(Warehouse_Config.Message[playerInfo[3]][2], aIndex, 1)
		return
    end

    if Warehouse_Config.Coins[Warehouse_Config.VaultCost[playerInfo[4]].Coin] == nil then
        SendMessage(Warehouse_Config.Message[playerInfo[3]][2], aIndex, 1)
		return
    end

    local moeda = Warehouse_Config.Coins[Warehouse_Config.VaultCost[playerInfo[4]].Coin]

    local saldo = DataBase.GetValue(moeda.Table, moeda.Column, moeda.Where, playerInfo[moeda.IdType])

    if saldo < Warehouse_Config.VaultCost[playerInfo[4]].Price then
        SendMessage(Warehouse_Config.Message[playerInfo[3]][3], aIndex, 1)
		return
    end

    DataBase.SetDecreaseValue(moeda.Table, moeda.Column, Warehouse_Config.VaultCost[playerInfo[4]].Price, moeda.Where, playerInfo[moeda.IdType])
    DataBase.SetAddValue("Warehouse", "VaultCounts", 1, "AccountID", player:getAccountID())
    player:setWarehouseCount(vaultCount+1)

    SendMessage(Warehouse_Config.Message[playerInfo[3]][4], aIndex, 1)

    UpdateWarehouseCount(aIndex)
end

Warehouse.Init()

return Warehouse