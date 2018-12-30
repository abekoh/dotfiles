local module = {}

-- 設定リロード
hs.hotkey.bind({"ctrl", "shift"}, "R", function()
  hs.reload()
end)


-- 右コマンドでアプリ切り替え
local rightCommandKeyCode = 54
local rightCommandFlag    = 16
local releasedFlag        = 256
local keyAppMap = {
    ["c"] = "Google Chrome",
    ["f"] = "Finder",
    ["i"] = "IntelliJ IDEA CE",
    ["p"] = "iTunes",
    ["t"] = "iTerm",
    ["s"] = "Slack",
    ["o"] = "Spotify"
}
local asciiAppMap = {
    ["49"] = "1Password 7"
}

local rightCommandHandler = function(e)
  local keyAscii = string.byte(e:getCharacters(true))
  local app
  if keyAscii >= 97 and keyAscii <= 122 then
      app = keyAppMap[e:getCharacters(true)]
  else
      app = asciiAppMap[tostring(keyAscii)]
  end
  if app then
    local isDown = e:getType() == hs.eventtap.event.types.keyDown
    if isDown then
        hs.application.launchOrFocus(app)
    end
    return true, { nil }
  end
end

module.modifierListener = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
  if event:getKeyCode() == rightCommandKeyCode then
    local eventData = event:getRawEventData().NSEventData
if (eventData.modifierFlags & rightCommandFlag) == rightCommandFlag then
      module.keyListener = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, rightCommandHandler):start()
    elseif module.keyListener and (eventData.modifierFlags & releasedFlag) == releasedFlag then
      module.keyListener:stop()
      module.keyListener = nil
    end
  end
end):start()

-- USでもかな英数
local prevKeyCode
local escape = 0x35
local leftCommand = 0x37
local rightCommand = 0x36
local eisuu = 0x66
local kana = 0x68

module.eisuukana = hs.eventtap.new({hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, function(e)
    local keyCode = e:getKeyCode()
    if keyCode == escape then
        hs.eventtap.keyStroke({}, eisuu)
    end
    local isCmdKeyUp = not(e:getFlags()['cmd']) and e:getType() == hs.eventtap.event.types.flagsChanged
    if isCmdKeyUp and prevKeyCode == leftCommand then
        hs.eventtap.keyStroke({}, eisuu)
    elseif isCmdKeyUp and prevKeyCode == rightCommand then
        hs.eventtap.keyStroke({}, kana)
    end
    prevKeyCode = keyCode
end):start()

-- どこでもvim
local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

remapKey({'ctrl'}, 'h', keyCode('left'))
remapKey({'ctrl'}, 'j', keyCode('down'))
remapKey({'ctrl'}, 'k', keyCode('up'))
remapKey({'ctrl'}, 'l', keyCode('right'))

remapKey({'ctrl', 'shift'}, 'h', keyCode('left', {'shift'}))
remapKey({'ctrl', 'shift'}, 'j', keyCode('down', {'shift'}))
remapKey({'ctrl', 'shift'}, 'k', keyCode('up', {'shift'}))
remapKey({'ctrl', 'shift'}, 'l', keyCode('right', {'shift'}))

remapKey({'ctrl', 'cmd'}, 'h', keyCode('left', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'j', keyCode('down', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'k', keyCode('up', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'l', keyCode('right', {'cmd'}))

remapKey({'ctrl', 'shift', 'cmd'}, 'h', keyCode('left', {'shift', 'cmd'}))
remapKey({'ctrl', 'shift', 'cmd'}, 'j', keyCode('down', {'shift', 'cmd'}))
remapKey({'ctrl', 'shift', 'cmd'}, 'k', keyCode('up', {'shift', 'cmd'}))
remapKey({'ctrl', 'shift', 'cmd'}, 'l', keyCode('right', {'shift', 'cmd'}))

remapKey({'ctrl', 'alt'}, 'h', keyCode('left', {'alt'}))
remapKey({'ctrl', 'alt'}, 'j', keyCode('down', {'alt'}))
remapKey({'ctrl', 'alt'}, 'k', keyCode('up', {'alt'}))
remapKey({'ctrl', 'alt'}, 'l', keyCode('right', {'alt'}))

remapKey({'ctrl', 'shift', 'alt'}, 'h', keyCode('left', {'shift', 'alt'}))
remapKey({'ctrl', 'shift', 'alt'}, 'j', keyCode('down', {'shift', 'alt'}))
remapKey({'ctrl', 'shift', 'alt'}, 'k', keyCode('up', {'shift', 'alt'}))
remapKey({'ctrl', 'shift', 'alt'}, 'l', keyCode('right', {'shift', 'alt'}))

remapKey({'ctrl', 'cmd', 'alt'}, 'h', keyCode('left', {'cmd', 'alt'}))
remapKey({'ctrl', 'cmd', 'alt'}, 'j', keyCode('down', {'cmd', 'alt'}))
remapKey({'ctrl', 'cmd', 'alt'}, 'k', keyCode('up', {'cmd', 'alt'}))
remapKey({'ctrl', 'cmd', 'alt'}, 'l', keyCode('right', {'cmd', 'alt'}))

hs.alert.show("Hammerspoon config is loaded")
