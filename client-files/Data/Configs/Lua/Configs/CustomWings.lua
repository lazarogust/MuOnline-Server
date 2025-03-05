OpenFolder("Definitions")

function StartLoadWings()
	LoadWing(GET_ITEM(12, 144), 70, 145, 2, 65, 2, 80, 4, 86, 2, 83, 4, 101, 42, 102, 43, 103, 44, 98, 45, 0, 0,
		"wingwar")
	LoadWing(GET_ITEM(12, 145), 70, 145, 2, 65, 2, 80, 4, 86, 2, 83, 4, 101, 50, 102, 50, 103, 50, 98, 50, 1, 4,
		"wing180")
	LoadWing(GET_ITEM(12, 200), 70, 145, 2, 65, 2, 80, 4, 86, 2, 83, 4, 101, 42, 102, 43, 103, 44, 98, 45, 0, 0,
		"wingwar")

	--[[ Referencias para 5.2	
	Add de Life: 80, 81, 82, 84, 86
	Add de ExcOpt: 98, 101, 102, 103, 104, 106, 107, 108, 144, 148, 150	
	]] --
end
