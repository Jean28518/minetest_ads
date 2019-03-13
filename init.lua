-- If you dont want the pink color, comment Line 2 And uncomment Line 3:
violett = minetest.get_color_escape_sequence("#9022A7")
-- violett = minetest.get_color_escape_sequence("#FFFFFF")
-- If you want only use one language, then use the second language (ads_table_2) This is the default one
local FIRST_LANGAUGE = "de"
local SECOND_LANGUAGE = "en"
local INTERVAL = 900 -- In Seconds
-- Here you can define your ads. Of course you can define more as three messages. Just duplicat the second line ;)
local ads_table_1 = {"Erste Werbeanzeige!",
  "Zweite Werbeanzeige!",
  "Dritte Werbeanzeige!"}

local ads_table_2 = {"Your first ad",
  "Your second ad!",
  "Your third ad!"}
local counter = 0
local delta = 0
-- define language command Command
minetest.register_chatcommand("ads_language", {
    func = function(name, param)
      local player = minetest.get_player_by_name(name)
      local meta = player:get_meta()
      -- Change here the languages of the messages!
      if param == FIRST_LANGAUGE then
        meta:set_string("ads_language", param)
        minetest.chat_send_player(name, "Sprache wurde erfolgreich gesetzt. Nicht alle Inhalte sind aber leider in deutsch!")
      elseif param == SECOND_LANGUAGE then
        meta:set_string("ads_language", param)
        minetest.chat_send_player(name, "Language successfully defined")
      else
        -- Here you can change the "not found" message:
        minetest.chat_send_player(name, "Language not found! Available Languages: de, en")
      end
    end
})

minetest.register_globalstep(function(dtime)
  if delta > INTERVAL then
    counter = counter + 1
    if counter > tablelength(ads_table_2) then
      counter = 1
    end
    -- minetest.chat_send_player("LinuxGuides", counter)
    for _, player in pairs(minetest.get_connected_players()) do
      pmeta = player:get_meta()
      if pmeta:get_string("ads_language") == FIRST_LANGAUGE then
        minetest.chat_send_player(player:get_player_name(), violett .. ads_table_1[counter])
      else
        minetest.chat_send_player(player:get_player_name(), violett .. ads_table_2[counter])
      end
    end
    delta = 0
  else
    delta = delta + dtime
  end
end)

-- Helper:
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
