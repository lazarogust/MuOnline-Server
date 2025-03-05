OpenFolder("Definitions")

DARK_SPIRIT_INFO = {
    { ItemIndex = GET_ITEM(13, 139), ModelName = 'ravenwhite', ObjectName = 'ravenwhite' },
    { ItemIndex = GET_ITEM(13, 200), ModelName = 'eaglecustom', ObjectName = 'eaglecustom' },
}

--Models config
DARK_SPIRIT_RENDER_MODEL = {}
DARK_SPIRIT_RENDER_MODEL[GET_ITEM(13, 139)] = {
    { renderType = 2, layer = 0, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, textureID = -1 },
    { renderType = 2, layer = 1, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, textureID = -1 },
    { renderType = 2, layer = 2, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, textureID = -1 },
    { renderType = 2, layer = 3, effectLayer = 2, lightR = 1.0, lightG = 1.0, lightB = 1.0, color3fv = 0, textureID = -1 },
}

--Effects config
DARK_SPIRIT_EFFECT = {}

DARK_SPIRIT_EFFECT[GET_ITEM(13, 139)] = {
    { Type = 0, EffectID = 32002, EffectLv = 0, Bone = 15, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
    { Type = 0, EffectID = 32002, EffectLv = 0, Bone = 16, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
    { Type = 0, EffectID = 32002, EffectLv = 0, Bone = 17, Size = 0.90, ColorR = 0.80, ColorG = 0.20, ColorB = 0.80, Black = 0, RandTime = 100 }, 
}

function StartLoadDarkSpirit()
    for i = 1, #DARK_SPIRIT_INFO do
        SetDarkSpirit(DARK_SPIRIT_INFO[i].ItemIndex, DARK_SPIRIT_INFO[i].ModelName, DARK_SPIRIT_INFO[i].ObjectName)
    end
end

function RenderModel(BMDStruct, ObjectStruct, ItemIndex)
    local Bmd = BMD.new(BMDStruct)
    local Obj = Object.new(ObjectStruct)

    local getRenderModel = DARK_SPIRIT_RENDER_MODEL[ItemIndex]

    if getRenderModel ~= nil
    then
        for i = 1, #getRenderModel do
			local render = getRenderModel[i]

            Bmd:SetLight(render.lightR, render.lightG, render.lightB)

            if render.color3fv == 1
			then
				Bmd:glColor3fv()
			end
			
			if render.RenderType == 1
			then
				Bmd:RenderBody(render.layer, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), render.textureID)
			else
				Bmd:RenderMesh(render.layer, render.effectLayer, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), render.textureID)
			end
        end
    else
        Bmd:SetLight(1.0, 1.0, 1.0)

        Bmd:RenderBody(2, Obj:Alpha(), Obj:Mesh(), Obj:Light(), Obj:TexCoordU(), Obj:TexCoordV(), Obj:Hidden(), -1)
    end

    local getEffectModel = DARK_SPIRIT_EFFECT[ItemIndex]

    if getEffectModel ~= nil
    then
        math.randomseed(os.time())

        for i = 1, #getEffectModel do
            local effect = getEffectModel[i]

            local randValue = 100
			
			if effect.RandTime ~= 100
			then
				randValue = math.random(1, 100)
			end
			
			if effect.RandTime >= randValue
			then
				if effect.Type == 0
				then
					CreateSprite(BMDStruct, effect.EffectID, effect.Bone, effect.Size, effect.ColorR, effect.ColorG, effect.ColorB, ObjectStruct)
				else
					CreateParticle(BMDStruct, effect.EffectID, effect.EffectLv, effect.Bone, effect.Size, effect.ColorR, effect.ColorG, effect.ColorB, ObjectStruct)
				end
			end
        end
    end

    Bmd = nil
    Obj = nil

    collectgarbage()
end

StartLoadDarkSpirit()