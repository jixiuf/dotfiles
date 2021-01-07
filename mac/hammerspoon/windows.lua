require('hyper')
--------------------------------------------------------------------------------
-- Define WindowLayout Mode
--
-- WindowLayout Mode allows you to manage window layout using keyboard shortcuts
-- that are on the home row, or very close to it. Use Control+s to turn
-- on WindowLayout mode. Then, use any shortcut below to perform a window layout
-- action. For example, to send the window left, press and release
-- Control+s, and then press h.
--
--   h/j/k/l => send window to the left/bottom/top/right half of the screen
--   i => send window to the upper left quarter of the screen
--   o => send window to the upper right quarter of the screen
--   , => send window to the lower left quarter of the screen
--   . => send window to the lower right quarter of the screen
--   return => make window full screen
--   n => send window to the next monitor
--------------------------------------------------------------------------------

windowLayoutMode = hs.hotkey.modal.new({}, 'F15')
local message = require('status-message')
windowLayoutMode.statusMessage = message.new('Window Layout Mode (control-`) (hjkl) (m full)(io,.) (hyper2-u,hyper2-m + or -)')
windowLayoutMode.entered = function()
  windowLayoutMode.statusMessage:show()
end
windowLayoutMode.exited = function()
  windowLayoutMode.statusMessage:hide()
end

-- Bind the given key to call the given function and exit WindowLayout mode
function windowLayoutMode.bindWithAutomaticExit(mode,mod, key, fn)
  mode:bind(mod, key, function()
    mode:exit()
    fn()
  end)
end

windowLayoutMode:bindWithAutomaticExit({},'return', function()
  hs.window.focusedWindow():maximize()
end)
windowLayoutMode:bindWithAutomaticExit({},'f', function()
  hs.window.focusedWindow():maximize()
end)
windowLayoutMode:bindWithAutomaticExit({},'m', function()
  hs.window.focusedWindow():maximize()
end)

windowLayoutMode:bindWithAutomaticExit({},'space', function()
  hs.window.focusedWindow():centerWithFullHeight()
end)

windowLayoutMode:bindWithAutomaticExit({},'h', function()
  hs.window.focusedWindow():left()
end)

windowLayoutMode:bindWithAutomaticExit({},'j', function()
  hs.window.focusedWindow():down()
end)

windowLayoutMode:bindWithAutomaticExit({},'k', function()
  hs.window.focusedWindow():up()
end)

windowLayoutMode:bindWithAutomaticExit({},'l', function()
  hs.window.focusedWindow():right()
end)
windowLayoutMode:bindWithAutomaticExit(hyper2,'h', function()
  hs.window.focusedWindow():moveLeft()
end)
windowLayoutMode:bindWithAutomaticExit(hyper2,'l', function()
  hs.window.focusedWindow():moveRight()
end)

windowLayoutMode:bindWithAutomaticExit(hyper2,'j', function()
  hs.window.focusedWindow():moveDown()
end)
windowLayoutMode:bindWithAutomaticExit(hyper2,'k', function()
  hs.window.focusedWindow():moveUp()
end)

windowLayoutMode:bindWithAutomaticExit({},'i', function()
  hs.window.focusedWindow():upLeft()
end)

windowLayoutMode:bindWithAutomaticExit({},'o', function()
  hs.window.focusedWindow():upRight()
end)

windowLayoutMode:bindWithAutomaticExit({},',', function()
  hs.window.focusedWindow():downLeft()
end)

windowLayoutMode:bindWithAutomaticExit({},'.', function()
  hs.window.focusedWindow():downRight()
end)
windowLayoutMode:bindWithAutomaticExit(hyper2,'u', function() winIncrease() end)

windowLayoutMode:bindWithAutomaticExit(hyper2,'m', function() winReduce() end)

windowLayoutMode:bindWithAutomaticExit({},'n', function()
  hs.window.focusedWindow():nextScreen()
end)

-- Use Control+s to toggle WindowLayout Mode
hs.hotkey.bind(hyper2, 's', function()
  windowLayoutMode:enter()
end)
windowLayoutMode:bind(hyper2, 's', function()
  windowLayoutMode:exit()
end)

-- hs.hotkey.bind({"cmd"}, "LEFT", function()
--    hs.window.focusedWindow():left()
-- end)
-- open -g hammerspoon://moveWinLeft
-- karabiner 绑定Fn+Left 键，因 hammerspoon 不支持Fn的绑定
hs.urlevent.bind("moveWinLeft", function(eventName, params) hs.window.focusedWindow():left() end)
hs.urlevent.bind("moveWinRight", function(eventName, params) hs.window.focusedWindow():right() end)
hs.urlevent.bind("moveWinUp", function(eventName, params) hs.window.focusedWindow():up() end)
hs.urlevent.bind("moveWinDown", function(eventName, params) hs.window.focusedWindow():down() end)
hs.urlevent.bind("winIncrease", function(eventName, params) winIncrease() end)
hs.urlevent.bind("winReduce", function(eventName, params) winReduce() end)
-- hs.hotkey.bind({"cmd","shift"}, "R", function() winReduce() end)


hs.window.animationDuration = 0

-- +-----------------+
-- |        |        |
-- |  HERE  |        |
-- |        |        |
-- +-----------------+
-- hs.window.focusedWindow():left()
function hs.window.left(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

-- +-----------------+
-- |        |        |
-- |        |  HERE  |
-- |        |        |
-- +-----------------+
function hs.window.right(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

-- +-----------------+
-- |      HERE       |
-- +-----------------+
-- |                 |
-- +-----------------+
function hs.window.up(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.w = max.w
  f.y = max.y
  f.h = max.h / 2
  win:setFrame(f)
end

-- +-----------------+
-- |                 |
-- +-----------------+
-- |      HERE       |
-- +-----------------+
function hs.window.down(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.w = max.w
  f.y = max.y + (max.h / 2)
  f.h = max.h / 2
  win:setFrame(f)
end

-- +-----------------+
-- |  HERE  |        |
-- +--------+        |
-- |                 |
-- +-----------------+
function hs.window.upLeft(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = 0
  f.y = 0
  f.w = max.w/2
  f.h = max.h/2
  win:setFrame(f)
end

-- +-----------------+
-- |                 |
-- +--------+        |
-- |  HERE  |        |
-- +-----------------+
function hs.window.downLeft(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = 0
  f.y = max.h/2
  f.w = max.w/2
  f.h = max.h/2
  win:setFrame(f)
end

-- +-----------------+
-- |                 |
-- |        +--------|
-- |        |  HERE  |
-- +-----------------+
function hs.window.downRight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.w/2
  f.y = max.h/2
  f.w = max.w/2
  f.h = max.h/2

  win:setFrame(f)
end

-- +-----------------+
-- |        |  HERE  |
-- |        +--------|
-- |                 |
-- +-----------------+
function hs.window.upRight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.w/2
  f.y = 0
  f.w = max.w/2
  f.h = max.h/2
  win:setFrame(f)
end

-- +--------------+
-- |  |        |  |
-- |  |  HERE  |  |
-- |  |        |  |
-- +---------------+
function hs.window.centerWithFullHeight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.w * 1/5
  f.w = max.w * 3/5
  f.y = max.y
  f.h = max.h
  win:setFrame(f)
end

function hs.window.moveLeft(win)
  local f = win:frame()

  f.x = f.x-80
  win:setFrame(f)
end
function hs.window.moveRight(win)
  local f = win:frame()

  f.x = f.x+80
  win:setFrame(f)
end
function hs.window.moveUp(win)
  local f = win:frame()

  f.y = f.y-60
  win:setFrame(f)
end
function hs.window.moveDown(win)
  local f = win:frame()

  f.y = f.y+60
  win:setFrame(f)
end
function hs.window.nextScreen(win)
  local currentScreen = win:screen()
  local allScreens = hs.screen.allScreens()
  currentScreenIndex = hs.fnutils.indexOf(allScreens, currentScreen)
  nextScreenIndex = currentScreenIndex + 1

  if allScreens[nextScreenIndex] then
    win:moveToScreen(allScreens[nextScreenIndex])
  else
    win:moveToScreen(allScreens[1])
  end
end

function winIncrease()
   local win = hs.window.focusedWindow()
   if win==nil then
      return
   end
   local curFrame = win:frame()
   local screen = win:screen()
   if screen==nil then
      return
   end
   local max = screen:frame()
   local inscW =120
   if (max.w-curFrame.w)==0 then
      win:setFrame(max)
      return
   end
   local inscH =inscW*(max.h-curFrame.h)/(max.w-curFrame.w)


   if max.w-curFrame.h<inscW and max.h-curFrame.h<inscW then
      win.setFrame(max)
   else
      curFrame.w=curFrame.w +inscW
      local a = (curFrame.x-max.x) -- 左边空白的宽度
      local b =((max.x+max.w)-(curFrame.w+curFrame.x)) -- 右边空白的宽度
      if b<0 then
         curFrame.w=max.w
         curFrame.x=max.x
         -- elseif b-a==0 then
         --    curFrame.x=max.x
      else
         -- a*(inscW-m)=b*m -->a*inscW-a*m=b*m
         if b+a==0 then
            return
         end
         local m =inscW*a/(b+a)                         -- 左边应变化的尺寸
         curFrame.x=curFrame.x-m                          -- 变化后左边的坐标
         if curFrame.x<max.x then
            curFrame.x=max.x
         end
      end

      curFrame.h=curFrame.h +inscH
      local a = (curFrame.y-max.y) -- 左边空白的宽度
      local b =((max.y+max.h)-(curFrame.h+curFrame.y)) -- 右边空白的宽度
      if b<0 then
         curFrame.h=max.h
         curFrame.y=max.y
         -- elseif b-a==0 then
         --    curFrame.y=max.y
      else
         -- a*(inscH-m)=b*m -->a*inscH-a*m=b*m
         if b+a==0 then
            win:setFrame(max)
            return
         end
         local m =inscH*a/(b+a)                         -- 左边应变化的尺寸
         curFrame.y=curFrame.y-m                          -- 变化后左边的坐标
         if curFrame.y<max.y then
            curFrame.y=max.y
         end
      end


      win:setFrame(curFrame)
   end
end

function winReduce()
   local win = hs.window.focusedWindow()
   if win==nil then
      return
   end
   local curFrame = win:frame()
   local screen = win:screen()
   if screen==nil then
      return
   end
   local max = screen:frame()
   local inscW =100
   if curFrame.w==0 then
      return
   end
   local inscH =inscW*(curFrame.h)/(curFrame.w)


   -- hs.alert.show(tostring((max.w-curFrame.w)))
   curFrame.w =curFrame.w-inscW
   curFrame.x =curFrame.x+inscW/2


   -- hs.alert.show(tostring((max.h-curFrame.h)))
   curFrame.h =curFrame.h-inscH
   curFrame.y =curFrame.y+inscH/2
   win:setFrame(curFrame)
end
