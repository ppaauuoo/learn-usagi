local function _is_hover(Obj, offset)
  x,y = input.mouse()
  if x >= Obj.x-offset and x <= Obj.x+Obj.w+offset and
    y >= Obj.y-offset and y <= Obj.y+Obj.h+offset then
    return true
  end
  return false
end

update_holding = function(Obj)
  if input.mouse_held(input.MOUSE_LEFT) and _is_hover(Obj, 10) then
    State.holding = true
  else
    State.holding = false
  end
end

shake_when_hold = function(intensity, velocity, aftereffect)
  if State.holding then
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

hold_can_drag = function(Obj)
  x,y = input.mouse()
  if State.holding then
    Obj.x = x-Obj.w/2
    Obj.y = y-5
  end
  if State.held_time >= 0 then
    print('hello')
end

drag_and_snap = function(Obj, Area, delta)
  if util.rect_overlap(Obj, Area) then
    Obj.x = util.approach(Obj.x, Area.x+8, delta*360)
    Obj.y = util.approach(Obj.y, Area.y+4, delta*360)
  end
end
