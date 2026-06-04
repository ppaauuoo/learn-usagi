function _config()
  return { name = "test", game_id = "com.usagiengine.YOURGAMENAME" }
end

function _init()
  -- Live reload preserves globals across saved edits but resets locals.
  -- Stash mutable game state in a capitalized global like `State` so it
  -- survives reloads; F5 calls _init again to reset.
  State = {held_time=0}
  Box = {x=10,y=10,w=90,h=15}
end

function hover_box(x, y)
  if x >= Box.x and x <= Box.x+Box.w and
    y >= Box.y and y <= Box.y+Box.h then
    return true
  end
  return false
end

function hold_shake(intensity, velocity, aftereffect)
  x,y = input.mouse()
  if input.mouse_held(input.MOUSE_LEFT) and hover_box(x,y) then
    if State.held_time <= intensity then
      State.held_time += velocity
    end
    effect.screen_shake(0.3,State.held_time)
  else
    if State.held_time and State.held_time > 0 then
      State.held_time -= aftereffect
    end
    effect.screen_shake(0.3,State.held_time)
  end
end

function _update(dt)
  hold_shake(2,0.01,0.1)
end

function _draw(dt)
  gfx.clear(gfx.COLOR_BLACK)
  gfx.rect(Box.x, Box.y, Box.w, Box.h, gfx.COLOR_WHITE)
  gfx.text("Hold this", 15, 10, gfx.COLOR_WHITE)
end
