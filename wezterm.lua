local wezterm = require 'wezterm'
local act = wezterm.action

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

-- タブのカスタマイズ
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)

    -- プロセスに合わせてアイコン表示
	local nerd_icons = {
		nvim = wezterm.nerdfonts.custom_vim,
		vim = wezterm.nerdfonts.custom_vim,
		bash = wezterm.nerdfonts.dev_terminal,
		zsh = wezterm.nerdfonts.dev_terminal,
		ssh = wezterm.nerdfonts.mdi_server,
		top = wezterm.nerdfonts.mdi_monitor,
        docker = wezterm.nerdfonts.dev_docker,
        node = wezterm.nerdfonts.dev_nodejs_small,
	}
    local zoomed = ""
    if tab.active_pane.is_zoomed then
      zoomed = "[Z] "
    end
	local pane = tab.active_pane
	local process_name = basename(pane.foreground_process_name)
	local icon = nerd_icons[process_name]
	local index = tab.tab_index + 1
	local cwd = basename(pane.current_working_dir)
  -- 例) 1:project_dir | zsh
	local title = index .. ": " .. cwd .. "  | " .. process_name
	if icon ~= nil then
		title = icon .. "  " .. zoomed .. title
	end
	return {
		{ Text = " " .. title .. " " },
	}
end)

return {
  font_size = 20.0,
  font = wezterm.font_with_fallback {
    'Source Code Pro for Powerline',
    'Source Code Pro',
    'Ricty Discord for Powerline',
    'Ricty for Powerline',
    'JetBrains Mono',
  },
  colors = {
    cursor_bg = '#0f4',
    cursor_fg = '#033',
    -- cursot_border = 'white',
  },
  cursor_blink_rate = 1000,
  default_cursor_style = 'BlinkingBlock',
  color_scheme = "Bim (Gogh)",
  -- color_scheme = "Whimsy",
  -- color_scheme = "zenburned",
  window_background_opacity = 0.91,
  adjust_window_size_when_changing_font_size = false,
  window_close_confirmation = 'AlwaysPrompt',
  enable_scroll_bar = true,
  leader = { key = 'q', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    { key = 'q', mods = 'SHIFT|CTRL', action = wezterm.action.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
    { key = '[', mods = 'SUPER', action = wezterm.action.ActivateCopyMode },
    { key = '/', mods = 'LEADER', action = wezterm.action.Search({CaseSensitiveString=""}) },
    { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection("Left") },
    { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection("Down") },
    { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection("Up") },
    { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection("Right") },
    { key = '|', mods = 'LEADER', action = wezterm.action({
        SplitHorizontal = { domain = "CurrentPaneDomain"},
      }) },
    { key = '-', mods = 'LEADER', action = wezterm.action({
      SplitVertical = { domain = "CurrentPaneDomain" },
    }) },
    { key = 'w', mods = 'LEADER', action = wezterm.action({
      CloseCurrentPane = { confirm = false },
    }) },
    { key = 'c', mods = 'LEADER', action = wezterm.action({
      SpawnTab = "DefaultDomain",
    })},
    { key = 'p', mods = 'LEADER', action = wezterm.action({
      ActivateTabRelative = -1,
    })},
    { key = 'n', mods = 'LEADER', action = wezterm.action({
      ActivateTabRelative = 1,
    })},
    { key = 'x', mods = 'LEADER', action = wezterm.action({
      CloseCurrentTab = { confirm = false },
    })},
  },
  key_tables = {
    resize_pane = {
      { key = 'h', action = wezterm.action.AdjustPaneSize {"Left", 1} },
      { key = 'j', action = wezterm.action.AdjustPaneSize {"Down", 1} },
      { key = 'k', action = wezterm.action.AdjustPaneSize {"Up", 1} },
      { key = 'l', action = wezterm.action.AdjustPaneSize {"Right", 1} },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'Enter', action = 'PopKeyTable' },
    },
    copy_mode = {
      { key = 'Tab', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      {
        key = 'Tab',
        mods = 'SHIFT',
        action = act.CopyMode 'MoveBackwardWord',
      },
      {
        key = '[',
        mods = 'SUPER',
        action = act.CopyMode 'Close',
      },
      -- {
      --   key = 'Enter',
      --   mods = 'NONE',
      --   action = act.CopyMode 'MoveToStartOfNextLine',
      -- },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'Escape', mods ='SUPER', action = act.CopyMode 'AcceptPattern' },
      { key = 'Enter', mods = 'SUPER', action = act.CopyMode 'AcceptPattern' },
      -- {
      --   key = 'Space',
      --   mods = 'NONE',
      --   action = act.CopyMode { SetSelectionMode = 'Cell' },
      -- },
      {
        key = '$',
        mods = 'NONE',
        action = act.CopyMode 'MoveToEndOfLineContent',
      },
      {
        key = '$',
        mods = 'SHIFT',
        action = act.CopyMode 'MoveToEndOfLineContent',
      },
      { key = ',', mods = 'NONE', action = act.CopyMode 'JumpReverse' },
      { key = '0', mods = 'SUPER', action = act.CopyMode 'MoveToStartOfLine' },
      { key = ';', mods = 'NONE', action = act.CopyMode 'JumpAgain' },
      {
        key = 'F',
        mods = 'SUPER',
        action = act.CopyMode { JumpBackward = { prev_char = false } },
      },
      {
        key = 'F',
        mods = 'SHIFT|SUPER',
        action = act.CopyMode { JumpBackward = { prev_char = false } },
      },
      {
        key = 'G',
        mods = 'SUPER',
        action = act.CopyMode 'MoveToScrollbackBottom',
      },
      {
        key = 'G',
        mods = 'SHIFT|SUPER',
        action = act.CopyMode 'MoveToScrollbackBottom',
      },
      { key = 'H', mods = 'NONE', action = act.CopyMode 'MoveToViewportTop' },
      {
        key = 'H',
        mods = 'SHIFT|SUPER',
        action = act.CopyMode 'MoveToViewportTop',
      },
      {
        key = 'L',
        mods = 'SUPER',
        action = act.CopyMode 'MoveToViewportBottom',
      },
      {
        key = 'L',
        mods = 'SHIFT|SUPER',
        action = act.CopyMode 'MoveToViewportBottom',
      },
      {
        key = 'M',
        mods = 'SUPER',
        action = act.CopyMode 'MoveToViewportMiddle',
      },
      {
        key = 'M',
        mods = 'SHIFT|SUPER',
        action = act.CopyMode 'MoveToViewportMiddle',
      },
      {
        key = 'O',
        mods = 'SUPER',
        action = act.CopyMode 'MoveToSelectionOtherEndHoriz',
      },
      {
        key = 'O',
        mods = 'SHIFT|SUPER',
        action = act.CopyMode 'MoveToSelectionOtherEndHoriz',
      },
      {
        key = 'T',
        mods = 'SUPER',
        action = act.CopyMode { JumpBackward = { prev_char = true } },
      },
      {
        key = 'T',
        mods = 'SHIFT|SUPER',
        action = act.CopyMode { JumpBackward = { prev_char = true } },
      },
      {
        key = 'V',
        mods = 'SUPER',
        action = act.CopyMode { SetSelectionMode = 'Line' },
      },
      {
        key = 'V',
        mods = 'SHIFT|SUPER',
        action = act.CopyMode { SetSelectionMode = 'Line' },
      },
      {
        key = '^',
        mods = 'SUPER',
        action = act.CopyMode 'MoveToStartOfLineContent',
      },
      {
        key = '^',
        mods = 'SHIFT',
        action = act.CopyMode 'MoveToStartOfLineContent',
      },
      { key = 'b', mods = 'SUPER', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
      { key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
      {
        key = 'e',
        mods = 'SUPER',
        action = act.CopyMode 'MoveToEndOfLineContent',
      },
      {
        key = 'f',
        mods = 'SUPER',
        action = act.CopyMode { JumpForward = { prev_char = false } },
      },
      { key = 'f', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
      { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
      {
        key = 'g',
        mods = 'SUPER',
        action = act.CopyMode 'MoveToScrollbackTop',
      },
      { key = 'g', mods = 'CTRL', action = act.CopyMode 'Close' },
      { key = 'h', mods = 'SUPER', action = act.CopyMode 'MoveLeft' },
      { key = 'j', mods = 'SUPER', action = act.CopyMode 'MoveDown' },
      { key = 'k', mods = 'SUPER', action = act.CopyMode 'MoveUp' },
      { key = 'l', mods = 'SUPER', action = act.CopyMode 'MoveRight' },
      {
        key = 'm',
        mods = 'ALT',
        action = act.CopyMode 'MoveToStartOfLineContent',
      },
      {
        key = 'o',
        mods = 'SUPER',
        action = act.CopyMode 'MoveToSelectionOtherEnd',
      },
      { key = 'q', mods = 'SUPER', action = act.CopyMode 'Close' },
      {
        key = 't',
        mods = 'SUPER',
        action = act.CopyMode { JumpForward = { prev_char = true } },
      },
      { key = 'f', mods = 'SUPER', action = act.CopyMode 'PageUp' },
      { key = 'u', mods = 'SUPER', action = act.CopyMode 'PageDown' },
      -- below lines work with nightly build only.
      -- {
      --   key = 'f',
      --   mods = 'CTRL',
      --   action = act.CopyMode { MoveByPage = 0.5 },
      -- },
      -- {
      --   key = 'u',
      --   mods = 'CTRL',
      --   action = act.CopyMode { MoveByPage = -0.5 },
      -- },
      {
        key = 'v',
        mods = 'SUPER',
        action = act.CopyMode { SetSelectionMode = 'Cell' },
      },
      {
        key = 'v',
        mods = 'CTRL',
        action = act.CopyMode { SetSelectionMode = 'Block' },
      },
      { key = 'w', mods = 'SUPER', action = act.CopyMode 'MoveForwardWord' },
      {
        key = 'y',
        mods = 'SUPER',
        action = act.Multiple {
          { CopyTo = 'ClipboardAndPrimarySelection' },
          { CopyMode = 'Close' },
        },
      },
      { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
      { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
      {
        key = 'End',
        mods = 'NONE',
        action = act.CopyMode 'MoveToEndOfLineContent',
      },
      {
        key = 'Home',
        mods = 'NONE',
        action = act.CopyMode 'MoveToStartOfLine',
      },
      { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      {
        key = 'LeftArrow',
        mods = 'ALT',
        action = act.CopyMode 'MoveBackwardWord',
      },
      {
        key = 'RightArrow',
        mods = 'NONE',
        action = act.CopyMode 'MoveRight',
      },
      {
        key = 'RightArrow',
        mods = 'ALT',
        action = act.CopyMode 'MoveForwardWord',
      },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      {key="y", mods="NONE", action=act{Multiple={
             wezterm.action{CopyTo="ClipboardAndPrimarySelection"},
             wezterm.action{CopyMode="Close"}
      }}},
      {key="/", mods="NONE", action=act.CopyMode 'EditPattern' },
      {key="/", mods="SUPER", action=act.CopyMode 'NextMatch' },
      {key="/", mods="SUPER|SHIFT", action=act.CopyMode 'PriorMatch' },
    },
  },
}
