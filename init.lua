local Module = {}

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
  LinkValue(ctrl1, ctrl2, addToEventHandlers)
  LinkValue(ctrl2, ctrl1, addToEventHandlers)
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

return Module
