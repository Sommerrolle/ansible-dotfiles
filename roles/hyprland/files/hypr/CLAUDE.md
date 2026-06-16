# Hyprland Config (Lua)

Dieses Setup nutzt die native **Lua-Konfiguration** von Hyprland 0.55+ (`hl` API),
nicht die klassische `hyprland.conf`-Syntax. Haupt-Config: `hyprland.lua`.

## Bevor du Dispatcher-/API-Syntax recherchierst

Lokale Referenz-Dokumente liegen in `lua_docs/` — dort zuerst nachsehen,
bevor erneut im Netz gesucht wird:

- `lua_docs/dispatcher_api_notes.md` — Zusammenfassung der `hl.dsp.*`
  Dispatcher-Signaturen, Window-Rule-Felder und ein wichtiger Hinweis dazu,
  warum `hyprctl dispatch "<klassischer dispatcher string>"` in dieser
  Version **nicht** funktioniert (es wird als Lua-Ausdruck ausgewertet).
- `lua_docs/example_hyprland.lua` — offizielle Beispiel-Config
  (`/usr/share/hypr/hyprland.lua`), zeigt korrekte `hl.bind`/`hl.dsp`-Syntax.
- `lua_docs/hl.meta.lua` — vollständiger Type-Stub
  (`/usr/share/hypr/stubs/hl.meta.lua`) für alle `hl.*`-Namespaces/Klassen.

## Wichtige Stolperfallen

- **Kein generischer `dispatch(action)`-Helper über `hyprctl dispatch`**:
  Für jeden klassischen Dispatcher (`movefocus`, `fullscreen`, `workspace`, ...)
  muss die entsprechende `hl.dsp.*`-Funktion mit Tabellen-Argumenten verwendet
  werden (siehe `dispatcher_api_notes.md`).
- `hl.dsp.workspace.move({ monitor = ... })` akzeptiert **keine** Richtungs-Strings
  (`l`/`r`/`u`/`d`) wie der alte `movecurrentworkspacetomonitor`-Dispatcher —
  nur Monitor-Name/ID/`+1`/`-1`.
- Modifier-Variable heißt `mainMod` (= `"SUPER"`), nicht `M`.
- Nach Änderungen testen mit `hyprctl reload` und Hyprland-Log auf Lua-Fehler
  prüfen: `~/.run/user/1000/hypr/<signature>/hyprland.log` bzw.
  `$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/hyprland.log`.

## Struktur

- `hyprland.lua` — Haupt-Config (Monitore, Workspaces, Keybinds, Window Rules, etc.)
- `monitors.conf`, `workspaces.conf` — derzeit ungenutzt/leer
- `scripts/` — Shell-Skripte für Screenshot, Lock, Volume, etc.
- `lua_docs/` — lokale API-Referenz (siehe oben)
