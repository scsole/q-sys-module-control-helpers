local Module = {}

--- Link to controls so that the receiver is triggered whenever the sender is triggered.
--- @param sender table The control which will be subscribed to
--- @param receiver table The control which will be triggered by the sender
--- @param addToEventHandler boolean? When `true`, the link will not overwrite an existing EventHandler
function Module.LinkTrigger(sender, receiver, addToEventHandler)
  if addToEventHandler and sender.EventHandler then
    local originalEH = sender.EventHandler
    sender.EventHandler = function(self)
      originalEH(self)
      receiver:Trigger()
    end
  else
    sender.EventHandler = function()
      receiver:Trigger()
    end
  end
end

--- Bind the value of a receiver control to the value of a sender. This will initialize to the value of the receiver.
--- @param sender table The control which will be subscribed to
--- @param receiver table The control which will be set by the value of the sender
--- @param addToEventHandler boolean? When `true`, the link will not overwrite an existing EventHandler
function Module.LinkValue(sender, receiver, addToEventHandler)
  if addToEventHandler and sender.EventHandler then
    local originalEH = sender.EventHandler
    sender.EventHandler = function(self)
      originalEH(self)
      receiver.Value = self.Value
    end
  else
    sender.EventHandler = function(self)
      receiver.Value = self.Value
    end
  end
  receiver.Value = sender.Value
end

--- Bind to controls together by value. This will initialize both controls to the value of `ctrl1`.
--- @param ctrl1 table The first control
--- @param ctrl2 table The second control
--- @param addToEventHandlers boolean? When `true`, the link will not overwrite any existing EventHandlers
function Module.BidirectionalLinkValue(ctrl1, ctrl2, addToEventHandlers)
  Module.LinkValue(ctrl1, ctrl2, addToEventHandlers)
  Module.LinkValue(ctrl2, ctrl1, addToEventHandlers)
end

--- Bind the string of a receiver control to the string of a sender. This will initialize to the string of the receiver.
--- @param sender table The control which will be subscribed to
--- @param receiver table The control which will be set by the string of the sender
--- @param addToEventHandler boolean? When `true`, the link will not overwrite an existing EventHandler
function Module.LinkString(sender, receiver, addToEventHandler)
  if addToEventHandler and sender.EventHandler then
    local originalEH = sender.EventHandler
    sender.EventHandler = function(self)
      originalEH(self)
      receiver.String = self.String
    end
  else
    sender.EventHandler = function(self)
      receiver.String = self.String
    end
  end
  receiver.String = sender.String
end

--- Bind to controls together by string. This will initialize both controls to the string of `ctrl1`.
--- @param ctrl1 table The first control
--- @param ctrl2 table The second control
--- @param addToEventHandlers boolean? When `true`, the link will not overwrite any existing EventHandlers
function Module.BidirectionalLinkString(ctrl1, ctrl2, addToEventHandlers)
  Module.LinkString(ctrl1, ctrl2, addToEventHandlers)
  Module.LinkString(ctrl2, ctrl1, addToEventHandlers)
end

--- Bind the legend of a receiver control to the string of a sender. This will initialize the legend of the receiver.
--- Escaped characters (e.g. `\n`) are supported.
--- @param sender table The control which will be subscribed to
--- @param receiver table The control who's legend will be set by the string of the sender
--- @param addToEventHandler boolean? When `true`, the link will not overwrite an existing EventHandler
function Module.LinkStringToLegend(sender, receiver, addToEventHandler)
  if addToEventHandler and sender.EventHandler then
    local originalEH = sender.EventHandler
    sender.EventHandler = function(self)
      originalEH(self)
      receiver.Legend = load("return \"" .. self.String .. "\"")()
    end
  else
    sender.EventHandler = function(self)
      receiver.Legend = load("return \"" .. self.String .. "\"")()
    end
  end
  receiver.Legend = load("return \"" .. sender.String .. "\"")()
end

--- Link controls from a PIN Pad component to all matching prefixed controls.
--- @param pinPadComponent table The PIN Pad component. This must be a valid component.
--- @param controlPrefix string The prefix used on all associated PIN Pad controls accessible from this script.
--- @param addToEventHandlers boolean? When `true`, the links will not override any existing EventHandlers
function Module.LinkPinPad(pinPadComponent, controlPrefix, addToEventHandlers)
  local triggerKeys = {
    "backspace",
    "clear",
    "enter",
    "logout",
    "pinpad.0",
    "pinpad.1",
    "pinpad.2",
    "pinpad.3",
    "pinpad.4",
    "pinpad.5",
    "pinpad.6",
    "pinpad.7",
    "pinpad.8",
    "pinpad.9",
    "pin.matched",
    "pin.mismatched",
  }
  local stringKeys = {
    "pin",
    "pin.0",
  }
  local valueKeys = {
    "pin.match.0",
  }

  for _, key in ipairs(triggerKeys) do
    local ctrl = Controls[controlPrefix .. key]
    if ctrl then
      Module.LinkTrigger(ctrl, pinPadComponent[key], addToEventHandlers)
    end
  end

  for _, key in ipairs(stringKeys) do
    local ctrl = Controls[controlPrefix .. key]
    if ctrl then
      Module.LinkString(pinPadComponent[key], ctrl, addToEventHandlers)
    end
  end

  for _, key in ipairs(valueKeys) do
    local ctrl = Controls[controlPrefix .. key]
    if ctrl then
      Module.LinkValue(pinPadComponent[key], ctrl, addToEventHandlers)
    end
  end
end

return Module
