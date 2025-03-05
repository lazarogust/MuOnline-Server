--[[ 

    Charsets:
    160 -> BRL, ENG, SPN
    1   -> BRL, ENG, SPN -> maybe don't accept accent
    129 -> KOR
    136 -> TAI
    134 -> CHS
    128 -> JPN
    222 -> TAI OR PHI OR VIET
    163 -> VIET
]]


local FW_THIN = 100
local FW_ULTRALIGHT = 200
local FW_LIGHT = 300
local FW_NORMAL = 400
local FW_MEDIUM = 500
local FW_SEMIBOLD = 600
local FW_BOLD = 700
local FW_ULTRABOLD = 800
local FW_HEAVY = 900


Fonts = {
    {Index = 4 ,  Name = "Arial", MultiplySize = 1.5, AddSize = 0,  Bold = FW_BOLD, Italico = 0, Sublinhado = 0, Riscado = 0, Charset = 160},
    {Index = 5 ,  Name = "Arial", MultiplySize = 1.4, AddSize = 0,  Bold = FW_BOLD, Italico = 0, Sublinhado = 0, Riscado = 0, Charset = 160},
    {Index = 6 ,  Name = "Arial", MultiplySize = 1.6, AddSize = 0,  Bold = FW_BOLD, Italico = 0, Sublinhado = 0, Riscado = 0, Charset = 160},
    {Index = 7 ,  Name = "Arial", MultiplySize = 1.2, AddSize = 0,  Bold = FW_BOLD, Italico = 0, Sublinhado = 0, Riscado = 0, Charset = 160},
    {Index = 8 ,  Name = "Arial", MultiplySize = 2,   AddSize = 10, Bold = FW_NORMAL, Italico = 0, Sublinhado = 0, Riscado = 0, Charset = 160},
    {Index = 9 ,  Name = "Arial", MultiplySize = 1.3, AddSize = 0,  Bold = FW_NORMAL, Italico = 0, Sublinhado = 0, Riscado = 0, Charset = 160}, --CAMERA 3D
    
    {Index = 10 , Name = "Arial"      , MultiplySize = 1.3, AddSize = 0, Bold = FW_BOLD      , Italico = 0, Sublinhado = 0, Riscado = 0, Charset = 160},
    {Index = 11 , Name = "Arial"      , MultiplySize = 1  , AddSize = -2, Bold = FW_NORMAL, Italico = 0, Sublinhado = 0, Riscado = 0, Charset = 160},
    {Index = 12 , Name = "Arial", MultiplySize = 1  , AddSize = 0, Bold = FW_BOLD     , Italico = 0, Sublinhado = 0, Riscado = 0, Charset = 160},
    {Index = 13 , Name = "Bahnschrift", MultiplySize = 1  , AddSize = 0, Bold = FW_MEDIUM    , Italico = 0, Sublinhado = 0, Riscado = 0, Charset = 160},
    {Index = 14 , Name = "Bahnschrift", MultiplySize = 1  , AddSize = 0, Bold = FW_SEMIBOLD  , Italico = 0, Sublinhado = 0, Riscado = 0, Charset = 160},
    {Index = 15 , Name = "Bahnschrift", MultiplySize = 1  , AddSize = 0, Bold = FW_ULTRABOLD , Italico = 0, Sublinhado = 0, Riscado = 0, Charset = 160},
    {Index = 16 , Name = "Bahnschrift", MultiplySize = 1  , AddSize = 0, Bold = FW_HEAVY     , Italico = 0, Sublinhado = 0, Riscado = 0, Charset = 160},
}

for i in ipairs(Fonts) do
    SetFont(Fonts[i].Index, Fonts[i].Bold, Fonts[i].AddSize, Fonts[i].Charset, Fonts[i].Name, Fonts[i].MultiplySize, Fonts[i].Italico, Fonts[i].Sublinhado, Fonts[i].Riscado)
end