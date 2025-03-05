Utils = {}

local sx = 0.0
local ex = 1.0
local sy = 0.0
local ey = 1.0

function Utils.CheckWindow()
    if	CheckWindowOpen(UIFriendList)		== 1	then	return true  end
	if	CheckWindowOpen(UIMoveList)			== 1	then	return true  end
	if	CheckWindowOpen(UIParty)			== 1	then	return true  end
	if	CheckWindowOpen(UIQuest)			== 1	then	return true  end
	if	CheckWindowOpen(UIGuild)			== 1	then	return true  end
	if	CheckWindowOpen(UITrade)			== 1	then	return true  end
	if	CheckWindowOpen(UIWarehouse)		== 1	then	return true  end
	if	CheckWindowOpen(UIChaosBox)			== 1	then	return true  end
	if	CheckWindowOpen(UICommandWindow)	== 1	then	return true  end
	if	CheckWindowOpen(UIPetInfo)			== 1	then	return true  end
	if	CheckWindowOpen(UIShop)				== 1	then	return true  end
	if	CheckWindowOpen(UIStore)			== 1	then	return true  end
	if	CheckWindowOpen(UIOtherStore)		== 1	then	return true  end
	if	CheckWindowOpen(UICharacter)		== 1	then	return true  end
	if	CheckWindowOpen(UIOptions)			== 1	then	return true  end
	if	CheckWindowOpen(UIHelp)				== 1	then	return true  end
	if	CheckWindowOpen(UIFastDial)			== 1	then	return true  end
	if	CheckWindowOpen(UISkillTree)		== 1	then	return true  end
	if	CheckWindowOpen(UINPC_Titus)		== 1	then	return true  end
	if	CheckWindowOpen(UICashShop)			== 1	then	return true  end
	if	CheckWindowOpen(UIFullMap)			== 1	then	return true  end
	if	CheckWindowOpen(UINPC_Dialog)		== 1	then	return true  end
	if	CheckWindowOpen(UIGensInfo)			== 1	then	return true  end
	if	CheckWindowOpen(UINPC_Julia)		== 1	then	return true  end
	--if	CheckWindowOpen(UIExpandInventory)	== 1	then	return true  end
	--if	CheckWindowOpen(UIExpandWarehouse)	== 1	then	return true  end
	--if	CheckWindowOpen(UIMuHelper)			== 1	then	return true  end
	if	CheckWindowOpen(UIInventory)		== 1	then	return true  end
	if  CheckWindowOpen(UIChatWindow)		== 1	then	return true  end
--	if	QuestSystem.CheckOpen()				== 1	then	return true  end
--	if	QuestSystemNpc.CheckOpen()			== 1	then	return true  end
end

function Utils.MakeDrawWindow(x, y, r, g, b, a, width, heigth)
	EnableAlphaTest()

	SetBlend()
	glColor4f(r, g, b, a)

	DrawBar(x, y, width, heigth)

	EndDrawBar()
	GLSwitchBlend()

	glColor3f(1.0, 1.0, 1.0)

	GLSwitch()
	glColor3f(1.0, 1.0, 1.0)

	DisableAlphaBlend()
end

function Utils.EnableAlpha()
	EnableAlphaTest()

	SetBlend()
	glColor4f(0.0, 0.0, 0.0, 0.8)

	GLSwitchBlend()

	glColor3f(1.0, 1.0, 1.0)
end

function Utils.DisableAlpha()
	GLSwitch()
	glColor3f(1.0, 1.0, 1.0)

	DisableAlphaBlend()
end

function Utils.CreateButton(IdBotao, X, Y, W, H, tableParam)
	if tableParam[IdBotao] == nil then
		table.insert(tableParam, IdBotao)
	end
	tableParam[IdBotao] = {X1 = X, X2 = X+W, Y1 = Y, Y2 = Y+H}
end

function Utils.CheckButton(IdBotao, X, Y, tableParam)
	if tableParam[IdBotao] == nil then return false end
	if X >= tableParam[IdBotao].X1 and X <= tableParam[IdBotao].X2 and Y >= tableParam[IdBotao].Y1 and Y <= tableParam[IdBotao].Y2 then
		return true
	end
	return false
end



return Utils