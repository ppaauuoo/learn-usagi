
require("objectcontroller")

function _config()
  return { name = "test", game_id = "com.usagiengine.test" }
end


function _init()
  -- Live reload preserves globals across saved edits but resets locals.
  -- Stash mutable game state in a capitalized global like `State` so it
  -- survives reloads; F5 calls _init again to reset.
  text = "Hold"
  w, h = usagi.measure_text(text)
  State = {held_time=0, holding=false}
  Box = {text=text, x=10,y=10,w=w+10,h=h+5}
  Area = {x=40, y=40, w=Box.w*1.5, h=Box.h*1.5}
end

function _update(dt)
  update_holding(Box)
  shake_when_hold(2,0.01,0.1)
  hold_can_drag(Box)
end

function text_box(Box, color)
  gfx.rect(Box.x, Box.y, Box.w, Box.h, color)
  if Box.text then
    gfx.text(Box.text, Box.x+5, Box.y, color)
  end
end

function _draw(dt)
  gfx.clear(gfx.COLOR_BLACK)
  text_box(Box, gfx.COLOR_WHITE)
  text_box(Area, gfx.COLOR_WHITE)
end
