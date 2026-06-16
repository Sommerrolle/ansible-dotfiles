# Hyprland Lua Config (`hl` API) — Dispatcher Notes

Quelle: `src/config/lua/bindings/LuaBindingsDispatchers.cpp` (hyprwm/Hyprland main branch),
ergänzt durch `hl.meta.lua` (Type-Stub, `/usr/share/hypr/stubs/hl.meta.lua`) und
`example_hyprland.lua` (Referenz-Config, `/usr/share/hypr/hyprland.lua`).

Installierte Version (lokal): Hyprland 0.55.x

## WICHTIG: `hyprctl dispatch <x>` ist KEIN klassischer Dispatcher mehr!

In dieser Lua-fähigen Hyprland-Version wird `hyprctl dispatch <x>` als
**Lua-Ausdruck** ausgewertet (`return hl.dispatch(<x>)`), nicht als klassischer
Dispatcher-String wie früher (`hyprctl dispatch movefocus l`).

Das heißt:
- `hyprctl dispatch fullscreen` → Fehler: `hl.dispatch: expected a dispatcher`
  (weil `fullscreen` als undefinierte Lua-Variable interpretiert wird)
- `hyprctl dispatch "hl.dsp.window.close()"` → funktioniert (gültiger Lua-Ausdruck)

**Folge:** Ein eigener Helper wie
```lua
local function dispatch(action)
    return hl.dsp.exec_cmd("hyprctl dispatch " .. action)
end
```
ist für klassische Dispatcher-Strings (`movefocus l`, `fullscreen 1`, ...) **kaputt**.
Stattdessen immer die echten `hl.dsp.*`-Funktionen unten verwenden.

## Bekannte `hl.dsp.*` Funktionen & Argumente

### `hl.dsp.focus({...})`
Genau eines der folgenden Felder:
- `direction = "left"|"right"|"up"|"down"`
- `monitor = <monitor selector>`
- `workspace = <workspace selector>` (+ optional `on_current_monitor = bool`)
  - Selector-Strings wie `"e+1"`, `"e-1"`, `"m+1"`, `"m-1"`, Zahl, Name
- `window = <window selector>`
- `urgent_or_last = true`
- `last = true`

### `hl.dsp.window.move({...})`
Genau eines der folgenden:
- `direction = "left"|"right"|"up"|"down"` (+ optional `group_aware = bool`)
- `x = n, y = n` (+ optional `relative = bool`)
- `workspace = <selector>` (+ optional `follow = bool`)
  - `follow = false` entspricht altem `movetoworkspacesilent`
- `monitor = <selector>` (+ optional `follow = bool`)
- `into_group = "left"|"right"|...`
- `into_or_create_group = "left"|"right"|...`
- `out_of_group = true | "left"|"right"|...`

### `hl.dsp.window.swap({...})`
- `direction = "left"|"right"|"up"|"down"`
- ODER `target` / `with` / `other = <window selector>`
- ODER `next = true` / `prev = true`

### `hl.dsp.window.resize({...})`
Ohne Argumente, oder:
- `x = n, y = n` (+ optional `relative = bool`, `relative=true` ≈ altes `resizeactive`)
- `keep_aspect_ratio = bool`

### `hl.dsp.window.fullscreen({...})` (optional)
- `mode = "fullscreen" | "0" | "maximized" | "1"` (Default: `"fullscreen"`)
- `action = "toggle" | "set" | "unset"` (Default: `"toggle"`)

Bekannter Bug (0.55): `mode = "maximized"` togglet nicht immer korrekt zurück
(siehe GitHub Discussion #14494, #14646).

### `hl.dsp.window.fullscreen_state({...})`
Pflichtfelder:
- `internal = n`, `client = n`
- optional `action = "toggle"|"set"|"unset"` (Default `"set"`)
- optional `window = <selector>`

### `hl.dsp.window.cycle_next({...})` (optional)
- `next = bool` (Default `true`)
- `tiled = bool`
- `floating = bool`

### `hl.dsp.window.alter_zorder({...})`
- `mode = <string>` (Pflicht)
- optional `window = <selector>`

### `hl.dsp.window.float({...})`
- `action = "toggle" | "set" | "unset"` (analog zu `togglefloating`)

### `hl.dsp.window.pseudo()`
Kein Argument nötig (toggelt Pseudo-Tiling).

### `hl.dsp.layout(<string>)`
String = klassische `layoutmsg`-Nachricht, z.B.:
- `"togglesplit"`, `"addmaster"`, `"removemaster"`, `"swapwithmaster"`,
  `"splitratio 0.3"`

### `hl.dsp.group.toggle()` / `.next()` / `.prev()`
Kein Argument. `next`/`prev` cyclen die aktive Gruppen-Tab automatisch.

### `hl.dsp.group.active({...})`
Pflicht: `index = n`, optional `window = <selector>`

### `hl.dsp.group.move_window({...})` (optional)
- `forward = bool` (Default `true`)

### `hl.dsp.group.lock(...)` / `.lock_active(...)`
(noch nicht im Detail dokumentiert)

### `hl.dsp.workspace.move({...})`
Pflicht: `monitor = <monitor selector>` (Name/ID/+1/-1 — **KEIN** `l/r/u/d`!)
optional: `workspace = <workspace selector>`

⚠️ Anders als der alte `movecurrentworkspacetomonitor`-Dispatcher, der
Richtungs-Strings (`l`/`r`/`u`/`d`) akzeptierte, nutzt `requireTableFieldMonitorSelector`
nur Monitor-Namen/IDs/relative `+1`/`-1`. Richtung wird (Stand jetzt) nicht unterstützt.

### `hl.dsp.workspace.toggle_special(<name?>)`
- Ohne Argument → toggelt die unbenannte Standard-Sondersworkspace (`special`)
- Mit String → toggelt `special:<name>` (z.B. `"magic"` → `special:magic`)

### `hl.dsp.workspace.rename(...)`, `.swap_monitors(...)`
(noch nicht im Detail dokumentiert)

### `hl.dsp.exit()`
Kein Argument (entspricht `exit` / `exit 0`).

### `hl.dsp.send_shortcut({...})`
Pflicht: `mods = <string>`, `key = <string>`, optional `window = <selector>`

### Sonstige (Top-Level `hl.dsp.*`)
`dpms`, `event`, `exec_cmd`, `exec_raw`, `force_idle`, `force_renderer_reload`,
`global`, `no_op`, `pass`, `send_key_state`, `submap`

`hl.dsp.cursor.move(...)`, `hl.dsp.cursor.move_to_corner(...)`

## Window Rules (`hl.window_rule({...})`)

```lua
hl.window_rule({
    name  = "...",
    match = {
        class      = "^regex$",
        title      = "^regex$",
        xwayland   = true|false,
        float      = true|false,
        fullscreen = true|false,
        pin        = true|false,
    },

    -- Effekte (Auswahl, siehe WINDOW_RULE_EFFECT_* in LuaBindingsInternal.hpp):
    float             = true,
    center            = true,
    no_focus          = true,
    suppress_event    = "maximize" | ...,
    move              = "<x> <y>",
    size              = "<w> <h>",
    monitor           = "...",
    workspace         = "...",
    rounding          = n,
    border_size       = n,
    opacity           = "...",
    no_blur           = true,
    no_shadow         = true,
    -- ... viele weitere, siehe LuaBindingsInternal.hpp WINDOW_RULE_EFFECT_DESCS
})
```

## Quellen
- https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.lua (lokal: `example_hyprland.lua`)
- https://github.com/hyprwm/Hyprland/blob/main/src/config/lua/bindings/LuaBindingsDispatchers.cpp
- `/usr/share/hypr/stubs/hl.meta.lua` (lokal: `hl.meta.lua`) — Type-Stubs für LSP/Autocomplete
- /usr/include/hyprland/src/config/lua/bindings/LuaBindingsInternal.hpp (WINDOW_RULE_EFFECT_DESCS)
- GitHub Discussions #14494, #14646 (Fullscreen-Bugs in 0.55)
