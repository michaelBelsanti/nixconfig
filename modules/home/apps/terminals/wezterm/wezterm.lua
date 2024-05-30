-- Causes a duplicate in the config, but needed so LSP doesnt spam errors
local wezterm = require("wezterm")
local act = wezterm.action
local config = {}
if wezterm.config_builder then config = wezterm.config_builder() end

config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font("monospace")
config.font_size = 12.0
config.use_dead_keys = false
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false

wezterm.on("update-right-status", function(window, pane)
  -- From https://github.com/theopn/dotfiles/blob/25b85936ef3e7195a0f029525f854fdb915b9f90/wezterm/wezterm.lua
  -- Current working directory
  local basename = function(s)
    -- Nothign a little regex can't fix
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
  end
  local cwd = basename(pane:get_current_working_dir())
  -- Current command
  local cmd = basename(pane:get_foreground_process_name())

  window:set_right_status(wezterm.format({
    -- Wezterm has a built-in nerd fonts
    { Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
    { Text = " | " },
    { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
    -- { Text = " |" },
  }))
end)


config.keys = {
  { key = '+',          mods = 'CTRL',       action = act.IncreaseFontSize },
  { key = '-',          mods = 'CTRL',       action = act.DecreaseFontSize },
  { key = '0',          mods = 'CTRL',       action = act.ResetFontSize },
  { key = 'c',          mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'f',          mods = 'CTRL|SHIFT', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'Return',     mods = 'ALT',        action = act.SpawnWindow },
  { key = 'r',          mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },
  { key = 'e',          mods = 'CTRL|SHIFT', action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' } },
  { key = 'v',          mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
  { key = 'x',          mods = 'CTRL|SHIFT', action = act.ActivateCopyMode },
  { key = 'phys:Space', mods = 'CTRL|SHIFT', action = act.QuickSelect },
  { key = 'PageUp',     mods = 'SHIFT',      action = act.ScrollByPage(-1) },
  -- Multiplexing
  { key = 'n',          mods = 'ALT',        action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = 'n',          mods = 'SHIFT|ALT',  action = act.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = 'q',          mods = 'ALT',        action = act.CloseCurrentPane { confirm = false } },
  { key = 'h',          mods = 'ALT',        action = act.ActivatePaneDirection "Left" },
  { key = 'j',          mods = 'ALT',        action = act.ActivatePaneDirection "Down" },
  { key = 'k',          mods = 'ALT',        action = act.ActivatePaneDirection "Up" },
  { key = 'l',          mods = 'ALT',        action = act.ActivatePaneDirection "Right" },
  { key = 'h',          mods = 'SHIFT|ALT',  action = act.AdjustPaneSize { "Left", 5 } },
  { key = 'j',          mods = 'SHIFT|ALT',  action = act.AdjustPaneSize { "Down", 3 } },
  { key = 'k',          mods = 'SHIFT|ALT',  action = act.AdjustPaneSize { "Up", 3 } },
  { key = 'l',          mods = 'SHIFT|ALT',  action = act.AdjustPaneSize { "Right", 5 } },
  { key = 'f',          mods = 'ALT',        action = act.TogglePaneZoomState },
}

config.key_tables = {
  copy_mode = {
    { key = 'Tab',        mods = 'NONE',  action = act.CopyMode 'MoveForwardWord' },
    { key = 'Tab',        mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
    { key = 'Enter',      mods = 'NONE',  action = act.CopyMode 'MoveToStartOfNextLine' },
    { key = 'Escape',     mods = 'NONE',  action = act.CopyMode 'Close' },
    { key = 'Space',      mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Cell' } },
    { key = '$',          mods = 'NONE',  action = act.CopyMode 'MoveToEndOfLineContent' },
    { key = '$',          mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
    { key = '0',          mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLine' },
    { key = 'G',          mods = 'NONE',  action = act.CopyMode 'MoveToScrollbackBottom' },
    { key = 'G',          mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
    { key = 'H',          mods = 'NONE',  action = act.CopyMode 'MoveToViewportTop' },
    { key = 'H',          mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
    { key = 'L',          mods = 'NONE',  action = act.CopyMode 'MoveToViewportBottom' },
    { key = 'L',          mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
    { key = 'M',          mods = 'NONE',  action = act.CopyMode 'MoveToViewportMiddle' },
    { key = 'M',          mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
    { key = 'O',          mods = 'NONE',  action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
    { key = 'O',          mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
    { key = 'V',          mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Line' } },
    { key = 'V',          mods = 'SHIFT', action = act.CopyMode { SetSelectionMode = 'Line' } },
    { key = '^',          mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLineContent' },
    { key = '^',          mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
    { key = 'b',          mods = 'NONE',  action = act.CopyMode 'MoveBackwardWord' },
    { key = 'b',          mods = 'ALT',   action = act.CopyMode 'MoveBackwardWord' },
    { key = 'b',          mods = 'CTRL',  action = act.CopyMode 'PageUp' },
    { key = 'c',          mods = 'CTRL',  action = act.CopyMode 'Close' },
    { key = 'f',          mods = 'ALT',   action = act.CopyMode 'MoveForwardWord' },
    { key = 'f',          mods = 'CTRL',  action = act.CopyMode 'PageDown' },
    { key = 'g',          mods = 'NONE',  action = act.CopyMode 'MoveToScrollbackTop' },
    { key = 'g',          mods = 'CTRL',  action = act.CopyMode 'Close' },
    { key = 'h',          mods = 'NONE',  action = act.CopyMode 'MoveLeft' },
    { key = 'j',          mods = 'NONE',  action = act.CopyMode 'MoveDown' },
    { key = 'k',          mods = 'NONE',  action = act.CopyMode 'MoveUp' },
    { key = 'l',          mods = 'NONE',  action = act.CopyMode 'MoveRight' },
    { key = 'm',          mods = 'ALT',   action = act.CopyMode 'MoveToStartOfLineContent' },
    { key = 'o',          mods = 'NONE',  action = act.CopyMode 'MoveToSelectionOtherEnd' },
    { key = 'q',          mods = 'NONE',  action = act.CopyMode 'Close' },
    { key = 'v',          mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Cell' } },
    { key = 'v',          mods = 'CTRL',  action = act.CopyMode { SetSelectionMode = 'Block' } },
    { key = 'w',          mods = 'NONE',  action = act.CopyMode 'MoveForwardWord' },
    { key = 'y',          mods = 'NONE',  action = act.Multiple { { CopyTo = 'ClipboardAndPrimarySelection' }, { CopyMode = 'Close' } } },
    { key = 'PageUp',     mods = 'NONE',  action = act.CopyMode 'PageUp' },
    { key = 'PageDown',   mods = 'NONE',  action = act.CopyMode 'PageDown' },
    { key = 'LeftArrow',  mods = 'NONE',  action = act.CopyMode 'MoveLeft' },
    { key = 'LeftArrow',  mods = 'ALT',   action = act.CopyMode 'MoveBackwardWord' },
    { key = 'RightArrow', mods = 'NONE',  action = act.CopyMode 'MoveRight' },
    { key = 'RightArrow', mods = 'ALT',   action = act.CopyMode 'MoveForwardWord' },
    { key = 'UpArrow',    mods = 'NONE',  action = act.CopyMode 'MoveUp' },
    { key = 'DownArrow',  mods = 'NONE',  action = act.CopyMode 'MoveDown' },
  },

  search_mode = {
    { key = 'Enter',     mods = 'NONE', action = act.CopyMode 'PriorMatch' },
    { key = 'Escape',    mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'n',         mods = 'CTRL', action = act.CopyMode 'NextMatch' },
    { key = 'p',         mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
    { key = 'r',         mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
    { key = 'u',         mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
    { key = 'PageUp',    mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
    { key = 'PageDown',  mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
    { key = 'UpArrow',   mods = 'NONE', action = act.CopyMode 'PriorMatch' },
    { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
  },
}


return config
