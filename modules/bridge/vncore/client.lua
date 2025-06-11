
local VNCore = setmetatable({}, {
	__index = function(self, index)
		local obj = exports["vn-core"]:GetCore()
		self.SetPlayerData = obj.SetPlayerData
		self.PlayerLoaded = obj.PlayerLoaded
		return self[index]
	end
})

---@diagnostic disable-next-line: duplicate-set-field
function client.setPlayerData(key, value)
	PlayerData[key] = value
	VNCore.SetPlayerData(key, value)
end

---@diagnostic disable-next-line: duplicate-set-field
function client.setPlayerStatus(values)
	for name, value in pairs(values) do
		if value > 0 then TriggerEvent('vnc_status:add', name, value) else TriggerEvent('vnc_status:remove', name, -value) end
	end
end

RegisterNetEvent('vncore:logout', client.onLogout)

AddEventHandler('vncore:setPlayerData', function(key, value)
	if not PlayerData.loaded or GetInvokingResource() ~= 'vn-core' then return end

	if key == 'job' then
		key = 'groups'
		value = { [value.name] = value.grade }
	end

	PlayerData[key] = value
	OnPlayerData(key, value)
end)

local Weapon = require 'modules.weapon.client'

-- chưa hỗ trợ handcuff
--[[ RegisterNetEvent('esx_policejob:handcuff', function()
	PlayerData.cuffed = not PlayerData.cuffed
	LocalPlayer.state:set('invBusy', PlayerData.cuffed, true)

	if not PlayerData.cuffed then return end

	Weapon.Disarm()
end)

RegisterNetEvent('esx_policejob:unrestrain', function()
	PlayerData.cuffed = false
	LocalPlayer.state:set('invBusy', PlayerData.cuffed, true)
end)
 ]]