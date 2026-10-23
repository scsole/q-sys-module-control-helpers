# Q-Sys Control Helpers Module

Useful functions for linking controls in Q-Sys scripts.

[![Luacheck](https://github.com/scsole/q-sys-module-control-helpers/actions/workflows/luacheck.yml/badge.svg)](https://github.com/scsole/q-sys-module-control-helpers/actions/workflows/luacheck.yml)

## Quick start

1. Clone or download this repository to the Modules directory
2. Add the module to the project using Design Resources
3. Use the module

## Usage

See init.lua for all and functions and their descriptions.

```lua
local ControlHelpers = require('control-helpers')

-- Trigger the receiver whenever the sender is triggered
ControlHelpers.LinkTrigger(trigger1, trigger2)

-- Link two state triggers, tracking the state of the primary (second argument)
ControlHelpers.LinkStateTrigger(stateTrigger1, stateTrigger2)

-- Bind the receiver's value to the sender's value
ControlHelpers.LinkValue(knob1, knob2)

-- Bind two controls together by value
ControlHelpers.BidirectionalLinkValue(knob1, knob2)

-- Bind the receiver's boolean to the sender's boolean
ControlHelpers.LinkBoolean(button1, led1)

-- Bind two controls together by boolean
ControlHelpers.BidirectionalLinkBoolean(button1, button2)

-- Bind the receiver's string to the sender's string
ControlHelpers.LinkString(textbox1, textbox2)

-- Bind two controls together by string
ControlHelpers.BidirectionalLinkString(textbox1, textbox2)

-- Bind the receiver's legend to the sender's string (escaped characters such as \n are supported)
ControlHelpers.LinkStringToLegend(textbox1, button1)

-- Link a PIN Pad component to all controls starting with the given prefix
ControlHelpers.LinkPinPad(Component.New('PIN Pad'), 'pinpad_')

-- Every function except LinkPinPad accepts an optional final argument. Pass `true` to keep
-- any existing EventHandler instead of overwriting it
ControlHelpers.LinkValue(knob1, knob2, true)
```
