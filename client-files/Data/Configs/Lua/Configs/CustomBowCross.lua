OpenFolder("Definitions")

CUSTOM_BOW_CROSS = {
	{ ItemIndex = GET_ITEM(4, 30), Type = 1, Skill = 320 },
	{ ItemIndex = GET_ITEM(4, 31), Type = 2, Skill = 293 },
}

function StartLoadBowCross()
	for i = 1, #CUSTOM_BOW_CROSS do
		SetBowCross(CUSTOM_BOW_CROSS[i].ItemIndex, CUSTOM_BOW_CROSS[i].Type, CUSTOM_BOW_CROSS[i].Skill)
	end
end
