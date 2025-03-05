RescueItens = {}

--#region REGISTRA FUN��ES DO SISTEMA
function RescueItens.Init()
	InterfaceController.BeforeMainProc(RescueItens.Interface)
	InterfaceController.MainProc(RescueItens.AfterInterface)
	InterfaceController.ClientProtocol(RescueItens.Protocol)
	InterfaceController.MainProcWorldKey(RescueItens.KeyListener)
	InterfaceController.InterfaceClickEvent(RescueItens.ClickEvent)
	InterfaceController.ScrollMouse(RescueItens.ScrollMouse)
	InterfaceController.UpdateMouse(RescueItens.UpdateMouse)
	InterfaceController.UpdateKey(RescueItens.UpdateKey)

	RescueItens.Define()
end
--#endregion

--#region DEFINE VARIAVEIS
function RescueItens.Define()
	RescueItens_Config.WindowOffset = 0
	RescueItens_Config.AlertWindow = {Show = false, Type = 0}
	RescueItens_Config.Lista = {}
	RescueItens_Config.ListaConfig = {Offset = 1, Count = 7, Steps = 0, CurrentStep = 1, Selected = -1, MaxValue = 7}
	RescueItens_Config.ItemCount = 0
	RescueItens_Config.Area = {sx = 260, ex = 450}
	RescueItens_Config.Button = {}
	RescueItens_Config.ButtonID = {
		fechar = 1,
		acessar = 2,
		ok = 3,
		up = 4,
		down = 5,
	}
	RescueItens_Config.LockButton = false
	RescueItens_Config.ClickCount = 0
	RescueItens_Config.LastClick = 0
	RescueItens_Config.Barra = {Offset = 0, InitSize = 186, Size = 0, MaxOffset = 0, Pos = 0, InitEsp = 186, Esp = 0, Multiplier = 0}
	RescueItens_Config.m_ListOffset = 1
end
--#endregion

--#region ABRE A JANELA
function RescueItens.Open()
	if	CheckWindowOpen(UIFriendList)		== 1	then	return							end
	if	CheckWindowOpen(UIMoveList)			== 1	then	return							end
	if	CheckWindowOpen(UIParty)			== 1	then	CloseWindow(UIParty)			end
	if	CheckWindowOpen(UIQuest)			== 1	then	return							end
	if	CheckWindowOpen(UIGuild)			== 1	then	CloseWindow(UIGuild)			end
	if	CheckWindowOpen(UIGuildNpc)			== 1	then	CloseWindow(UIGuildNpc)			end
	if	CheckWindowOpen(UITrade)			== 1	then	return							end
	if	CheckWindowOpen(UIWarehouse)		== 1	then	return							end
	if	CheckWindowOpen(UICommandWindow)	== 1	then	return							end
	if	CheckWindowOpen(UIPetInfo)			== 1	then	return							end
	if	CheckWindowOpen(UIShop)				== 1	then	return							end
	if	CheckWindowOpen(UIStore)			== 1	then	return							end
	if	CheckWindowOpen(UIOtherStore)		== 1	then	CloseWindow(UIOtherStore)		end
	if	CheckWindowOpen(UICharacter)		== 1	then	CloseWindow(UICharacter)		end
	if	CheckWindowOpen(UIOptions)			== 1	then	return							end
	if	CheckWindowOpen(UIHelp)				== 1	then	return							end
	if	CheckWindowOpen(UIFastDial)			== 1	then	return							end
	if	CheckWindowOpen(UISkillTree)		== 1	then	return							end
	if	CheckWindowOpen(UINPC_Titus)		== 1	then	return							end
	if	CheckWindowOpen(UICashShop)			== 1	then	return							end
	if	CheckWindowOpen(UIFullMap)			== 1	then	return							end
	if	CheckWindowOpen(UINPC_Dialog)		== 1	then	return							end
	if	CheckWindowOpen(UIGensInfo)			== 1	then	CloseWindow(UIGensInfo)			end
	if	CheckWindowOpen(UINPC_Julia)		== 1	then	return							end

	OpenWindow(UIInventory)
	UICustomInterface = RescueItens_Config.WindowID
end
--#endregion

--#region FECHA A JANELA
function RescueItens.Close()
	UICustomInterface = 0
	RescueItens.Define()
	CloseWindow(UIInventory)
end
--#endregion

--#region VERIFICA JANELA ABERTA E AREA PROTEGIDA DA TELA
function RescueItens.CheckOpen()
	if UICustomInterface == RescueItens_Config.WindowID then return true else return false end
end

function RescueItens.CheckArea(x)
	if x >= RescueItens_Config.Area.sx-RescueItens_Config.WindowOffset and x <= RescueItens_Config.Area.ex-RescueItens_Config.WindowOffset then
		return true
	end
	return false
end
--#endregion

--#region FUN��ES DO BOT�O
function RescueItens.CreateButton(ButtonID, x, y, w, h)
	if RescueItens_Config.Button[ButtonID] == nil then
		table.insert(RescueItens_Config.Button, ButtonID)
		RescueItens_Config.Button[ButtonID] = {
			x = x,
			y = y,
			w = w,
			h = h,
			clicked = false,
			timer = 0
		}
	else
		RescueItens_Config.Button[ButtonID].x = x
		RescueItens_Config.Button[ButtonID].y = y
		RescueItens_Config.Button[ButtonID].w = w
		RescueItens_Config.Button[ButtonID].h = h
	end
end

function RescueItens.ButtonClicked(ButtonID)
	if RescueItens_Config.Button[ButtonID] == nil then return false end
	if RescueItens_Config.Button[ButtonID].clicked then
		if RescueItens_Config.Button[ButtonID].timer >= 2 then
			RescueItens_Config.Button[ButtonID].timer = 0
			RescueItens_Config.Button[ButtonID].clicked = false
			return false
		end
			RescueItens_Config.Button[ButtonID].timer = RescueItens_Config.Button[ButtonID].timer + 1
		return true
	end
	return false
end

function RescueItens.ButtonMouseOver(ButtonID, x, y)
	if RescueItens_Config.Button[ButtonID] == nil then return false end
	if x >= RescueItens_Config.Button[ButtonID].x and x <= (RescueItens_Config.Button[ButtonID].x+RescueItens_Config.Button[ButtonID].w) then
		if y >= RescueItens_Config.Button[ButtonID].y and y <= (RescueItens_Config.Button[ButtonID].y+RescueItens_Config.Button[ButtonID].h) then
			return true
		end
	end
	return false
end
--#endregion

function RescueItens.GerarBarra()
	if RescueItens_Config.ListaConfig.Count <= 7 then 
		RescueItens_Config.ListaConfig.Steps = 0
		RescueItens_Config.ListaConfig.Offset = 1
		RescueItens_Config.ListaConfig.MaxValue = RescueItens_Config.ListaConfig.Count
		return
	end

	RescueItens_Config.ListaConfig.Steps = RescueItens_Config.ListaConfig.Count-7
	RescueItens_Config.ListaConfig.CurrentStep = 0
	RescueItens_Config.ListaConfig.Offset = 1
	RescueItens_Config.ListaConfig.MaxValue = 7
end

--#region INTERFACE AFTER
function RescueItens.AfterInterface()
	local addX = WindowGetWidthAdd()
	local posX = WindowGetWidth()

	if not RescueItens.CheckOpen() then return end

	--#region CHECKAR OUTRAS INTERFACES
		if	CheckWindowOpen(UIInventory) 		== 0	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIFriendList) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIMoveList)			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIParty) 			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIQuest) 			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIGuild) 			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIGuildNpc) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UITrade) 			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIWarehouse) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UICommandWindow) 	== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIPetInfo)	 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIShop)				== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIStore) 			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIOtherStore) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UICharacter) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIOptions) 			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIHelp)				== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIFastDial)			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UISkillTree) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UINPC_Titus) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UICashShop)			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIFullMap) 			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UINPC_Dialog)		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIGensInfo)			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UINPC_Julia)		== 1	then	RescueItens.Close()	end

	DisableAlphaBlend()

	if RescueItens_Config.ListaConfig.Selected ~= -1 then
		local item = RescueItens_Config.Lista[RescueItens_Config.ListaConfig.Selected ]

		local sections = item.ItemIndex

		local item_sections = {
			Sword 		= {0,    511},
			Axe 		= {512,  1023},
			Mace 		= {1024, 1535},
			Scepter 	= {1536, 2047},
			Bow 		= {2048, 2559},
			Staff 		= {2560, 3071},
			Shield 		= {3072, 3583},
			Helm 		= {3584, 4095},
			Armor 		= {4096, 4607},
			Pants 		= {4608, 5119},
			Gloves 		= {5120, 5631},
			Boots 		= {5632, 6143},
			Wings 		= {6144, 6655},
			Pets 		= {6656, 7167},
			Diversos 	= {7168, 8191},
		}

		local function isInSection(sectionRange, value)
			return value >= sectionRange[1] and value <= sectionRange[2]
		end

		if isInSection(item_sections.Sword, sections) or isInSection(item_sections.Axe, sections) or isInSection(item_sections.Mace, sections) or isInSection(item_sections.Staff, sections) then
			CreateItem(posX+18-item.X, item.Y+3, item.W, item.H, sections, item.Level, 0, 0, 1.0)

		elseif isInSection(item_sections.Bow, sections) then
			CreateItem(posX+18-item.X + 4, item.Y-3, item.W, item.H, sections, item.Level, 0, 0, 1.0)

		elseif isInSection(item_sections.Shield, sections) then
			CreateItem(posX+18-item.X + 5, item.Y, item.W, item.H, sections, item.Level, 0, 0, 1.0)

		elseif isInSection(item_sections.Helm, sections) then
			CreateItem(posX+18-item.X, item.Y+6, item.W, item.H, sections, item.Level, 0, 0, 1.0)

		elseif isInSection(item_sections.Armor, sections) then
			CreateItem(posX+18-item.X, item.Y+8, item.W, item.H, sections, item.Level, 0, 0, 1.0)

		elseif isInSection(item_sections.Pants, sections) then
			CreateItem(posX+18-item.X, item.Y+2, item.W, item.H, sections, item.Level, 0, 0, 1.0)

		elseif isInSection(item_sections.Gloves, sections) then
			CreateItem(posX+18-item.X +2, item.Y, item.W, item.H, sections, item.Level, 0, 0, 1.0)

		elseif isInSection(item_sections.Boots, sections) then
			CreateItem(posX+18-item.X, item.Y, item.W, item.H, sections, item.Level, 0, 0, 1.0)

		elseif isInSection(item_sections.Wings, sections) then
			CreateItem(posX+18-item.X -3, item.Y+7, item.W, item.H, sections, item.Level, 0, 0, 1.0)

		elseif isInSection(item_sections.Pets, sections) then
			CreateItem(posX+18-item.X +5, item.Y-8, item.W, item.H, sections, item.Level, 0, 0, 1.0)

		elseif isInSection(item_sections.Diversos, sections) then
			CreateItem(posX+18-item.X +4, item.Y-4, item.W, item.H, sections, item.Level, 0, 0, 1.0)

		else
			CreateItem(posX+18-item.X, item.Y, item.W, item.H, sections, item.Level, 0, 0, 1.0)
		end

		--CreateItem(item.X-posX-base, item.Y, item.W, item.H, item.ItemIndex, item.Level, 0, 0, 1.0)

		EndDrawBar()
		if RescueItens_Config.Description then
			if MousePosX() >= posX+18-item.X and MousePosX() <= posX+18-item.X+item.W then
				if MousePosY() >= item.Y and MousePosY() <= item.Y+item.H then
					SetBlend()
					ShowDescriptionComplete(MousePosX(), MousePosY()+10, item.ItemIndex, item.Level, item.Durabilidade, item.Skill, item.Luck, item.Opt, item.Excelente, item.Ancient, item.Harmony, 255, 255, 255, 255, 255,255)
					EndDrawBar()
				end
			end
		end
	end

	EnableAlphaTest()

	if RescueItens_Config.AlertWindow.Show then
		EnableAlphaTest()
		local posX = (WindowGetWidth()/2)-(225/2)

        DrawInterface.InfoBox(false, posX, 90, 225, 0, false)

		local btnstate = 0
		RescueItens.CreateButton(RescueItens_Config.ButtonID.ok, posX+(225/2)-30, 135, 60, 18)
		if RescueItens.ButtonMouseOver(RescueItens_Config.ButtonID.ok, MousePosX(), MousePosY()) then
			btnstate = 1
		end
		DrawButton.Medium(btnstate, posX+(225/2)-30, 135, 60, 18)

		SetFontType(1)
		SetTextBg(0, 0, 0, 0)
		SetTextColor(237, 214, 161, 255)
		RenderText3(posX+(225/2)-30, 139, "OK", 60, 3)

		SetTextColor(255, 207, 13, 255)

		if RescueItens_Config.AlertWindow.Type == 0 then
			RenderText3(posX, 105, string.format(RescueItens_Config.Texts[GetLanguage()][4]), 225, 3)
			SetTextColor(255, 255, 255, 255)
			RenderText3(posX, 115, string.format(RescueItens_Config.Texts[GetLanguage()][5]), 225, 3)
		end
		if RescueItens_Config.AlertWindow.Type == 1 then
			RenderText3(posX, 105, string.format(RescueItens_Config.Texts[GetLanguage()][6]), 225, 3)
			SetTextColor(255, 255, 255, 255)
			RenderText3(posX, 115, string.format(RescueItens_Config.Texts[GetLanguage()][7]), 225, 3)
		end

		DisableAlphaBlend()
		SetBlend()
		EndDrawBar()
	end

	DisableAlphaBlend()
end
--#endregion

--#region INTERFACE BEFORE
function RescueItens.Interface()
	local addX = WindowGetWidthAdd()
	local posX = WindowGetWidth()
	local base = 260 + 120

	if not RescueItens.CheckOpen() then return end

	--#region CHECK OUTRAS INTERFACE
		--if	CheckWindowOpen(UIInventory) 		== 0	then	RescueItens.Close()	end

		if	CheckWindowOpen(UIFriendList) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIMoveList)			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIParty) 			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIQuest) 			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIGuild) 			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIGuildNpc) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UITrade) 			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIWarehouse) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UICommandWindow) 	== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIPetInfo)	 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIShop)				== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIStore)			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIOtherStore) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UICharacter) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIOptions) 			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIHelp)				== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIFastDial)			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UISkillTree) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UINPC_Titus) 		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UICashShop)			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIFullMap) 			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UINPC_Dialog)		== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UIGensInfo)			== 1	then	RescueItens.Close()	end
		if	CheckWindowOpen(UINPC_Julia)		== 1	then	RescueItens.Close()	end
	--#endregion

	RescueItens.CreateButton(RescueItens_Config.ButtonID.fechar,470, 395, 24, 24)
	RescueItens.CreateButton(RescueItens_Config.ButtonID.acessar,0,0,0,0)
	RescueItens.CreateButton(RescueItens_Config.ButtonID.ok,0,0,0,0)
	RescueItens.CreateButton(RescueItens_Config.ButtonID.up, 0, 0, 0, 0)
	RescueItens.CreateButton(RescueItens_Config.ButtonID.down, 0, 0, 0, 0)

	--#region BASE JANELA
		EnableAlphaTest()
		RenderImage(31319, 260 + (2*GetWideX())-GuardiaoBrindes_Config.WindowOffset, 0, 190, 429)
		--RenderImage2(600041, posX-base-RescueItens_Config.WindowOffset, 0, 190, 429, 0.0, 1.0, 0.815, 0.935, 1, 1, 1.0)
		--RenderImage(41000, posX-base-RescueItens_Config.WindowOffset, 0, 190, 429)

		SetFontType(1)
		SetTextBg(0, 0, 0, 0)
		SetTextColor(255, 255, 255, 240)
		RenderText3(posX-base+95-RescueItens_Config.WindowOffset, 12, string.format(RescueItens_Config.Texts[GetLanguage()][1]), 80, 8)
		DisableAlphaBlend()
	--#endregion

	--#region ITEM PREVIEW
		local boxItemPreviewPosX   = posX-base+35-RescueItens_Config.WindowOffset
		local boxItemPreviewPosY   = 60
		local boxItemPreviewWidth  = 120
		local boxItemPreviewHeight = 90
		--RenderImage2(600011, boxItemPreviewPosX, boxItemPreviewPosY, boxItemPreviewWidth, boxItemPreviewHeight, 0.0, 1.0, 0.88, 0.69220, 1, 1, 1.0)

		--#region 
		DrawInterface.ItemBox(false, boxItemPreviewPosX, boxItemPreviewPosY, boxItemPreviewWidth, boxItemPreviewHeight)
		--[[
			SetBlend()
			glColor4f(0.0,  0.0,  0.0,  0.4)
			DrawBar(boxItemPreviewPosX, boxItemPreviewPosY, boxItemPreviewWidth, boxItemPreviewHeight)
	
			--BORDA
				glColor4f(0.36, 0.33, 0.29, 1.0)
				DrawBox(boxItemPreviewPosX, boxItemPreviewPosY, boxItemPreviewWidth, boxItemPreviewHeight)
				EndDrawBar()
			--#endregion
		--]]
	--#endregion

	--#region BUTTON RETIRAR
		EnableAlphaTest()
		local buttonRetirarPosX   = posX-base+60-RescueItens_Config.WindowOffset
		local buttonRetirarPosY   = boxItemPreviewPosY + 100
		local buttonRetirarWidth  = 70
		local buttonRetirarHeight = 28

		--SEASON 2
		--RenderImage2(41006, 310-RescueItens_Config.WindowOffset, 175, 90, 24, 0.0, 0.0, 0.8321874124, 1.0, 1, 1, 1.0)
		RescueItens.CreateButton(RescueItens_Config.ButtonID.acessar, buttonRetirarPosX, buttonRetirarPosY, buttonRetirarWidth, buttonRetirarHeight)
		local state = 0
		if RescueItens_Config.ListaConfig.Selected ~= -1 then
			if RescueItens.ButtonMouseOver(RescueItens_Config.ButtonID.acessar, MousePosX(), MousePosY()) then
				if not RescueItens.ButtonClicked(RescueItens_Config.ButtonID.acessar) then
					if CheckRepeatKey(Keys.LButton) == 1 then
						state = 2
					else
						state = 1
					end
				end
			else
				state = 0
			end
		else
			state = 3
		end

		DrawButton.Large(state, buttonRetirarPosX, buttonRetirarPosY, buttonRetirarWidth, buttonRetirarHeight)

		if RescueItens_Config.ListaConfig.Selected ~= -1 then
			SetTextColor(255, 255, 255, 255)
		else
			SetTextColor(255, 255, 255, 100)
		end

		SetFontType(1)
		SetTextBg(0, 0, 0, 0)
		if state == 2 then
			RenderText3(buttonRetirarPosX+35, buttonRetirarPosY+10, RescueItens_Config.Texts[GetLanguage()][2], 150, 8)
		else
			RenderText3(buttonRetirarPosX+35, buttonRetirarPosY+9, RescueItens_Config.Texts[GetLanguage()][2], 150, 8)
		end
	--#endregion

	--#region BOX
		EnableAlphaTest()

		--#region RENDER TEXT + CORES
			local COLOR_GREEN  = {20,   194,  8,    255}
			local COLOR_RED_E  = {200,  0,    0,    255}
			local COLOR_RED_C  = {250,  60,   60,   255}
			local COLOR_YELLOW = {237, 214, 161, 255}
			local COLOR_ORANGE = {255,  115,  0,    255}
			local COLOR_BLUE   = {85,   97,   230,  255}
			local COLOR_WHITE  = {255,  255,  255,  255}

			local FUNDO        = {0.0,  0.0,  0.0,  0.4}
			local BORDA        = {0.36, 0.33, 0.29, 1.0}
			local BORDA_HOVER  = {0.0,  1.0,  0.0,  1.0}
			local TITLE 	   = {0.45, 0.0,  0.07, 1.0}

			local function RenderColoredText(x, y, text, color, width, height)
				SetTextColor(color[1], color[2], color[3], color[4])
				RenderText3(x, y, text, width, height)
			end
		--#endregion

		--#region BOX
			local boxPosX   = posX-base+30-RescueItens_Config.WindowOffset
			local boxPosY   = buttonRetirarPosY + 35
			local boxWidth  = 130
			local boxHeight = 180
			local boxTitle  = 20

			SetBlend()
			DrawInterface.ItemBox(false, boxPosX, boxPosY, boxWidth, boxHeight)
			--glColor4f(FUNDO[1], FUNDO[2], FUNDO[3], FUNDO[4])
			--DrawBar(boxPosX, boxPosY, boxWidth, boxHeight)
			glColor4f(TITLE[1], TITLE[2], TITLE[3], TITLE[4])
			DrawBar(boxPosX+1, boxPosY, boxWidth-1, boxTitle)

			--BORDA
				--glColor4f(BORDA[1], BORDA[2], BORDA[3], BORDA[4])
				--DrawBox(boxPosX, boxPosY, boxWidth, boxHeight)
				EndDrawBar()
			--#endregion

		--#region TEXTO
			SetFontType(1)
			SetTextBg(0, 0, 0, 0)
			RenderColoredText(buttonRetirarPosX+35, boxPosY+6, RescueItens_Config.Texts[GetLanguage()][3], COLOR_YELLOW, 150, 8)
		--#endregion

	--#endregion

	--#region SCROLL
		local ScrollPosX     = posX-base-19-RescueItens_Config.WindowOffset
		local ScrollPosY     = 163
		local ScrollWidth    = 11
		local ScrollHeight   = 159
		local buttonWidth    = 11
		local buttonUpHeight = 107
		local buttonDwHeight = 41

		--#region BARRA DO SCROLL
			EnableAlphaTest()
			-- glColor4f(0.37, 0.3317, 0.2849, 1.0)
			glColor4f(0.08, 0.08, 0.08, 1.0)
			DrawBar(ScrollPosX + 168, ScrollPosY + 52, ScrollWidth-1, ScrollHeight)

			glColor4f(0.1, 0.1, 0.1, 1.0)
			DrawBar(ScrollPosX + 169, ScrollPosY + 56, ScrollWidth-3, ScrollHeight-6)

			--glColor4f(0.91, 0.875, 0.8099, 1.0)
			--DrawBar(ScrollPosX + 169.5, ScrollPosY + 65+RescueItens_Config.Barra.Pos, ScrollWidth-2, RescueItens_Config.Barra.Size)

			--glColor4f(0.39, 0.3504, 0.3081, 0.6)
			--DrawBar(ScrollPosX + 170, ScrollPosY + 66+RescueItens_Config.Barra.Pos, ScrollWidth-4, RescueItens_Config.Barra.Size-2)
			EndDrawBar()

		--#endregion

		--#region BUTTON UP
			local scrollUp = 0
			RescueItens.CreateButton(RescueItens_Config.ButtonID.up, ScrollPosX + 168, ScrollPosY + ScrollHeight-buttonUpHeight, ScrollWidth-1, buttonWidth)
			if not RescueItens.ButtonClicked(RescueItens_Config.ButtonID.up) then
				if RescueItens.ButtonMouseOver(RescueItens_Config.ButtonID.up, MousePosX(), MousePosY()) then
					if CheckRepeatKey(Keys.LButton) == 1 then
						scrollUp = 2
					else
						scrollUp = 1
					end
				else
					scrollUp = 0
				end
			else
				scrollUp = 0
			end
			DrawScroll.Up(scrollUp, ScrollPosX + 168, ScrollPosY + ScrollHeight-buttonUpHeight, ScrollWidth-1, buttonWidth)

		--#endregion

		--#region BUTTON DOWN
			local scrollDown = 0
			RescueItens.CreateButton(RescueItens_Config.ButtonID.down, ScrollPosX + 168, ScrollPosY + ScrollHeight+buttonDwHeight, ScrollWidth-1, buttonWidth)
			if not RescueItens.ButtonClicked(RescueItens_Config.ButtonID.down) then
				if RescueItens.ButtonMouseOver(RescueItens_Config.ButtonID.down, MousePosX(), MousePosY()) then
					if CheckRepeatKey(Keys.LButton) == 1 then
						scrollDown = 2
					else
						scrollDown = 1
					end
				else
					scrollDown = 0
				end
			else
				scrollDown = 0
			end
			DrawScroll.Down(scrollDown, ScrollPosX + 168, ScrollPosY + ScrollHeight+buttonDwHeight, ScrollWidth-1, buttonWidth)
		--#endregion

		--#region SCROLLBAR
			--RenderImage(31270, 413-RescueItens_Config.WindowOffset,242, 7, 3) -- topo	
			--for i = 245, 365, 15 do
			--	RenderImage(31271, 413-RescueItens_Config.WindowOffset, i, 7, 15) -- meio
			--end
			--RenderImage(31272, 413-RescueItens_Config.WindowOffset, 380, 7, 3) -- baixo

			local barra = 168
			if RescueItens_Config.ListaConfig.Count > 7 then
				local cursorPos = 233 + (RescueItens_Config.ListaConfig.CurrentStep*(120/(RescueItens_Config.ListaConfig.Count-7)))
				if tostring(cursorPos) == "nan" or tostring(cursorPos) == "-nan"  or cursorPos < 230 then cursorPos = 230 end
				EnableAlphaTest()
				local scrollbar = 0
				if MousePosX() >= ScrollPosX + 168 and MousePosX() <= ScrollPosX + 168 + ScrollWidth-2 and MousePosY() >= ScrollPosY-1 + cursorPos-barra and MousePosY() <= ScrollPosY-1 + cursorPos-barra + 15 then
					if CheckRepeatKey(Keys.LButton) == 1 then
						scrollbar = 2
					else
						scrollbar = 1
					end
				else
					scrollbar = 0
				end

				DrawScroll.Bar(scrollbar, ScrollPosX + 168, ScrollPosY-1 + cursorPos-barra, ScrollWidth-2, 15)
			else
				EnableAlphaTest()
				--[[
				local scrollbar = 0
				if MousePosX() >= ScrollPosX + 168 and MousePosX() <= ScrollPosX + 168 + ScrollWidth-2 and MousePosY() >= ScrollPosY-1 + 233-barra and MousePosY() <= ScrollPosY-1 + 233-barra + 135 then
					if CheckRepeatKey(Keys.LButton) == 1 then
						scrollbar = 2
					else
						scrollbar = 1
					end
				else
					scrollbar = 0
				end
				DrawScroll.Bar(scrollbar, ScrollPosX + 168, ScrollPosY-1 + 233-barra, ScrollWidth-2, 135)
				--]]

				DrawScroll.Bar(0, ScrollPosX + 168, ScrollPosY-1 + 233-barra, ScrollWidth-2, 135)
			end
		--#endregion

	--#endregion

	--region SELECT ITEM
		local fixposX = posX-base+35-RescueItens_Config.WindowOffset
		local hoverPosX = 213
		local hoverPosY = 21.8

		--#region HOVER SELECT ITEM NAME
			DisableAlphaBlend()

			local line = hoverPosX
			local selectedItem = nil

			if MousePosX() >= fixposX - 4 and MousePosX() <= fixposX+114 then
				for c = RescueItens_Config.ListaConfig.Offset, RescueItens_Config.ListaConfig.MaxValue do
					if RescueItens_Config.Lista[c].Enabled then
						if MousePosY() >= line + 1 and MousePosY() <= line + hoverPosY then
							SetBlend()
							glColor4f(1.0, 1.0, 1.0, 0.1)
							DrawBar(fixposX - 4, line + 2, 117, 22)
							EndDrawBar()

							if CheckPressedKey(Keys.LButton) == 1 then
								selectedItem = c
							end
						end
					end
					line = line + hoverPosY + 1
				end
			end

		--#region SELECT ITEM FUNDO
			if selectedItem then
				RescueItens_Config.ListaConfig.Selected = selectedItem
			end

			local displayArea = {x1 = fixposX+5, x2 = fixposX+5 + 130, y1 = 195, y2 = 195 + 180}

			if RescueItens_Config.ListaConfig.Selected > 0 and RescueItens_Config.Lista[RescueItens_Config.ListaConfig.Selected].Enabled then
				local selectedLine = hoverPosX + (hoverPosY + 1) * (1 - RescueItens_Config.ListaConfig.Offset + (RescueItens_Config.ListaConfig.Selected - 1))

				if selectedLine >= displayArea.y1 and selectedLine + 22 <= displayArea.y2 then
					SetBlend()
					glColor4f(0.0, 1.0, 0.0, 0.2)
					DrawBar(fixposX - 4 - RescueItens_Config.WindowOffset, selectedLine + 2, 117, 22)
					EndDrawBar()
				end
			end
		--#endregion

		--#endregion

		--#region SELECT ITEM NAME
			EnableAlphaTest()
			SetBlend()

			SetFontType(1)
			SetTextBg(0, 0, 0, 0)
			if RescueItens_Config.ListaConfig.Selected ~= -1 then
				SetTextColor(255, 255, 255, 255)
			else
				SetTextColor(255, 255, 255, 100)
			end

			SetFontType(0)
			SetTextColor(255, 255, 255, 255)

			line = hoverPosX + 9
			for s = RescueItens_Config.ListaConfig.Offset, RescueItens_Config.ListaConfig.MaxValue do
				if RescueItens_Config.Lista[s].Enabled then
					SetTextColor(255, 255, 255, 255)
				else
					SetTextColor(214, 45, 45, 255)
				end
				RenderImage2(40001, fixposX-RescueItens_Config.WindowOffset, line+2, 5, 5, 0, 0, 0.591827401425252121, 0.591827401425252121, 1, 1, 1.0)
				RenderText3(fixposX+10-RescueItens_Config.WindowOffset, line, string.format("%s", GetNameByIndex(RescueItens_Config.Lista[s].ItemIndex)), 150, ALIGN_LEFT)
				line = line+hoverPosY+1
			end
			DisableAlphaBlend()
		--#endregion

	--#endregion

end

function RescueItens.KeyListener(key)
	if CheckWindowOpen(UIChatWindow) == 1 then return false end

	if not RescueItens.CheckOpen() then return false end

	if key == Keys.I or key == Keys.V then
		RescueItens.Close()
		return true
	end

	if key == Keys.Return then
		if RescueItens_Config.AlertWindow.Show then
			RescueItens_Config.AlertWindow.Show = false
			return true
		end
	end

	if key == Keys.Escape then
		if RescueItens_Config.AlertWindow.Show then
			RescueItens_Config.AlertWindow.Show = false
			return true
		else
			RescueItens.Close()
			return true
		end
	end
end

function RescueItens.ClickEvent()
	if not RescueItens.CheckOpen() then return false end
	local x = MousePosX()
	local y = MousePosY()

	if RescueItens.ButtonMouseOver(RescueItens_Config.ButtonID.fechar, (x+RescueItens_Config.WindowOffset), y) then
		RescueItens.Close()
		return true
	end

	if RescueItens_Config.AlertWindow.Show then
		if RescueItens.ButtonMouseOver(RescueItens_Config.ButtonID.ok, x, y) then
			RescueItens_Config.AlertWindow.Show = false
		end
		return true
	end

	if RescueItens.ButtonMouseOver(RescueItens_Config.ButtonID.acessar, x, y) then
		if RescueItens_Config.LockButton then return true end
		if RescueItens_Config.ListaConfig.Selected == -1 then return true end

		RescueItens_Config.Button[RescueItens_Config.ButtonID.acessar].clicked = true
		RescueItens.RetirarItem()
		return true
	end

	local addX = WindowGetWidthAdd()
	local posX = WindowGetWidth()
	local base = 260 + 120
	local fixposX = posX-base+35-RescueItens_Config.WindowOffset

	if x >= fixposX -4  and x <= fixposX+114 then
		local line = 213
		for i = RescueItens_Config.ListaConfig.Offset, RescueItens_Config.ListaConfig.MaxValue do
			if RescueItens_Config.Lista[i].Enabled then
				if y >= line+1 and y <= line+21.8 then
					if RescueItens_Config.ListaConfig.Selected == i then
						if RescueItens_Config.ClickCount == 0 then
							RescueItens_Config.ClickCount = 1
							RescueItens_Config.LastClick = os.time()
						elseif RescueItens_Config.ClickCount == 1 then
							if RescueItens_Config.LastClick == os.time() then
								RescueItens_Config.ClickCount = 2
							else
								RescueItens_Config.ClickCount = 0
							end
						end
						if RescueItens_Config.ClickCount >= 2 then
							if not RescueItens_Config.LockButton then
								RescueItens.RetirarItem()
								return true
							end
						end
					end
					RescueItens_Config.ListaConfig.Selected = i
					return true
				end
			end
			line = line+22.8
		end
	end
end

function RescueItens.ScrollMouse(Direction)
	local addX = WindowGetWidthAdd()
	local posX = WindowGetWidth()
	local base = 260 + 120

	local x = MousePosX()
	local y = MousePosY()

	if RescueItens.CheckOpen() then
		if RescueItens_Config.AlertWindow.Show then return true end

		local fixposX = posX-base+35-RescueItens_Config.WindowOffset

		local area = {x1 = fixposX+5, x2 = fixposX+5 + 130, y1 = 195, y2 = 195 + 180}

		if x >= area.x1 and x <= area.x2 and y >= area.y1 and y <= area.y2 then
			--AO GIRAR O SCROLL SELECIONA O ITEM
			--local selectedItem = RescueItens_Config.ListaConfig.Selected

			if Direction > 0 then
				if RescueItens_Config.ListaConfig.Offset > 1 then
					if RescueItens_Config.m_ListOffset <= 1 then
						return
					end
					RescueItens_Config.ListaConfig.Offset = RescueItens_Config.ListaConfig.Offset - 1
					RescueItens_Config.ListaConfig.MaxValue = RescueItens_Config.ListaConfig.MaxValue - 1
					RescueItens_Config.ListaConfig.CurrentStep = RescueItens_Config.ListaConfig.CurrentStep - 1

					--AO GIRAR O SCROLL SELECIONA O ITEM
					--RescueItens_Config.ListaConfig.Selected = selectedItem - 1

					RescueItens_Config.Barra.Offset = RescueItens_Config.Barra.Offset - 1
					RescueItens_Config.Barra.Pos = RescueItens_Config.Barra.Pos - RescueItens_Config.Barra.Multiplier
					RescueItens_Config.m_ListOffset = RescueItens_Config.m_ListOffset - 1
					--RescueItens_Config.m_MaxListID = RescueItens_Config.m_MaxListID - 1
				end
			else
				if RescueItens_Config.ListaConfig.Count > 7 then
					if RescueItens_Config.ListaConfig.MaxValue < RescueItens_Config.ListaConfig.Count then
						RescueItens_Config.ListaConfig.Offset = RescueItens_Config.ListaConfig.Offset + 1
						RescueItens_Config.ListaConfig.MaxValue = RescueItens_Config.ListaConfig.MaxValue + 1
						RescueItens_Config.ListaConfig.CurrentStep = RescueItens_Config.ListaConfig.CurrentStep + 1

						--AO GIRAR O SCROLL SELECIONA O ITEM
						--RescueItens_Config.ListaConfig.Selected = selectedItem + 1

						RescueItens_Config.Barra.Offset = RescueItens_Config.Barra.Offset + 1
						RescueItens_Config.Barra.Pos = RescueItens_Config.Barra.Pos + RescueItens_Config.Barra.Multiplier
						RescueItens_Config.m_ListOffset = RescueItens_Config.m_ListOffset + 1
						--RescueItens_Config.m_MaxListID = RescueItens_Config.m_MaxListID + 1
					end
				end
			end

			return true
		end
	end
end

function RescueItens.Protocol(Packet, PacketName)
	if Packet == RescueItens_Config.Packet then
		if PacketName == string.format("1-%s-%d", UserGetName(), UserGetIndex()) then
			RescueItens_Config.Lista = {}
			RescueItens_Config.ListaConfig.Offset = 1
			RescueItens_Config.ItemCount = GetWordPacket(PacketName, -1)
			local count = GetBytePacket(PacketName, -1)
			for c = 1, count do
				local ListID       = GetDwordPacket(PacketName, -1)
				local ItemIndex    = GetWordPacket(PacketName, -1)
				local Level        = GetBytePacket(PacketName, -1)
				local Durabilidade = GetBytePacket(PacketName, -1)
				local Skill        = GetBytePacket(PacketName, -1)
				local Luck         = GetBytePacket(PacketName, -1)
				local Opt          = GetBytePacket(PacketName, -1)
				local Excelente    = GetBytePacket(PacketName, -1)
				local Ancient      = GetBytePacket(PacketName, -1)
				local Harmony      = GetBytePacket(PacketName, -1)
				local X 		   = GetWordPacket(PacketName, -1)
				local Y 		   = GetWordPacket(PacketName, -1)
				local W 		   = GetWordPacket(PacketName, -1)
				local H 		   = GetWordPacket(PacketName, -1)
				local item = {Enabled = true, ListID = ListID, ItemIndex = ItemIndex, Level = Level, Durabilidade = Durabilidade, Skill = Skill, Luck = Luck, Opt = Opt, Excelente = Excelente, Ancient = Ancient, Harmony = Harmony, X = X, Y = Y, W = W, H = H}
				table.insert(RescueItens_Config.Lista, item)
			end
			RescueItens_Config.ListaConfig.Count = count
			RescueItens.GerarBarra()
			if RescueItens_Config.ItemCount > 50 then
				RescueItens_Config.AlertWindow.Type = 0
				RescueItens_Config.AlertWindow.Show = true
			end
			RescueItens.Open()
			return true
		end

		if PacketName == string.format("3-%s-%d", UserGetName(), UserGetIndex()) then
			local ret = GetBytePacket(PacketName, -1)
			ClearPacket(PacketName)
			RescueItens_Config.LockButton = false
			RescueItens_Config.ClickCount = 0
			if ret == 1 then
				RescueItens_Config.Lista[RescueItens_Config.ListaConfig.Selected].Enabled = false
				RescueItens_Config.ListaConfig.Selected = -1
				return true
			end

			RescueItens_Config.AlertWindow.Type = 1
			RescueItens_Config.AlertWindow.Show = true
			return true
		end
	end
end

function RescueItens.UpdateMouse()
	if RescueItens.CheckOpen() then
		local posX = WindowGetWidth()
		if MousePosX() < posX-190 then
			DisableClickClient()
		else
			if MousePosY() > 430 then
				DisableClickClient()
			end
		end

		if CheckReleasedKey(Keys.LButton) == 1 then
			if RescueItens.ButtonMouseOver(RescueItens_Config.ButtonID.up, MousePosX(), MousePosY()) then
				RescueItens_Config.Button[RescueItens_Config.ButtonID.up].clicked = true
				if RescueItens_Config.ListaConfig.Offset > 1 then
					if RescueItens_Config.m_ListOffset <= 1 then
						return
					end
					RescueItens_Config.ListaConfig.Offset = RescueItens_Config.ListaConfig.Offset - 1
					RescueItens_Config.ListaConfig.MaxValue = RescueItens_Config.ListaConfig.MaxValue - 1
					RescueItens_Config.ListaConfig.CurrentStep = RescueItens_Config.ListaConfig.CurrentStep - 1

					RescueItens_Config.Barra.Offset = RescueItens_Config.Barra.Offset - 1
					RescueItens_Config.Barra.Pos = RescueItens_Config.Barra.Pos - RescueItens_Config.Barra.Multiplier
					RescueItens_Config.m_ListOffset = RescueItens_Config.m_ListOffset - 1
				end
				return
			end

			if RescueItens.ButtonMouseOver(RescueItens_Config.ButtonID.down, MousePosX(), MousePosY()) then
				RescueItens_Config.Button[RescueItens_Config.ButtonID.down].clicked = true
				if RescueItens_Config.ListaConfig.Count > 7 then
					if RescueItens_Config.ListaConfig.MaxValue < RescueItens_Config.ListaConfig.Count then
						RescueItens_Config.ListaConfig.Offset = RescueItens_Config.ListaConfig.Offset + 1
						RescueItens_Config.ListaConfig.MaxValue = RescueItens_Config.ListaConfig.MaxValue + 1
						RescueItens_Config.ListaConfig.CurrentStep = RescueItens_Config.ListaConfig.CurrentStep + 1

						RescueItens_Config.Barra.Offset = RescueItens_Config.Barra.Offset + 1
						RescueItens_Config.Barra.Pos = RescueItens_Config.Barra.Pos + RescueItens_Config.Barra.Multiplier
						RescueItens_Config.m_ListOffset = RescueItens_Config.m_ListOffset + 1
					end
				end
				return
			end
		end
	end
end

function RescueItens.UpdateKey()
	if not RescueItens.CheckOpen() then return end

	if CheckWindowOpen(UIChatWindow) == 1 then return end

	DisableClickClient()

	if CheckPressedKey(Keys.I) == 1 or CheckPressedKey(Keys.V) == 1 then
		RescueItens.Close()
		return
	end

	if CheckPressedKey(Keys.Return) == 1 then
		if RescueItens_Config.AlertWindow.Show then
			RescueItens_Config.AlertWindow.Show = false
			return
		end
	end

	if CheckPressedKey(Keys.Escape) == 1 then
		if RescueItens_Config.AlertWindow.Show then
			RescueItens_Config.AlertWindow.Show = false
			return true
		else
			RescueItens.Close()
			return true
		end
	end
end

function RescueItens.RetirarItem()
	local PacketName = string.format("2-%s-%d", UserGetName(), UserGetIndex())
	CreatePacket(PacketName, RescueItens_Config.Packet)
	SetDwordPacket(PacketName, RescueItens_Config.Lista[RescueItens_Config.ListaConfig.Selected].ListID)
	SendPacket(PacketName)
	ClearPacket(PacketName)
	RescueItens_Config.LockButton = true
end

RescueItens.Init()

return RescueItens
