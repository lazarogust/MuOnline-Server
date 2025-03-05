Warehouse_Config = {
    MaxVault = {
        [0] = 20,
        [1] = 20,
        [2] = 20,
        [3] = 100,
    },

    VaultCost = {
        [0] = {Coin = 1, Price = 10},
        [1] = {Coin = 1, Price = 10},
        [2] = {Coin = 1, Price = 10},
        [3] = {Coin = 1, Price = 10},
    },

    Coins = {
        [1] = {Name = "Cash", Table = "MEMB_INFO", Column = "cash", Where = "memb___id", IdType = 0},
    },

    Message = {
        ["Por"] = {
            [1] = "Voc� atingiu o limite de ba�s par ao seu tipo de vip",
            [2] = "N�o foi possivel fazer a compra, tente mais tarde",
            [3] = "Voc� n�o possui saldo suficiente para a compra",
            [4] = "Ba� comprado com sucesso",
        },
        ["Eng"] = {
            [1] = "Voc� atingiu o limite de ba�s par ao seu tipo de vip",
            [2] = "N�o foi possivel fazer a compra, tente mais tarde",
            [3] = "Voc� n�o possui saldo suficiente para a compra",
            [4] = "Ba� comprado com sucesso",
        },
        ["Spn"] = {
            [1] = "Voc� atingiu o limite de ba�s par ao seu tipo de vip",
            [2] = "N�o foi possivel fazer a compra, tente mais tarde",
            [3] = "Voc� n�o possui saldo suficiente para a compra",
            [4] = "Ba� comprado com sucesso",
        },
    }
}