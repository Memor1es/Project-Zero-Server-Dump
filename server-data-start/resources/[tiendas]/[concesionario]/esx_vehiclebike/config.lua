Config                            = {}
Config.DrawDistance               = 100
Config.MarkerColor                = {r = 120, g = 120, b = 240}
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.ResellPercentage           = 50

Config.Locale                     = 'es'

Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 4
Config.PlateUseSpace = true

Config.Zones = {

	ShopEntering = {
		Pos   = vector3(288.41, -1154.60, 28.25),
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = 27
	},

	ShopInside = {
		Pos     = vector3(294.45, -1153.69, 28.76),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 358.69,
		Type    = -1
	},

	ShopOutside = {
		Pos     = vector3(262.09, -1158.05, 28.76),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 92.31,
		Type    = -1
	},

	BossActions = {
		Pos   = vector3(-32.0, -1114.2, 25.4),
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = -1
	},

	GiveBackVehicle = {
		Pos   = vector3(-18.2, -1078.5, 25.6),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = (Config.EnablePlayerManagement and 1 or -1)
	},

}
