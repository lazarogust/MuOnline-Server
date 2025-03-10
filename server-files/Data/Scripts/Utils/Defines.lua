--[[
Global defines
--]]

function GET_ITEM(x, y)
	return (x * 512) + y
end

function OBJECT_RANGE(x)
	if x < 0
	then
		return 0
	end

	if x > MAX_OBJECT
	then
		return 0
	end

	return 1
end

OBJECT_START_USER = 9000
MAX_OBJECT = 9999
OBJECT_START_MONSTER = 0
MAX_OBJECT_MONSTER = 7999

CLASS_DW = 0
CLASS_DK = 1
CLASS_FE = 2
CLASS_MG = 3
CLASS_DL = 4
CLASS_SU = 5
CLASS_RF = 6

DB_CLASS_DW = 0
DB_CLASS_SM = 1
DB_CLASS_GM = 2
DB_CLASS_DK = 16
DB_CLASS_BK = 17
DB_CLASS_BM = 18
DB_CLASS_FE = 32
DB_CLASS_ME = 33
DB_CLASS_HE = 34
DB_CLASS_MG = 48
DB_CLASS_DM = 50
DB_CLASS_DL = 64
DB_CLASS_LE = 66
DB_CLASS_SU = 80
DB_CLASS_BS = 81
DB_CLASS_DS = 82
DB_CLASS_RF = 96
DB_CLASS_FM = 98