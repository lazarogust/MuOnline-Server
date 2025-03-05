Quest = {}

function Quest.Init()
    if Quest_Config.Enabled then
        InterfaceController.MainProc(Quest.Interface)
        InterfaceController.ClientProtocol(Quest.Protocol)
        InterfaceController.MainProcWorldKey(Quest.KeyListener)
        InterfaceController.InterfaceClickEvent(Quest.ClickEvent)
        InterfaceController.UpdateProc(Quest.Update)
        InterfaceController.UpdateMouse(Quest.Update)
        InterfaceController.UpdateKey(Quest.Update)
        Quest.Define()
    end
end

function Quest.Define()
    Quest_Config.QuestName = "Quest"
    Quest_Config.QuestDescription = "-"
    Quest_Config.QuestValidade = "-"
    Quest_Config.Window = {PosX = 450, PosY = 0, Width = 190, Height = 429}
    Quest_Config.Objectives = {}
    Quest_Config.Rewards = {}
    Quest_Config.RewardEnabled = 1
    Quest_Config.AlertOpen = false
    Quest_Config.AlertType = 2
    Quest_Config.Button = {}
    Quest_Config.ButtonID = {
        fechar = 1,
        resgatar = 2,
        aba1 = 3,
        aba2 = 4,

    }
    Quest_Config.Aba = 1
end

function Quest.CheckOpen()
    if UICustomInterface == Quest_Config.WindowID then return true else return false end
end

function Quest.Open()
    CloseWindow(UIInventory)
    CloseWindow(UICharacter)
    CloseWindow(UIParty)
    CloseWindow(UIFriendList)
	CloseWindow(UIMoveList)
	CloseWindow(UIQuest)
	CloseWindow(UIGuildNpc)
	CloseWindow(UITrade)
	CloseWindow(UIGuild)
	CloseWindow(UIWarehouse)
	CloseWindow(UIChaosBox)
	CloseWindow(UICommandWindow)
	CloseWindow(UIPetInfo)
	CloseWindow(UIShop)
	CloseWindow(UIStore)
	CloseWindow(UIOtherStore)
	CloseWindow(UIOptions)
	CloseWindow(UIHelp)
	CloseWindow(UIFastDial)
	CloseWindow(UISkillTree)
	CloseWindow(UINPC_Titus)
	CloseWindow(UICashShop)
	CloseWindow(UIFullMap)
	CloseWindow(UINPC_Dialog)
	CloseWindow(UIGensInfo)
	CloseWindow(UINPC_Julia)
    Quest_Config.Window.PosX = WindowGetWidth()-190
    UICustomInterface = Quest_Config.WindowID
    SetLockInterfaces()
end

function Quest.Close()
    UICustomInterface = 0
    Quest.Define()
    Quest_Config.Window.PosX = WindowGetWidth()-190
    SetUnlockInterfaces()
end

function Quest.CreateButton(ButtonID, x, y, w, h)
	if Quest_Config.Button[ButtonID] == nil then
		table.insert(Quest_Config.Button, ButtonID)
		Quest_Config.Button[ButtonID] = {
			x = x,
			y = y,
			w = w,
			h = h,
			clicked = false,
			timer = 0
		}
	else
		Quest_Config.Button[ButtonID].x = x
		Quest_Config.Button[ButtonID].y = y
		Quest_Config.Button[ButtonID].w = w
		Quest_Config.Button[ButtonID].h = h
	end
end

function Quest.ButtonClicked(ButtonID)
	if Quest_Config.Button[ButtonID] == nil then return false end
	if Quest_Config.Button[ButtonID].clicked then
		if Quest_Config.Button[ButtonID].timer >= 2 then
			Quest_Config.Button[ButtonID].timer = 0
			Quest_Config.Button[ButtonID].clicked = false
			return false
		end
		Quest_Config.Button[ButtonID].timer = Quest_Config.Button[ButtonID].timer + 1
		return true
	end
	return false
end

function Quest.ButtonMouseOver(ButtonID, x, y)
	if Quest_Config.Button[ButtonID] == nil then return false end
	if x >= Quest_Config.Button[ButtonID].x and x <= (Quest_Config.Button[ButtonID].x+Quest_Config.Button[ButtonID].w) then
		if y >= Quest_Config.Button[ButtonID].y and y <= (Quest_Config.Button[ButtonID].y+Quest_Config.Button[ButtonID].h) then
			return true
		end
	end
	return false
end

function Quest.Interface()
    if not Quest.CheckOpen() then return end

    Quest.CreateButton(Quest_Config.ButtonID.fechar,0, 0, 0, 0)
    Quest.CreateButton(Quest_Config.ButtonID.resgatar, 0, 0, 0, 0)
    Quest.CreateButton(Quest_Config.ButtonID.aba1, Quest_Config.Window.PosX+23, 74, 68, 20)
    Quest.CreateButton(Quest_Config.ButtonID.aba2, Quest_Config.Window.PosX+93, 74, 68, 20)

    EnableAlphaTest()

    RenderImage(31319, Quest_Config.Window.PosX , Quest_Config.Window.PosY, Quest_Config.Window.Width, Quest_Config.Window.Height)

    SetFontType(1)
	SetTextBg(0, 0, 0, 0)
	SetTextColor(255, 255, 255, 240)
    RenderText3(Quest_Config.Window.PosX, 10, Quest_Config.QuestName, Quest_Config.Window.Width, 3)
    SetFontType(0)
	SetTextColor(230, 230, 230, 240)  
	RenderText3(Quest_Config.Window.PosX, 20, Quest_Config.QuestDescription, Quest_Config.Window.Width, 3)

    SetFontType(0)
	SetTextBg(0, 0, 0, 0)
	SetTextColor(72, 240, 72, 255)
	RenderText3(Quest_Config.Window.PosX, 52, Quest_Config.QuestValidade, Quest_Config.Window.Width, 3)

    DisableAlphaBlend()
	SetBlend()
	glColor4f(0.0,0.0,0.0, 0.6)
	DrawBar(Quest_Config.Window.PosX+20, 70, 150, 300)
    glColor4f(0.54, 0.422, 0.2322, 0.7)
	DrawBox(Quest_Config.Window.PosX+20, 70, 150, 300)
    DrawBar(Quest_Config.Window.PosX+20+75, 70, 1, 25)

    if Quest_Config.Aba == 1 then
        DrawBar(Quest_Config.Window.PosX+20+75, 95, 75, 1)
    else
        DrawBar(Quest_Config.Window.PosX+20+1, 95, 75, 1)
    end
	SetBlend()
	EndDrawBar()
	EnableAlphaTest()

    SetFontType(7)
	SetTextBg(0, 0, 0, 0)

    if Quest_Config.Aba == 1 then
        SetTextColor(250, 250, 250, 255)
    else
        SetTextColor(250, 250, 250, 155)
    end
    RenderText3(Quest_Config.Window.PosX+20, 79, Quest_Config.Texts[GetLanguage()][2], 75, 3)
    if Quest_Config.Aba == 2 then
        SetTextColor(250, 250, 250, 255)
    else
        SetTextColor(250, 250, 250, 155)
    end
    RenderText3(Quest_Config.Window.PosX+20+75, 79, Quest_Config.Texts[GetLanguage()][3], 75, 3)

    SetFontType(1)
    SetTextBg(0, 0, 0, 0)

    local btnstate = 0
    Quest.CreateButton(Quest_Config.ButtonID.fechar, Quest_Config.Window.PosX+20, 380, 70, 25)
    if Quest.ButtonMouseOver(Quest_Config.ButtonID.fechar, MousePosX(), MousePosY()) then
        btnstate = 1
        if Quest.ButtonClicked(Quest_Config.ButtonID.fechar) then
            btnstate = 2
        end
    end
    DrawButton.Medium(btnstate, Quest_Config.Window.PosX+20, 380, 70, 25)

    SetTextColor(237, 214, 161, 255)
    RenderText3(Quest_Config.Window.PosX+20, 388, Quest_Config.Texts[GetLanguage()][8], 70, 3)
    
    btnstate = 0
    Quest.CreateButton(Quest_Config.ButtonID.resgatar, Quest_Config.Window.PosX+100, 380, 70, 25)
    if Quest_Config.RewardEnabled == 1 then
	    if Quest.ButtonMouseOver(Quest_Config.ButtonID.resgatar, MousePosX(), MousePosY()) then
            btnstate = 1
	    	if Quest.ButtonClicked(Quest_Config.ButtonID.resgatar) then
	    		btnstate = 2
	    	end
	    end
        SetTextColor(237, 214, 161, 255)
    else
        btnstate = 3
        SetTextColor(237, 214, 161, 155)
    end
    DrawButton.Medium(btnstate, Quest_Config.Window.PosX+100, 380, 70, 25)
    RenderText3(Quest_Config.Window.PosX+100, 388, Quest_Config.Texts[GetLanguage()][4], 70, 3)

    SetFontType(0)
	SetTextBg(0, 0, 0, 0)
    local stLine = 102
    if Quest_Config.Aba == 1 then
        for i in ipairs(Quest_Config.Objectives) do
            local obj = Quest_Config.Objectives[i]
            if obj.Quantity.Have >= obj.Quantity.Need then
                SetTextColor(49, 181, 47, 255)
            else
                SetTextColor(237, 97, 97, 255)
            end
            RenderText3(Quest_Config.Window.PosX+26, stLine, string.format("%d / %d - %s", obj.Quantity.Have, obj.Quantity.Need, obj.Name), 160, 1)
            stLine = stLine+12
        end
    else
        for i in ipairs(Quest_Config.Rewards) do
            local obj = Quest_Config.Rewards[i]
            SetTextColor(103, 133, 240, 255)
            RenderText3(Quest_Config.Window.PosX+26, stLine, string.format("%d - %s", obj.Quantity, obj.Name), 160, 1)
            stLine = stLine+12
        end
    end

    DisableAlphaBlend()

    if Quest_Config.AlertOpen then
        EnableAlphaTest()
        local posX = (WindowGetWidth()/2)-(225/2)

        DrawInterface.InfoBox(true, posX, 90, 225, 1, false)

        SetFontType(1)
        SetTextBg(0,0,0,0)
        SetTextColor(250,10,0,255)

        local text = {9, 10,11}
        if Quest_Config.AlertType == 2 then
            text = {5,6,7}
            SetTextColor(250,217,0,255)
        end

        RenderText3(posX, 105, Quest_Config.Texts[GetLanguage()][text[1]], 225, 3)
        SetFontType(0)
        SetTextColor(255,255,255,255)
        RenderText3(posX, 140, Quest_Config.Texts[GetLanguage()][text[2]], 225, 3)
        RenderText3(posX, 150, Quest_Config.Texts[GetLanguage()][text[3]], 225, 3)


        DisableAlphaBlend()
        SetBlend()
        EndDrawBar()

        EnableAlphaTest()
        Quest.CreateButton(Quest_Config.ButtonID.fechar, posX+((225/2) - 30), 175, 60, 18)
        btnstate = 0
        if Quest.ButtonMouseOver(Quest_Config.ButtonID.fechar, MousePosX(), MousePosY()) then
            btnstate = 1
        end
        DrawButton.Medium(btnstate, posX+((225/2) - 30), 175, 60, 18)

        SetFontType(1)
        SetTextColor(237, 214, 161, 255)
        RenderText3(posX+((225/2) - 30), 179, "OK", 60, 3)

        DisableAlphaBlend()
        SetBlend()
        EndDrawBar()
    end
end

function Quest.KeyListener(key)
    if not Quest.CheckOpen() then return end

    if key == Keys.Escape then
        Quest.Close()
        return true
    end
end

function Quest.ClickEvent()
    if not Quest.CheckOpen() then return end

    local x = MousePosX()
    local y = MousePosY()

    if Quest.ButtonMouseOver(Quest_Config.ButtonID.fechar, x, y) then
        Quest.Close()
        return true
    end

    if Quest.ButtonMouseOver(Quest_Config.ButtonID.aba1, x, y) then
        Quest_Config.Aba = 1
        return true
    end

    if Quest.ButtonMouseOver(Quest_Config.ButtonID.aba2, x, y) then
        Quest_Config.Aba = 2
        return true
    end

    if Quest_Config.RewardEnabled == 1 then
        if Quest.ButtonMouseOver(Quest_Config.ButtonID.resgatar, x, y) then
            Quest_Config.Button[Quest_Config.ButtonID.resgatar].clicked = true
            local packetname = string.format("2-%s-%d", UserGetName(), UserGetIndex())
            CreatePacket(packetname, Quest_Config.Packet)
            SendPacket(packetname)
            ClearPacket(packetname)
            return true
        end
    end

end

function Quest.Update()
    if Quest.CheckOpen() then
        DisableClickClient()
    end
end

function Quest.CheckPacketName(PacketName, Id)
    local index = UserGetIndex()
    local name = UserGetName()

   if PacketName == string.format("%d-%s-%d", Id, name, index) then return true else return false end
end

function Quest.Protocol(Packet, PacketName)
    if Packet ~= Quest_Config.Packet then return end

    if Quest.CheckPacketName(PacketName, 1) then
        if not Quest.CheckOpen() then
            Quest_Config.RewardEnabled = GetBytePacket(PacketName, -1)
            local len = GetBytePacket(PacketName, -1)
            Quest_Config.QuestName = GetCharPacketLength(PacketName, -1, len)
            len = GetBytePacket(PacketName, -1)
            Quest_Config.QuestDescription = GetCharPacketLength(PacketName, -1, len)
            len = GetBytePacket(PacketName, -1)
            Quest_Config.QuestValidade = GetCharPacketLength(PacketName, -1, len)
            local qtd = GetBytePacket(PacketName, -1)
            for x = 1, qtd do
                local have = GetDwordPacket(PacketName, -1)
                local need = GetDwordPacket(PacketName, -1)
                len = GetBytePacket(PacketName, -1)
                local name = GetCharPacketLength(PacketName, -1, len)
                local req = {Quantity = {Have = have, Need = need}, Name = name}
                table.insert(Quest_Config.Objectives, req)
            end

            qtd = GetBytePacket(PacketName, -1)
            for x = 1, qtd do
                local have = GetDwordPacket(PacketName, -1)
                len = GetBytePacket(PacketName, -1)
                local name = GetCharPacketLength(PacketName, -1, len)
                local req = {Quantity = have, Name = name}
                table.insert(Quest_Config.Rewards, req)
            end
            
            ClearPacket(PacketName)
            Quest.Open()
            return true
        end
    end

    if Quest.CheckPacketName(PacketName, 3) then
        Quest_Config.AlertType = GetBytePacket(PacketName, -1)
        ClearPacket(PacketName)
        Quest_Config.AlertOpen = true
        return true
    end
end

Quest.Init()

return Quest