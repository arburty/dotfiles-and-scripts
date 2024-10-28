local running = false
local clp_show = false
local timer

function show_current_speed()
    running = not running
    if running then
        timer = mp.add_periodic_timer(1, function()
            local currentspeed = mp.get_property("speed")
            mp.osd_message("Speed: "..("%.2f"):format(math.floor(currentspeed * 1000) / 1000), 1)
        end)
    else
        timer:stop()
    end
end

--[[ function set_msg_osd_props() ]]
--[[   local osd_font_size = mp.get_property("osd-font-size") ]]
--[[   local osd_duration = get_property("osd-duration") ]]
--[[   local osd_font = mp.get_property("osd-font") ]]
--[[   mp.set_property("osd-font-size", 24) ]]
--[[   mp.set_property("osd-duration", 10000) ]]
--[[   mp.set_property("osd-font", "Liberation Mono") ]]
--[[ end ]]

function timer_clipped()
    running = not running
    local clipped = get_clipped_data()
    mp.set_property("osd-font-size", 20)
    mp.set_property("osd-font", "Liberation Mono")
    if running then
        timer = mp.add_periodic_timer(1, function()
            local currentpos = mp.get_property("percent-pos")
            local msg = clipped .. "\n" .. "pct-pos: "..("%.2f"):format(math.floor(currentpos * 1000) / 1000), 1
            mp.osd_message(msg)
        end)
    else
        timer:stop()
    end
end

function show_clipped()
    local data = get_clipped_data()
    data = data .."\n" .. mp.get_property("percent-pos")
    mp.set_property("osd-font-size", 20)
    mp.set_property("osd-duration", 10000)
    mp.set_property("osd-font", "Liberation Mono")
    mp.osd_message(data)
end

function get_clipped_data()
  local handle = io.popen('/home/vladislav/SD2T/Backup/shared/laptop-backup/.sysctl/bin/clipped "' .. mp.get_property("filename") .. '"')
  local output = handle:read('*a')
  local time = output:gsub('[\r]', '\n')
  handle:close()
  print(time .. 'DEBUG: Time recorded when this event happened.' .. '---'..mp.get_property("filename"))
  return time
end


--[[ mp.add_key_binding("ctrl+z", "show_current_speed", show_current_speed) ]]

--[[ mp.add_key_binding("ctrl+z", "show_clipped", show_clipped) ]]
mp.add_key_binding("ctrl+z", "timer_clipped", timer_clipped)
