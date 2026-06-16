-- Hyprland Lua Config
-- https://wiki.hyprland.org/

local HOME       = os.getenv("HOME")
local scriptsDir = HOME .. "/.config/hypr/scripts"
-- local userScripts = HOME .. "/.config/hypr/UserScripts"

--------------------
---- MONITORS ------
--------------------
-- Use 'hyprctl monitors' or 'nwg-displays' to find output names/descriptions

hl.monitor({
    output   = "desc:Dell Inc. DELL U3821DW 9V90073",
    mode     = "3840x1600@60",
    position = "0x1200",
    scale    = 1.0,
})
hl.monitor({
    output   = "desc:Dell Inc. DELL U2415 7MT0182524WL",
    mode     = "1920x1200@60",
    position = "3840x400",
    scale    = 1.0,
})
hl.monitor({
    output   = "desc:AU Optronics 0x7AA7",
    mode     = "1920x1200@90",
    position = "3840x1600",
    scale    = 1.0,
})
-- Fallback for any other connected monitor
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- eDP-1 (Laptop-Screen): ungerade Workspaces
hl.workspace_rule({ workspace = "1",  monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "3",  monitor = "eDP-1" })
hl.workspace_rule({ workspace = "5",  monitor = "eDP-1" })
hl.workspace_rule({ workspace = "7",  monitor = "eDP-1" })
hl.workspace_rule({ workspace = "9",  monitor = "eDP-1" })

-- DP-2 (externer Monitor): gerade Workspaces
hl.workspace_rule({ workspace = "2",  monitor = "DP-2", default = true })
hl.workspace_rule({ workspace = "4",  monitor = "DP-2" })
hl.workspace_rule({ workspace = "6",  monitor = "DP-2" })
hl.workspace_rule({ workspace = "8",  monitor = "DP-2" })
hl.workspace_rule({ workspace = "10", monitor = "DP-2" })

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Always float small utility windows
    name  = "float-utility-apps",
    match = {
        class = "^(blueman-manager|nm-connection-editor|pavucontrol|nm-applet)$",
    },

    float  = true,
    center = true,
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
    hl.exec_cmd("swww-daemon --format xrgb")
    -- hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    -- hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    -- hl.exec_cmd(scriptsDir .. "/Polkit.sh")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("swaync")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hypridle")
    -- hl.exec_cmd(scriptsDir .. "/Hyprsunset.sh init")
    -- hl.exec_cmd(scriptsDir .. "/KeybindsLayoutInit.sh")
    -- hl.exec_cmd(scriptsDir .. "/Dropterminal.sh kitty &")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("hyprpaper")
end)



-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- hl.env("GDK_BACKEND",                         "wayland,x11,*")
-- hl.env("QT_QPA_PLATFORM",                     "wayland;xcb")
-- hl.env("QT_AUTO_SCREEN_SCALE_FACTOR",         "1")
-- hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- hl.env("XDG_CURRENT_DESKTOP",                 "Hyprland")
-- hl.env("XDG_SESSION_DESKTOP",                 "Hyprland")
-- hl.env("XDG_SESSION_TYPE",                    "wayland")
-- hl.env("MOZ_ENABLE_WAYLAND",                  "1")
-- hl.env("ELECTRON_OZONE_PLATFORM_HINT",        "auto")
-- hl.env("EDITOR",                              "nvim")
-- hl.env("HYPRCURSOR_THEME",                    "Bibata-Modern-Ice")
-- hl.env("HYPRCURSOR_SIZE",                     "24")
-- hl.env("XCURSOR_SIZE",                        "24")

-------------
---- INPUT --
-------------

hl.config({
    input = {
        kb_layout    = "de",
        repeat_rate  = 50,
        repeat_delay = 300,
        sensitivity  = 0,
        numlock_by_default      = true,
        follow_mouse            = 2,
        float_switch_override_focus = false,
        touchpad = {
            disable_while_typing = true,
            natural_scroll       = true,
            tap_to_click         = true,
        },
    },
})

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in          = 2,
        gaps_out         = 4,
        border_size      = 2,
        resize_on_border = true,
        col = {
            active_border   = "0x3a5a8a",
            inactive_border = "rgba(595959aa)",
        },
        layout = "master",
    },
    decoration = {
        rounding         = 10,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 3,
            render_power = 1,
            color        = 0xee1a1a1a,
        },
        blur = {
            enabled           = true,
            size              = 6,
            passes            = 3,
            new_optimizations = true,
            xray              = true,
        },
    },
    animations = { enabled = true },
})

-- Bezier curves
hl.curve("wind",      { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("winIn",     { type = "bezier", points = { {0.1, 1.1},  {0.1, 1.1}  } })
hl.curve("winOut",    { type = "bezier", points = { {0.3, -0.3}, {0, 1}      } })
hl.curve("smoothOut", { type = "bezier", points = { {0.5, 0},    {0.99, 0.99} } })
hl.curve("overshot",  { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("liner",     { type = "bezier", points = { {1, 1},      {1, 1}      } })

hl.animation({ leaf = "windows",     enabled = true, speed = 6, bezier = "wind" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 5, bezier = "winIn" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 3, bezier = "smoothOut" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind" })
hl.animation({ leaf = "fade",        enabled = true, speed = 3, bezier = "smoothOut" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 5, bezier = "overshot" })

hl.config({
    dwindle = {
        preserve_split       = true,
        special_scale_factor = 0.8,
    },
    master = {
        new_status = "master",
        new_on_top = 1,
        mfact      = 0.5,
    },
})

-----------
---- MISC --
-----------

hl.config({
    misc = {
        disable_hyprland_logo      = true,
        disable_splash_rendering   = true,
        vrr                        = 2,
        mouse_move_enables_dpms    = true,
        enable_swallow             = false,
        focus_on_activate          = false,
        middle_click_paste         = true,
        allow_session_lock_restore = true,
        enable_anr_dialog          = true,
        anr_missed_pings           = 15,
        on_focus_under_fullscreen  = 1,
    },
    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles   = true,
        pass_mouse_when_bound    = false,
    },
    xwayland = {
        enabled            = true,
        force_zero_scaling = true,
    },
    cursor = {
        no_hardware_cursors      = 2,
        enable_hyprcursor        = true,
        warp_on_change_workspace = 2,
        no_warps                 = true,
    },
    render = {
        direct_scanout = 0,
    },
})

-------------------
---- GESTURES -----
-------------------

hl.gesture({
    fingers            = 3,
    direction          = "horizontal",
    action             = "workspace",
    distance           = 500,
    invert             = true,
    min_speed_to_force = 30,
    cancel_ratio       = 0.5,
    create_new         = true,
    forever            = true,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local term  = "kitty"
local files = "thunar"

-- Apps
hl.bind(mainMod .. " + Return",         hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + Y",              hl.dsp.exec_cmd(term .. " yazi"))
hl.bind(mainMod .. " + D",              hl.dsp.exec_cmd("pkill rofi || true && rofi -show drun -modi drun,filebrowser,run,window"))
hl.bind(mainMod .. " + B",              hl.dsp.exec_cmd("firefox"))
-- hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(scriptsDir .. "/Dropterminal.sh " .. term))

-- Window management
hl.bind(mainMod .. " + Q",              hl.dsp.window.close())
-- hl.bind(mainMod .. " + SHIFT + Q",      hl.dsp.exec_cmd(scriptsDir .. "/KillActiveProcess.sh"))
hl.bind(mainMod .. " + SHIFT + F",      hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + CTRL + F",       hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SPACE",          hl.dsp.window.float({ action = "toggle" }))

-- Focus (arrow keys)
hl.bind(mainMod .. " + left",           hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right",          hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",             hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",           hl.dsp.focus({ direction = "down" }))

-- Move window
hl.bind(mainMod .. " + CTRL + left",    hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + right",   hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + up",      hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + down",    hl.dsp.window.move({ direction = "down" }))

-- Swap window
hl.bind(mainMod .. " + ALT + left",     hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + right",    hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up",       hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down",     hl.dsp.window.swap({ direction = "down" }))

-- Resize window
hl.bind(mainMod .. " + SHIFT + left",   hl.dsp.window.resize({ x = -50, y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + right",  hl.dsp.window.resize({ x = 50,  y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",     hl.dsp.window.resize({ x = 0,   y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",   hl.dsp.window.resize({ x = 0,   y = 50,  relative = true }), { repeating = true })

-- Mouse move/resize
hl.bind(mainMod .. " + mouse:272",      hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",      hl.dsp.window.resize(), { mouse = true })

-- Workspace navigation
hl.bind(mainMod .. " + Tab",            hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + Tab",    hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + period",         hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + comma",          hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_down",     hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",       hl.dsp.focus({ workspace = "e-1" }))

-- Switch/move to workspace 1–10
-- (key 0 = workspace 10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. key,    hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + U",              hl.dsp.workspace.toggle_special())
hl.bind(mainMod .. " + SHIFT + U",      hl.dsp.window.move({ workspace = "special" }))

-- Move workspace to other monitor
-- NOTE: hl.dsp.workspace.move's `monitor` field expects a monitor selector
-- (name/id/+1/-1), not a direction (l/r/u/d) like the old dispatcher took.
-- These are left as monitor names; adjust to your actual monitor names if needed.
-- hl.bind(mainMod .. " + CTRL + F9",   hl.dsp.workspace.move({ monitor = "..." }))
-- hl.bind(mainMod .. " + CTRL + F10",  hl.dsp.workspace.move({ monitor = "..." }))
-- hl.bind(mainMod .. " + CTRL + F11",  hl.dsp.workspace.move({ monitor = "..." }))
-- hl.bind(mainMod .. " + CTRL + F12",  hl.dsp.workspace.move({ monitor = "..." }))

-- Window groups
hl.bind(mainMod .. " + G",              hl.dsp.group.toggle())
hl.bind(mainMod .. " + CTRL + Tab",     hl.dsp.group.next())
hl.bind(mainMod .. " + CTRL + K",       hl.dsp.window.move({ into_group = "left" }))
hl.bind(mainMod .. " + CTRL + L",       hl.dsp.window.move({ into_group = "right" }))
hl.bind(mainMod .. " + CTRL + H",       hl.dsp.window.move({ out_of_group = true }))

-- Layout
hl.bind(mainMod .. " + P",              hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + I",      hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + I",              hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + CTRL + D",       hl.dsp.layout("removemaster"))
hl.bind(mainMod .. " + CTRL + Return",  hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + M",              hl.dsp.layout("splitratio 0.3"))
hl.bind(mainMod .. " + ALT + L",        hl.dsp.exec_cmd(scriptsDir .. "/ChangeLayout.sh"))

-- Cycle windows
hl.bind("ALT + Tab",              hl.dsp.window.cycle_next())

-- System
hl.bind("CTRL + ALT + Delete",    hl.dsp.exit())
hl.bind("CTRL + ALT + L",         hl.dsp.exec_cmd(scriptsDir .. "/LockScreen.sh"))
hl.bind("CTRL + ALT + P",         hl.dsp.exec_cmd(scriptsDir .. "/Wlogout.sh"))
hl.bind(mainMod .. " + SHIFT + N",      hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Screenshot
hl.bind(mainMod .. " + Print",          hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --now"))
hl.bind(mainMod .. " + SHIFT + Print",  hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --area"))
hl.bind(mainMod .. " + SHIFT + S",      hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --swappy"))
hl.bind(mainMod .. " + CTRL + Print",   hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in5"))
hl.bind("ALT + Print",            hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --active"))

-- Media keys
hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --inc"),        { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --dec"),        { locked = true, repeating = true })
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle"),     { locked = true })
hl.bind("XF86AudioMicMute",       hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle-mic"), { locked = true })
-- hl.bind("XF86AudioPlayPause",     hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --pause"),   { locked = true })
hl.bind("XF86AudioNext",          hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --nxt"),     { locked = true })
hl.bind("XF86AudioPrev",          hl.dsp.exec_cmd(scriptsDir .. "/MediaCtrl.sh --prv"),     { locked = true })
hl.bind("XF86Sleep",              hl.dsp.exec_cmd("systemctl suspend"),                     { locked = true })

-- Brightness keys
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Night light
hl.bind(mainMod .. " + N",              hl.dsp.exec_cmd(scriptsDir .. "/Hyprsunset.sh toggle"))

-- Waybar
hl.bind(mainMod .. " + CTRL + ALT + B", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
-- hl.bind(mainMod .. " + CTRL + B",       hl.dsp.exec_cmd(scriptsDir .. "/WaybarStyles.sh"))
-- hl.bind(mainMod .. " + ALT + B",        hl.dsp.exec_cmd(scriptsDir .. "/WaybarLayout.sh"))

-- Wallpaper / theme
hl.bind(mainMod .. " + W",              hl.dsp.exec_cmd(scriptsDir .. "/WallpaperSelect.sh"))
-- hl.bind(mainMod .. " + SHIFT + W",      hl.dsp.exec_cmd(userScripts .. "/WallpaperEffects.sh"))
-- hl.bind("CTRL + ALT + W",         hl.dsp.exec_cmd(userScripts .. "/WallpaperRandom.sh"))
-- hl.bind(mainMod .. " + T",              hl.dsp.exec_cmd(scriptsDir .. "/ThemeChanger.sh"))

-- Misc tools
-- hl.bind(mainMod .. " + A",              hl.dsp.exec_cmd(scriptsDir .. "/OverviewToggle.sh"))
-- hl.bind(mainMod .. " + H",              hl.dsp.exec_cmd(scriptsDir .. "/KeyHints.sh"))
-- hl.bind(mainMod .. " + S",              hl.dsp.exec_cmd(scriptsDir .. "/RofiSearch.sh"))
hl.bind(mainMod .. " + S",       hl.dsp.exec_cmd("rofi -show window"))
hl.bind(mainMod .. " + V",        hl.dsp.exec_cmd(scriptsDir .. "/ClipManager.sh"))
-- hl.bind(mainMod .. " + ALT + E",        hl.dsp.exec_cmd(scriptsDir .. "/RofiEmoji.sh"))

-- wirklich notwendig?
hl.bind(mainMod .. " + ALT + C",        hl.dsp.exec_cmd(scriptsDir .. "/RofiCalc.sh"))
-- hl.bind(mainMod .. " + ALT + R",        hl.dsp.exec_cmd(scriptsDir .. "/Refresh.sh"))
-- hl.bind(mainMod .. " + SHIFT + K",      hl.dsp.exec_cmd(scriptsDir .. "/KeyBinds.sh"))
-- hl.bind(mainMod .. " + SHIFT + A",      hl.dsp.exec_cmd(scriptsDir .. "/Animations.sh"))
-- hl.bind(mainMod .. " + SHIFT + M",      hl.dsp.exec_cmd(userScripts .. "/RofiBeats.sh"))

