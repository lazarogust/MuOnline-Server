local MoveCustomInterface = {}

local MoveCustomInterfaceSwitch = true
local MoveCustom_Packet = 0x67

local moveWindow = 90876
local clickedM = false
local MoveCustomInterface_MoveSelect = {}
local MoveCustomInterface_MapSelect = {}

local isClickedMap = false
local backButton = false
local mapSelect = ''
local moveSelect = 0

local RunningState = false
local MapName = 'nil'
local Timer = 'nil'
local Status = 0

function MoveCustomInterface.Init()
    if MoveCustomInterfaceSwitch then
        InterfaceController.MainProc(MoveCustomInterface.MakeInterface)
        InterfaceController.MainProcWorldKey(MoveCustomInterface.CheckKeyPressed)
        InterfaceController.ClientProtocol(MoveCustomInterface.ClientProtocol)
        InterfaceController.InterfaceClickEvent(MoveCustomInterface.InterfaceClickEvent)
		--InterfaceController.LoadImages(MoveCustomInterface.LoadImages)
    end
end

function MoveCustomInterface.MakeInterface()
    if UICustomInterface == moveWindow then
        if not Utils.CheckWindow() and CheckWindowOpen(UIChatWindow) ~= 1 then
            MoveCustomInterface.MakeInterfaceMove()
        else 
            MoveCustomInterface.Close()
        end
    end
	
	if RunningState then
	    MoveCustomInterface.MakeInterfaceTimer()
	end
end

function MoveCustomInterface.MakeInterfaceTimer()
    EnableAlphaTest()
	RenderImage2(40004, 255 + GetWideX(640), -1, 130.0, 50.0, 0, 0, 0.73500, 0.80, 1, 1, 0.0) -- bg
	SetFontType(1) 
    SetTextBg(0, 0, 0, 0)
    SetTextColor(255, 154, 0, 255)
	RenderText2(270 + GetWideX(640), 9, string.format("%s", MapName), 100, ALIGN_CENTER)
	RenderText2(270 + GetWideX(640), 19, string.format("Tempo"), 100, ALIGN_CENTER)
	RenderText2(270 + GetWideX(640), 36, string.format("%s", Timer), 100, ALIGN_CENTER)
    DisableAlphaBlend()
end

function MoveCustomInterface.MakeInterfaceMove()
    EnableAlphaTest()

    RenderImage2(40003, 85 + GetWideX(640), 40, 500.0, 370.0, 0, 0, 0.9992025, 0.784812, 1, 1, 0.0) -- bg
	
    SetFontType(1) 
    SetTextBg(255, 255, 255, 0)
    SetTextColor(250, 250, 250, 255)
	RenderText2(235 + GetWideX(640), 51, string.format('MOVE MENU'), 205, ALIGN_CENTER)

    for index in ipairs(moveCustomConfigMap) do
        local map = moveCustomConfigMap[index]
        
        Utils.CreateButton(map.index, map.IX + GetWideX(640), map.IY, map.wdth, map.heigth, MoveCustomInterface_MapSelect)
        SetTextColor(250, 250, 250, 255)

        local ix = map.IX1 or map.IX
		if map.index == moveSelect then
            RenderImage2(40006, ix + GetWideX(640), map.IY, map.wdth, map.heigth, 0, 0.43, 0.78450, 0.20, 1, 1, 0.0)
		else
		    if Utils.CheckButton(map.index, MousePosX(), MousePosY(), MoveCustomInterface_MapSelect) then
		        RenderImage2(40006, ix + GetWideX(640), map.IY, map.wdth, map.heigth, 0, 0.21, 0.78450, 0.20, 1, 1, 0.0)
			else
			    RenderImage2(40006, ix + GetWideX(640), map.IY, map.wdth, map.heigth, 0, 0, 0.78450, 0.20, 1, 1, 0.0)
			end
		end
		
        RenderText2(map.alignText[0] + GetWideX(640), map.alignText[1], string.format('%s', map.name), map.wdth, ALIGN_CENTER)
    end

	if mapSelect ~= '' then
        local listMoves = moveCustomConfigMoves[mapSelect]
        if listMoves ~= nil then
            for index in ipairs(listMoves) do
                local map = listMoves[index]
                
                Utils.CreateButton(map.index, map.IX + GetWideX(640), map.IY, map.wdth, map.heigth, MoveCustomInterface_MoveSelect)
                SetTextColor(250, 250, 250, 255)
				
                local ix = map.IX1 or map.IX
		        if Utils.CheckButton(map.index, MousePosX(), MousePosY(), MoveCustomInterface_MoveSelect) then
		            RenderImage2(40006, ix + GetWideX(640), map.IY, map.wdth, map.heigth, 0, 0.21, 0.78450, 0.20, 1, 1, 0.0)
			    else
			        RenderImage2(40006, ix + GetWideX(640), map.IY, map.wdth, map.heigth, 0, 0, 0.78450, 0.20, 1, 1, 0.0)
			    end
				
                RenderText2(map.alignText[0] + GetWideX(640), map.alignText[1], string.format('%s', map.title), map.wdth, ALIGN_CENTER)
            end
        end
    end

    ---- Make button close
	SetFontType(0)
	SetTextBg(0, 0, 0, 170)
    Utils.CreateButton(100, 552 + GetWideX(640), 49, 18, 17, MoveCustomInterface_MoveSelect)
    if Utils.CheckButton(100, MousePosX(), MousePosY(), MoveCustomInterface_MoveSelect) then
		RenderImage2(40005, 552 + GetWideX(640), 49, 19, 17, 0.0, 0.2055384732, 0.8035384717, 0.2015384692, 1, 1, 0)
		RenderText2(542 + GetWideX(640), 36, string.format('Fechar'), 40, ALIGN_CENTER)
    else
		RenderImage2(40005, 552 + GetWideX(640), 49, 19, 17, 0.0, 0, 0.8035384717, 0.2015384692, 1, 1, 0)
    end
	
    DisableAlphaBlend()
end

function MoveCustomInterface.InterfaceClickEvent()
    if UICustomInterface == moveWindow then
	
        if Utils.CheckButton(100, MousePosX(), MousePosY(), MoveCustomInterface_MoveSelect) then
            MoveCustomInterface.Close()
        end

        for index in ipairs(moveCustomConfigMap) do
            local map = moveCustomConfigMap[index]
            if Utils.CheckButton(map.index, MousePosX(), MousePosY(), MoveCustomInterface_MapSelect) then
                if map.listMove == true then
                    isClickedMap = true
					moveSelect = map.index
                    mapSelect = map.name
                    MoveCustomInterface_MoveSelect = {}
                else
                    MoveCustomInterface.SendPacket('GS_MoveCustom', MoveCustom_Packet, map.name, 'nil', map.mapNumber, map.cdX, map.cdY)
                    MoveCustomInterface.Close()
                end
            end
        end
			
        if mapSelect ~= '' then
            local listMoves = moveCustomConfigMoves[mapSelect]
            if listMoves ~= nil then
                for index in ipairs(listMoves) do
                    local map = listMoves[index]
                    if Utils.CheckButton(map.index, MousePosX(), MousePosY(), MoveCustomInterface_MoveSelect) then
                        MoveCustomInterface.SendPacket('GS_MoveCustom', MoveCustom_Packet, mapSelect, map.title, map.mapNumber, map.cdX, map.cdY)
                        MoveCustomInterface.Close()
                    end
                end

                if Utils.CheckButton(200, MousePosX(), MousePosY(), MoveCustomInterface_MoveSelect) and backButton then
                    mapSelect = ''
					moveSelect = 0
                    listMoves = nil
                    backButton = true
                    isClickedMap = false
                end
            end
        end
    end
end

function MoveCustomInterface.SendPacket(packName, packet, map, destination, mapNumber, cx, cy)
    CreatePacket(packName, packet)
    SetCharPacketLength(packName, map, 10)
    SetCharPacketLength(packName, destination, 10)
    SetDwordPacket(packName, mapNumber)
    SetDwordPacket(packName, cx)
    SetDwordPacket(packName, cy)
    SendPacket(packName)
    ClearPacket(packName)
end

function MoveCustomInterface.ClientProtocol(packet, packetName)
    if packet == MoveCustom_Packet then
        if packetName == 'GS_MoveCustom' then
            Status = GetBytePacket(packetName, -1)
            MapName = GetCharPacketLength(packetName, -1, 10)
            Timer = GetCharPacketLength(packetName, -1, 10)
	        if Status == 0 then
	    	    RunningState = false
	    	elseif Status == 1 then
	    	    RunningState = true
	    	end
	    	
            ClearPacket(packetName)
        end
	end
end

function MoveCustomInterface.CheckKeyPressed(key)
    if not GuardiaoBrindes.CheckOpen() then 
        if Keys.M == key then
            if not clickedM then
                MoveCustomInterface.Open()
            else
                MoveCustomInterface.Close()
            end
        elseif key == Keys.Escape then
            MoveCustomInterface.Close()
        end
    end
end

function MoveCustomInterface.Open()
    if UICustomInterface ~= moveWindow then
        UICustomInterface = moveWindow
        clickedM = true
        SetLockInterfaces()
    end
end

function MoveCustomInterface.Close()
    if UICustomInterface == moveWindow then 
        moveWindow = -1
        clickedM = false
        isClickedMap = false
        mapSelect = ''
		moveSelect = 0
        UICustomInterface = 0
        SetUnlockInterfaces()
    end
end

function MoveCustomInterface.LoadImages()
	--40003 = LoadImageByDir("Custom\\Move\\menu_v2.jpg")
	--40004 = LoadImageByDir("Custom\\Move\\NewUI_Timer.tga")
	--40005 = LoadImageByDir("Custom\\Move\\btn_close_v2.jpg")
	--40006 = LoadImageByDir("Custom\\Move\\btn_large_v2.jpg")
end

MoveCustomInterface.Init()

return MoveCustomInterface
