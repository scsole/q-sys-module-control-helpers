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
ControlHelpers.LinkTrigger(trigger1, trigger2)
ControlHelpers.LinkValue(knob1, knob2)
ControlHelpers.LinkString(textbox1, textbox2)
```
