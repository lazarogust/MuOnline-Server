-- true Ativa o sistema, false desativa
JewelBank_Enabled = true

-- Id da interface, n�o pode ser igual a nenhum outro sistema custom
JewelBank_WindowId = 1

-- Numero do Packet usado no sistema (n�o pode ser igual ao de nenhum outro sistema)
JewelBank_Packet = 0x01

-- ListID (tem que ser o mesmo da configura��o no servidor)(tem que come�ar no 1 e n�o pode pular)
-- Index da j�ia
-- Nome da j�ia
-- Ajuste de posi��o do item na interface:
	-- X posi��o horizontal (0 = posi��o original, menor que 0 move para esquerda, mais que 0 move para direita)
	-- Y posi��o vertical (0 = posi��o original, menor que 0 move para esquerda, mais que 0 move para direita) 
	-- W largura da area que faz o item girar com mouse em cima
	-- H altura da area que faz o item girar com mouse em cima
JewelBank_Jewels = {
{ListID = 1 , Index = GET_ITEM(12, 15), Nome = "Jewel of Chaos",		Position = {X = 2, Y = -3, W = 13, H = 13}},
{ListID = 2 , Index = GET_ITEM(14, 13), Nome = "Jewel of Bless",		Position = {X = 2, Y =  0, W = 13, H = 13}},
{ListID = 3 , Index = GET_ITEM(14, 14), Nome = "Jewel of Soul",			Position = {X = 2, Y =  0, W = 13, H = 13}},
{ListID = 4 , Index = GET_ITEM(14, 16), Nome = "Jewel of Life",			Position = {X = 2, Y =  0, W = 13, H = 13}},
{ListID = 5 , Index = GET_ITEM(14, 22), Nome = "Jewel of Creation",		Position = {X = 2, Y =  0, W = 13, H = 13}},
{ListID = 6 , Index = GET_ITEM(14, 31), Nome = "Jewel of Guardian",		Position = {X = 2, Y = -1, W = 13, H = 13}},
{ListID = 7 , Index = GET_ITEM(14, 41), Nome = "Gemstone",				Position = {X = 2, Y =  2, W = 13, H = 13}},
{ListID = 8 , Index = GET_ITEM(14, 42), Nome = "Jewel of Harmony",		Position = {X = 2, Y =  2, W = 13, H = 13}},
{ListID = 9 , Index = GET_ITEM(14, 43), Nome = "Lower Refining Stone",	Position = {X = 0, Y =  0, W = 13, H = 13}},
{ListID = 10, Index = GET_ITEM(14, 44), Nome = "Higher Refining Stone",	Position = {X = 0, Y =  0, W = 13, H = 13}},
}

-- Textos do sistema
JewelBank_Texts = {}
JewelBank_Texts["Por"] = {
[1] = "     Banco de J�ias     ",
[2] = " Fechar ",
[3] = " Selecione uma j�ia para come�ar ",
[4] = " Fazer Retirada ",
}
JewelBank_Texts["Eng"] = {
[1] = "     Jewel Bank     ",
[2] = " Close ",
[3] = " Select one jewel to start ",
[4] = " Withdraw ",
}
JewelBank_Texts["Spn"] = {
[1] = "     Banco de Joyas     ",
[2] = " Cerrar ",
[3] = " Seleccione una joya para comenzar ",
[4] = " Sacar Joya ",
}



-- IN�CIO DO C�DIGO, S� MEXA SE SOUBER O QUE EST� FAZENDO --
JewelBank = {}
JewelBank_Buttons = {}
JewelBank_WorkArea = {X1 = 260, X2 = 450, Y1 = 0, Y2 = 429}
JewelBank_Saldo = {}
JewelBank_List = {}
JewelBank_ListOffset = 0
JewelBank_ScrollBar = {Offset = 0, MaxOffset = 0, Pos = 0, Esp = 180, Multiplier = 0}
JewelBank_Selected = {}
JewelBank_ButtonSelected = 0
JewelBank_ButtonValue = {[2] = 1,[3] = 10 ,[4] = 20 ,[5] = 30 ,[6] = 40 ,[7] = 50 ,[8] = 60 ,[9] = 70 ,[10] = 80 ,[11] = 90 ,[12] = 100,[13] = 110,[14] = 120,[15] = 130,[16] = 140,[17] = 150}
JewelBank_WindowOffset = 0

function JewelBank.Close()
	UICustomInterface = 0
	CloseWindow(UIInventory)
	JewelBank_ListOffset = 0
	JewelBank_Selected = {}
	JewelBank_ButtonSelected = 0
	JewelBank_WindowOffset = 0
end

function JewelBank.Open()
	local nome = UserGetName()
	CreatePacket(string.format("JBOpe_%s",nome), JewelBank_Packet)
	SendPacket(string.format("JBOpe_%s",nome))
	ClearPacket(string.format("JBOpe_%s",nome))
end

function JewelBank.Open2()
	if	CheckWindowOpen(UIFriendList)		== 1	then	return							end
	if	CheckWindowOpen(UIMoveList)			== 1	then	return							end
	if	CheckWindowOpen(UIParty)			== 1	then	CloseWindow(UIParty)			end
	if	CheckWindowOpen(UIQuest)			== 1	then	return							end
	if	CheckWindowOpen(UIGuild)			== 1	then	CloseWindow(UIGuild)			end
	if	CheckWindowOpen(UITrade)			== 1	then	return							end
	if	CheckWindowOpen(UIWarehouse)		== 1	then	return							end
	if	CheckWindowOpen(UIChaosBox)			== 1	then	return							end
	if	CheckWindowOpen(UICommandWindow)	== 1	then	return							end
	if	CheckWindowOpen(UIPetInfo)			== 1	then	return							end
	if	CheckWindowOpen(UIShop)				== 1	then	return							end
	if	CheckWindowOpen(UIStore)			== 1	then	CloseWindow(UIStore)			end
	if	CheckWindowOpen(UIOtherStore)		== 1	then	return							end
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
	JewelBank.GerarLista()
	JewelBank.GerarBarra()
	OpenWindow(UIInventory)
	UICustomInterface = JewelBank_WindowId
end

function JewelBank.GerarLista()
	local listcount = 0
	JewelBank_List = {}
	for i in ipairs(JewelBank_Jewels) do
		if i > JewelBank_ListOffset then
			if listcount < 8 then
				table.insert(JewelBank_List, JewelBank_Jewels[i]) 
				listcount = listcount + 1
			end
		end
	end
end

function JewelBank.GerarBarra()
	if JewelBank_ScrollBar.Offset > 0 then
		JewelBank_ScrollBar.Offset = 0
		JewelBank_ScrollBar.Pos = 0
	end
	JewelBank_ScrollBar.MaxOffset = #JewelBank_Jewels-8	
	JewelBank_ScrollBar.Multiplier = JewelBank_ScrollBar.Esp/(#JewelBank_Jewels-8)
end

function JewelBank.MoveBarDown()
	if JewelBank_ScrollBar.Offset < JewelBank_ScrollBar.MaxOffset then
		JewelBank_ScrollBar.Offset = JewelBank_ScrollBar.Offset + 1
		JewelBank_ScrollBar.Pos = JewelBank_ScrollBar.Pos + JewelBank_ScrollBar.Multiplier
	end
end

function JewelBank.MoveBarUp()
	if JewelBank_ScrollBar.Offset > 0 then
		JewelBank_ScrollBar.Offset = JewelBank_ScrollBar.Offset - 1
		JewelBank_ScrollBar.Pos = JewelBank_ScrollBar.Pos - JewelBank_ScrollBar.Multiplier
	end
end

function JewelBank.CreateButton(IdBotao, X, Y, W, H)
	if JewelBank_Buttons[IdBotao] == nil then
		table.insert(JewelBank_Buttons, IdBotao)
	end
	JewelBank_Buttons[IdBotao] = {X1 = X + (2*GetWideX()), X2 = X+W + (2*GetWideX()), Y1 = Y, Y2 = Y+H}
end

function JewelBank.CheckButton(IdBotao, X, Y)
	if JewelBank_Buttons[IdBotao] == nil then return false end
	if X >= JewelBank_Buttons[IdBotao].X1 - (2*GetWideX()) and X <= JewelBank_Buttons[IdBotao].X2 - (2*GetWideX()) and Y >= JewelBank_Buttons[IdBotao].Y1 and Y <= JewelBank_Buttons[IdBotao].Y2 then
		return true
	end
	return false
end

function JewelBank.BeforeInterface()
	if UICustomInterface == JewelBank_WindowId then
		if	CheckWindowOpen(UIInventory) 		== 0	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIFriendList) 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIMoveList)			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIParty) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIQuest) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIGuild) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UITrade) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIWarehouse) 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIChaosBox)			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UICommandWindow) 	== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIPetInfo)	 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIShop)				== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIStore) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIOtherStore) 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UICharacter) 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIOptions) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIHelp)				== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIFastDial)			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UISkillTree) 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UINPC_Titus) 		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UICashShop)			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIFullMap) 			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UINPC_Dialog)		== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UIGensInfo)			== 1	then	JewelBank.Close()	end
		if	CheckWindowOpen(UINPC_Julia)		== 1	then	JewelBank.Close()	end

		EnableAlphaTest()
		
		RenderImage(31319, 260 + (2*GetWideX())-GuardiaoBrindes_Config.WindowOffset, 0, 190, 428)
		RenderImage(31347, 260 + (2*GetWideX())-GuardiaoBrindes_Config.WindowOffset, 0, 190, 64)
		RenderImage(31349, 260 + (2*GetWideX())-GuardiaoBrindes_Config.WindowOffset, 64, 21, 320)
		RenderImage(31350, 429 + (2*GetWideX())-GuardiaoBrindes_Config.WindowOffset, 64, 21, 320)
		RenderImage(31351, 260 + (2*GetWideX())-GuardiaoBrindes_Config.WindowOffset, 384, 190, 45)
		
		SetFontType(1)
		SetTextBg(0, 0, 0, 255)
		SetTextColor(255, 255, 255, 255)
		RenderText3(355-JewelBank_WindowOffset + (2*GetWideX()), 12, string.format(JewelBank_Texts[GetLanguage()][1]), 80, 8)
		
		JewelBank.CreateButton(1, 428-JewelBank_WindowOffset, 6, 14, 14) 		
		
		DisableAlphaBlend()
		
		SetBlend()
		glColor4f(0.0, 0.0, 0.0, 0.7)			
		DrawBar(273-JewelBank_WindowOffset + (2*GetWideX()), 36, 160, 23)		
		DrawBar(273-JewelBank_WindowOffset + (2*GetWideX()), 196, 154, 202)		
		local ItemY = 223
		for i in ipairs(JewelBank_List) do
			CreateItem((280+JewelBank_List[i].Position.X)-JewelBank_WindowOffset + (2*GetWideX()), ((ItemY-20)+JewelBank_List[i].Position.Y), JewelBank_List[i].Position.W, JewelBank_List[i].Position.H, JewelBank_List[i].Index, 0, 0, 0)					
				
			glColor4f(0.5, 0.5, 0.5, 0.4)
			DrawBar(285-JewelBank_WindowOffset + (2*GetWideX()), ItemY, 130, 1)
			ItemY = ItemY+25
		end
		
		if JewelBank_Selected.ListID ~= nil 
		then
			CreateItem((280+JewelBank_Selected.Position.X)-JewelBank_WindowOffset + (2*GetWideX()), (43+JewelBank_Selected.Position.Y), JewelBank_Selected.Position.W, JewelBank_Selected.Position.H, JewelBank_Selected.Index, 0, 0, 0)
		end
		
		GLSwitchBlend()	
		glColor3f(1.0,1.0,1.0)
		GLSwitch()
		
		EnableAlphaTest()
		RenderImage(31337, 272-JewelBank_WindowOffset + (2*GetWideX()), 195, 14, 14)
		RenderImage(31338, 423-JewelBank_WindowOffset + (2*GetWideX()), 195, 14, 14)
		RenderImage(31339, 272-JewelBank_WindowOffset + (2*GetWideX()), 390, 14, 14)
		RenderImage(31340, 423-JewelBank_WindowOffset + (2*GetWideX()), 390, 14, 14)
		RenderImage(31341, 286-JewelBank_WindowOffset + (2*GetWideX()), 195, 137, 14)
		RenderImage(31342, 286-JewelBank_WindowOffset + (2*GetWideX()), 390, 137, 14)
		RenderImage(31343, 272-JewelBank_WindowOffset + (2*GetWideX()), 208, 14, 182)
		RenderImage(31344, 423-JewelBank_WindowOffset + (2*GetWideX()), 208, 14, 182)
		
		RenderImage(31337, 272-JewelBank_WindowOffset + (2*GetWideX()), 35, 14, 14)
		RenderImage(31338, 423-JewelBank_WindowOffset + (2*GetWideX()), 35, 14, 14)
		RenderImage(31341, 286-JewelBank_WindowOffset + (2*GetWideX()), 35, 137, 14)
		RenderImage(31339, 272-JewelBank_WindowOffset + (2*GetWideX()), 49, 14, 14)
		RenderImage(31340, 423-JewelBank_WindowOffset + (2*GetWideX()), 49, 14, 14)
		RenderImage(31342, 286-JewelBank_WindowOffset + (2*GetWideX()), 49, 137, 14)
		
		if JewelBank_Selected.ListID ~= nil then
			SetFontType(0)
			SetTextBg(0, 0, 0, 0)			
			local id = 2
			for y = 65, 140, 25 do
				for x = 275, 395, 40 do
					JewelBank.CreateButton(id, x-JewelBank_WindowOffset, y, 34, 23)
					RenderImage2(32342, x-JewelBank_WindowOffset + (2*GetWideX()), y, 60, 23,0, 0, 1.0, 1.0, 1, 1, 1.0)
					if JewelBank_ButtonSelected == id then
						SetTextColor(255, 204, 0, 255)
					else
						SetTextColor(0, 221, 255, 255)
					end					
					RenderText3(x-JewelBank_WindowOffset + (2*GetWideX()), y+6, string.format(" %d ", JewelBank_ButtonValue[id]), 40, 3)
					id = id + 1
				end
			end	
		end
		
		if JewelBank_Selected.ListID ~= nil then
			SetFontType(1)
			SetTextBg(0, 0, 0, 0)
			SetTextColor(255, 204, 0, 255)
			RenderText3(305-JewelBank_WindowOffset + (2*GetWideX()), 43, string.format(JewelBank_Selected.Nome), 100, 3)
			SetTextColor(255, 255, 255, 165)
			RenderText3(420-JewelBank_WindowOffset + (2*GetWideX()), 43, string.format("%dx",JewelBank_Saldo[JewelBank_Selected.ListID]), 50, 7)
			
			JewelBank.CreateButton(18, 310-JewelBank_WindowOffset, 165, 90, 25)
		
			if JewelBank.CheckButton(18, MousePosX(), MousePosY()) then
				RenderImage2(31323, 310-JewelBank_WindowOffset + (2*GetWideX()), 165, 110, 25,0, 0.2264566, 1.0, 0.2245212, 1, 1, 1.0)
			else
				RenderImage2(31323, 310-JewelBank_WindowOffset + (2*GetWideX()), 165, 110, 25,0, 0, 1.0, 0.2245212, 1, 1, 1.0)
			end
			
			SetTextBg(0, 0, 0, 0)
			SetTextColor(255, 255, 255, 230)
			--RenderText5(315-JewelBank_WindowOffset, 172, string.format(JewelBank_Texts[GetLanguage()][4]), 3)
			RenderText3(322-JewelBank_WindowOffset + (2*GetWideX()), 172, string.format(JewelBank_Texts[GetLanguage()][4]), 70, 3)
			
		else
			SetFontType(1)
			SetTextBg(0, 0, 0, 0)
			SetTextColor(255, 204, 0, 255)
			RenderText3(280-JewelBank_WindowOffset + (2*GetWideX()), 43, string.format(JewelBank_Texts[GetLanguage()][3]), 150, 3)
		end
		
		RenderImage(31269, 426-JewelBank_WindowOffset + (2*GetWideX()), 195, 7, 3)
		for y = 198, 393, 5 do
			RenderImage(31270, 426-JewelBank_WindowOffset + (2*GetWideX()), y, 7, 5)
		end
		RenderImage(31271, 426-JewelBank_WindowOffset + (2*GetWideX()), 397, 7, 3)
		RenderImage(31272, 422-JewelBank_WindowOffset + (2*GetWideX()), (192+JewelBank_ScrollBar.Pos), 15, 30)	-- scrollbar
			
		local ItemY = 223
		for i in ipairs(JewelBank_List) do
			SetFontType(0)
			SetTextBg(0, 0, 0, 0)
			if JewelBank_Selected.ListID ~= nil then
				if JewelBank_Selected.ListID == JewelBank_List[i].ListID then
					SetTextColor(0, 221, 255, 255)
				else
					SetTextColor(255, 255, 255, 230)
				end
			else
				SetTextColor(255, 255, 255, 230)
			end
			RenderText5(315-JewelBank_WindowOffset + (2*GetWideX()), ItemY-16, string.format("%s",JewelBank_List[i].Nome), ALIGN_LEFT)
			if JewelBank_Saldo[JewelBank_List[i].ListID] ~= nil then
				SetTextBg(0, 0, 0, 0)
				SetTextColor(255, 255, 255, 165)
				RenderText5(290-JewelBank_WindowOffset + (2*GetWideX()), ItemY-8, string.format("%dx", JewelBank_Saldo[JewelBank_List[i].ListID]), ALIGN_CENTER)
			end
			
			ItemY = ItemY+25
		end
		
		if JewelBank.CheckButton(1, MousePosX() - (2*GetWideX()), MousePosY()) then
			SetFontType(0)
			SetTextBg(0, 0, 0, 255)
			SetTextColor(255, 255, 255, 255)
			RenderText5(425-JewelBank_WindowOffset + (2*GetWideX()), 30, string.format(JewelBank_Texts[GetLanguage()][2]), ALIGN_LEFT)
		end

		DisableAlphaBlend()
	end
end

function JewelBank.Protocol(Packet, PacketName)
	if Packet == JewelBank_Packet then
		local nome = UserGetName()
		if PacketName == string.format("JBOpe_%s",nome) then
			JewelBank_Saldo = {}
			local count = GetBytePacket(PacketName, -1)
			for i = 1, count do
				local listid = GetBytePacket(PacketName, -1)
				local valor = GetWordPacket(PacketName, -1)
				
				table.insert(JewelBank_Saldo, listid)
				JewelBank_Saldo[listid] = valor
			end
			ClearPacket(PacketName)
			JewelBank.Open2()
			return true
		end
		
		if PacketName == string.format("JBBal_%s",nome) then
			if UICustomInterface == JewelBank_WindowId then
				local listid = GetBytePacket(PacketName, -1)
				local valor = GetWordPacket(PacketName, -1)
				if JewelBank_Saldo[listid] ~= nil then
					JewelBank_Saldo[listid] = valor
				end
			end
			ClearPacket(PacketName)
			return true
		end
	end
end

function JewelBank.KeyListener(key)
	if CheckWindowOpen(UIChatWindow) == 0 and CheckWindowOpen(UIStore) == 0 
	then
		if key == Keys.J then
			if JewelBank_Enabled then
				if UICustomInterface == JewelBank_WindowId then
					JewelBank.Close()
				else
					if UICustomInterface == 0 then
						JewelBank.Open()
					end
					return
				end
				return
			end
		end
		
		if key == Keys.V or key == Keys.I or key == Keys.Escape then
			if UICustomInterface == JewelBank_WindowId then
				JewelBank.Close()
				return
			end
		end
	end
end

function JewelBank.ScrollMouse(Direction)
	local x = MousePosX() - (2*GetWideX())
	local y = MousePosY()
	if UICustomInterface == JewelBank_WindowId then
		if x >= 275-JewelBank_WindowOffset and x <= 436-JewelBank_WindowOffset and y >= 196 and y <= 399 then
			if Direction > 0 then
				if JewelBank_ListOffset >= 1 then
					JewelBank_ListOffset = JewelBank_ListOffset - 1
					JewelBank.GerarLista()
					JewelBank.MoveBarUp()
				end
				return
			else				
				if #JewelBank_Jewels > 8 then
					if #JewelBank_Jewels-JewelBank_ListOffset > 8 then
						JewelBank_ListOffset = JewelBank_ListOffset + 1
						JewelBank.GerarLista()
						JewelBank.MoveBarDown()
					end
				end
				return				
			end
			return
		end
	end
end

function JewelBank.ClickEvent()
	if UICustomInterface == JewelBank_WindowId then
		if JewelBank.CheckButton(1, MousePosX() - (2*GetWideX()), MousePosY()) then
			if UICustomInterface == JewelBank_WindowId then
				JewelBank.Close()
			end
		end
		
		for id = 2, 17 do
			if JewelBank.CheckButton(id, MousePosX() - (2*GetWideX()), MousePosY()) then
				JewelBank_ButtonSelected = id
				return
			end
		end
		
		if JewelBank.CheckButton(18, MousePosX() - (2*GetWideX()), MousePosY()) then
			if JewelBank_Selected.ListID == nil or JewelBank_Selected.ListID == 0 or JewelBank_ButtonSelected == 0 then
				return
			end
			local nome = UserGetName()
			CreatePacket(string.format("JBSac_%s",nome), JewelBank_Packet)
			SetBytePacket(string.format("JBSac_%s",nome), JewelBank_Selected.ListID)
			SetBytePacket(string.format("JBSac_%s",nome), JewelBank_ButtonSelected)
			SendPacket(string.format("JBSac_%s",nome))
			ClearPacket(string.format("JBSac_%s",nome))
			return
		end
		
		local ItemY = 223
		for i in ipairs(JewelBank_List) do
			if MousePosX() >=280-JewelBank_WindowOffset + (2*GetWideX()) and MousePosX() <= 420-JewelBank_WindowOffset + (2*GetWideX()) and MousePosY() >= ItemY-23 and MousePosY() <= ItemY-2 then
				JewelBank_Selected = JewelBank_List[i]
				return
			end
			ItemY = ItemY+25
		end
	end
end

function JewelBank.UpdateMouse()
	if UICustomInterface == JewelBank_WindowId then
		if MousePosX()  >= JewelBank_WorkArea.X1-JewelBank_WindowOffset + (2*GetWideX()) and MousePosX() <= JewelBank_WorkArea.X2-JewelBank_WindowOffset + (2*GetWideX()) and MousePosY() >= JewelBank_WorkArea.Y1 and MousePosY() <= JewelBank_WorkArea.Y2 then
			DisableClickClient()
			return
		end
	end	
end

function JewelBank.ClickRightEvent()
	if CheckRepeatKey(Keys.Menu) ~= 0 then
		local slot = GetInventoryMouseSlot()
		if slot >= 12 then
			local nome = UserGetName()
			
			CreatePacket(string.format("JBDep_%s",nome), JewelBank_Packet)
			SetBytePacket(string.format("JBDep_%s",nome), slot)			
			SendPacket(string.format("JBDep_%s",nome))
			ClearPacket(string.format("JBDep_%s",nome))
			return
		end
		
	end
end

InterfaceController.BeforeMainProc(JewelBank.BeforeInterface)
InterfaceController.ClientProtocol(JewelBank.Protocol)
InterfaceController.MainProcWorldKey(JewelBank.KeyListener)
InterfaceController.ScrollMouse(JewelBank.ScrollMouse)
InterfaceController.InterfaceClickEvent(JewelBank.ClickEvent)
InterfaceController.InterfaceClickRightEvent(JewelBank.ClickRightEvent)
InterfaceController.UpdateMouse(JewelBank.UpdateMouse)

return JewelBank