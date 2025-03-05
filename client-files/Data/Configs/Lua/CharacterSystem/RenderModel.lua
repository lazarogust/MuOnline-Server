OpenFolder("Definitions")

--[[
Render your itens
--]]

local anyWingGhost = 0
local WingGhostStartImg = 50000

local ITEM_TRANSPARENTE = {}
ITEM_TRANSPARENTE[GET_ITEM_MODEL(07, 200)] = { levelMin = 11, levelMax = 15 } -- Helm 02
ITEM_TRANSPARENTE[GET_ITEM_MODEL(08, 200)] = { levelMin = 11, levelMax = 15 } -- Armor 02
ITEM_TRANSPARENTE[GET_ITEM_MODEL(09, 200)] = { levelMin = 11, levelMax = 15 } -- Pants 02
ITEM_TRANSPARENTE[GET_ITEM_MODEL(10, 200)] = { levelMin = 11, levelMax = 15 } -- Gloves 02
ITEM_TRANSPARENTE[GET_ITEM_MODEL(11, 200)] = { levelMin = 11, levelMax = 15 } -- Boots 02

ITEM_TRANSPARENTE[GET_ITEM_MODEL(07, 201)] = { levelMin = 11, levelMax = 15 } -- Helm 02
ITEM_TRANSPARENTE[GET_ITEM_MODEL(08, 201)] = { levelMin = 11, levelMax = 15 } -- Armor 02
ITEM_TRANSPARENTE[GET_ITEM_MODEL(09, 201)] = { levelMin = 11, levelMax = 15 } -- Pants 02
ITEM_TRANSPARENTE[GET_ITEM_MODEL(10, 201)] = { levelMin = 11, levelMax = 15 } -- Gloves 02
ITEM_TRANSPARENTE[GET_ITEM_MODEL(11, 201)] = { levelMin = 11, levelMax = 15 } -- Boots 02

function StartLoadImages()
	--for i = 0, 11 do
	--LoadImage(string.format("Item\\Render1120DcMakers.jpg", i), WingGhostStartImg + i)
	--end

	--LoadImage("Item\\Render1120DcMakers.jpg", 40013)
end

function RenderModelBody(BMDStruct, ObjectStruct, ItemIndex)
	local itemTransparente = ITEM_TRANSPARENTE[ItemIndex]

	if itemTransparente ~= nil
	then
		local Bmd = BMD.new(BMDStruct)

		Bmd:glColor3fv()
		Bmd:SetLight(1.0, 1.0, 1.0)
		Bmd = nil

		return 1
	end

	if (ItemIndex == GET_ITEM_MODEL(7, 100)) --Helm 02x
	then
		local Bmd = BMD.new(BMDStruct)
		local Obj = Object.new(ObjectStruct)

		if Bmd:GetLight(0) ~= 1.0 or Bmd:GetLight(1) ~= 1.0 or Bmd:GetLight(2) ~= 1.0
		then
			Bmd:glColor3fv()
			Bmd:SetLight(1.0, 1.0, 1.0)
			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-2.0, 0.0) + 0.00
			if Vertex > 100.0
			then
				Vertex = 100.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)
			Bmd:glColor3fv()
			Bmd:RenderMesh(1, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		else
			Bmd:glColor3fv()
			Bmd:SetLight(1.0, 1.0, 1.0)
			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-2.0, 0.0) + 0.00
			if Vertex > 100.0
			then
				Vertex = 100.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)
			Bmd:glColor3fv()
			Bmd:RenderMesh(1, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		end

		Bmd = nil
		Obj = nil

		return 1
	end

	if (ItemIndex == GET_ITEM_MODEL(8, 100)) --Armor 02x
	then
		local Bmd = BMD.new(BMDStruct)
		local Obj = Object.new(ObjectStruct)

		if Bmd:GetLight(0) ~= 1.0 or Bmd:GetLight(1) ~= 1.0 or Bmd:GetLight(2) ~= 1.0
		then
			Bmd:SetLight(1.0, 1.0, 1.0)
			Bmd:glColor3fv()
			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			Bmd:RenderMesh(1, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-2.0, 0.0) + 0.00
			if Vertex > 100.0
			then
				Vertex = 100.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)
			Bmd:glColor3fv()
			Bmd:RenderMesh(2, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			Bmd:RenderMesh(3, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		else
			Bmd:SetLight(1.0, 1.0, 1.0)
			Bmd:glColor3fv()
			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			Bmd:RenderMesh(1, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-2.0, 0.0) + 0.00
			if Vertex > 100.0
			then
				Vertex = 100.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)
			Bmd:glColor3fv()
			Bmd:RenderMesh(2, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
			Bmd:RenderMesh(3, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		end


		Bmd = nil
		Obj = nil

		return 1
	end

	if (ItemIndex == GET_ITEM_MODEL(10, 100)) --02x
	then
		local Bmd = BMD.new(BMDStruct)
		local Obj = Object.new(ObjectStruct)

		if Bmd:GetLight(0) ~= 1.0 or Bmd:GetLight(1) ~= 1.0 or Bmd:GetLight(2) ~= 1.0
		then
			Bmd:SetLight(1.0, 1.0, 1.0)
			Bmd:glColor3fv()
			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-2.0, 0.0) + 0.00
			if Vertex > 100.0
			then
				Vertex = 100.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)
			Bmd:glColor3fv()
			Bmd:RenderMesh(1, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		else
			Bmd:SetLight(1.0, 1.0, 1.0)
			Bmd:glColor3fv()
			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-2.0, 0.0) + 0.00
			if Vertex > 100.0
			then
				Vertex = 100.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)
			Bmd:glColor3fv()
			Bmd:RenderMesh(1, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		end


		Bmd = nil
		Obj = nil

		return 1
	end

	if (ItemIndex == GET_ITEM_MODEL(11, 100)) --02x
	then
		local Bmd = BMD.new(BMDStruct)
		local Obj = Object.new(ObjectStruct)

		if Bmd:GetLight(0) ~= 1.0 or Bmd:GetLight(1) ~= 1.0 or Bmd:GetLight(2) ~= 1.0
		then
			Bmd:SetLight(1.0, 1.0, 1.0)
			Bmd:glColor3fv()
			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-2.0, 0.0) + 0.00
			if Vertex > 100.0
			then
				Vertex = 100.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)
			Bmd:glColor3fv()
			Bmd:RenderMesh(1, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		else
			Bmd:SetLight(1.0, 1.0, 1.0)
			Bmd:glColor3fv()
			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-2.0, 0.0) + 0.00
			if Vertex > 100.0
			then
				Vertex = 100.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)
			Bmd:glColor3fv()
			Bmd:RenderMesh(1, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		end


		Bmd = nil
		Obj = nil

		return 1
	end

	if (ItemIndex == GET_ITEM_MODEL(0, 201)) --02x
	then
		local Bmd = BMD.new(BMDStruct)
		local Obj = Object.new(ObjectStruct)

		if Bmd:GetLight(0) ~= 1.0 or Bmd:GetLight(1) ~= 1.0 or Bmd:GetLight(2) ~= 1.0
		then
			Bmd:SetLight(1.0, 1.0, 1.0)
			Bmd:glColor3fv()
			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-2.0, 0.0) + 0.00
			if Vertex > 100.0
			then
				Vertex = 100.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)
			Bmd:glColor3fv()
			Bmd:RenderMesh(1, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		else
			Bmd:SetLight(1.0, 1.0, 1.0)
			Bmd:glColor3fv()
			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-2.0, 0.0) + 0.00
			if Vertex > 100.0
			then
				Vertex = 100.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)
			Bmd:glColor3fv()
			Bmd:RenderMesh(1, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		end


		Bmd = nil
		Obj = nil

		return 1
	end

	if (ItemIndex == GET_ITEM_MODEL(6, 100)) --Helm 02x
	then
		local Bmd = BMD.new(BMDStruct)
		local Obj = Object.new(ObjectStruct)

		if Bmd:GetLight(0) ~= 1.0 or Bmd:GetLight(1) ~= 1.0 or Bmd:GetLight(2) ~= 1.0
		then
			Bmd:glColor3fv()
			Bmd:SetLight(1.0, 1.0, 1.0)
			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-2.0, 0.0) + 0.00
			if Vertex > 100.0
			then
				Vertex = 100.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)
			Bmd:glColor3fv()
			Bmd:RenderMesh(1, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		else
			Bmd:glColor3fv()
			Bmd:SetLight(1.0, 1.0, 1.0)
			Bmd:RenderMesh(0, 2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)

			local Vertex = GetDoubleRender(-2.0, 0.0) + 0.00
			if Vertex > 100.0
			then
				Vertex = 100.0
			end

			Bmd:SetLight(Vertex, Vertex, Vertex)
			Bmd:glColor3fv()
			Bmd:RenderMesh(1, 66, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), -1)
		end

		Bmd = nil
		Obj = nil

		return 1
	end


	return 0
end

local ITEM_REMOVEGLOW = {}

ITEM_REMOVEGLOW[GET_ITEM_MODEL(7, 100)] = { removeglow = true }  -- Helm
ITEM_REMOVEGLOW[GET_ITEM_MODEL(8, 100)] = { removeglow = true }  -- Armor
ITEM_REMOVEGLOW[GET_ITEM_MODEL(9, 100)] = { removeglow = true }  -- Pants
ITEM_REMOVEGLOW[GET_ITEM_MODEL(10, 100)] = { removeglow = true } -- Gloves
ITEM_REMOVEGLOW[GET_ITEM_MODEL(11, 100)] = { removeglow = true } -- Boots

ITEM_REMOVEGLOW[GET_ITEM_MODEL(7, 101)] = { removeglow = true }  -- Helm
ITEM_REMOVEGLOW[GET_ITEM_MODEL(8, 101)] = { removeglow = true }  -- Armor
ITEM_REMOVEGLOW[GET_ITEM_MODEL(9, 101)] = { removeglow = true }  -- Pants
ITEM_REMOVEGLOW[GET_ITEM_MODEL(10, 101)] = { removeglow = true } -- Gloves
ITEM_REMOVEGLOW[GET_ITEM_MODEL(11, 101)] = { removeglow = true } -- Boots

function RenderModelBodyColor(BMDStruct, ObjectStruct, ItemIndex)
	--if (ItemIndex >= GET_ITEM_MODEL(7, 0) and ItemIndex <= GET_ITEM_MODEL(11, 511))
	--then
	--	return 1
	--end

	return 0
end

function RenderModelBodyColor2(BMDStruct, ObjectStruct, ItemIndex)
	local removeglow = ITEM_REMOVEGLOW[ItemIndex]

	if removeglow ~= nil
	then
		return 1
	end

	local itemTransparente = ITEM_TRANSPARENTE[ItemIndex]

	if itemTransparente ~= nil
	then
		return 1
	end

	return 0
end
