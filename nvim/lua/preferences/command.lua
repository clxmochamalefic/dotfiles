if vim.g.is_enable_my_debug
  echo "begin " . expand('%/h') . " load"
end

-- +++++++++++++++
--  define command

--  jq command
--  if cannot use
--    windows       : > pwsh -command "Start-Process -verb runas pwsh" "'-command winget install stedolan.jq'"
--    brew on macOS : % brew install jq
--    linux (debian): $ sudo apt -y update
--                    $ sudo apt -y install jq
--    linux (RHEL)  : $ sudo yum -y install epel-release
--                    $ sudo yum -y install jq
vim.fn.command("Jqf", "!j+ '.'")
vim.fn.command("Jq",  "!j+ '%:p'")

--  preference file open mapping
local ginitvim_filepath = vim.g.my_initvim_path + '/ginit.vim'
local initvim_filepath  = vim.g.my_initvim_path + '/init.vim'


--  plugin preference file open mapping
local dein_toml_path  = vim.g.my_initvim_path + '/dein/'

local dein_toml_filepath        = dein_toml_path + 'dein.toml'
local dein_lazy_toml_filepath   = dein_toml_path + 'dein.lazy.toml'
local ddc_lazy_toml_filepath    = dein_toml_path + 'ddc.lazy.toml'
local ddu_lazy_toml_filepath    = dein_toml_path + 'ddu.lazy.toml'
local lsp_lazy_toml_filepath    = dein_toml_path + 'lsp.lazy.toml'
local colorscheme_filepath      = dein_toml_path + 'colorscheme.toml'

--  init.vim open
vim.fn.command("Preferences", "execute " + initvim_filepath)
vim.fn.command("Pref", "Preferences")
vim.fn.command("Pr", "Preferences")

--  ginit.vim open
vim.fn.command("PreferencesGui", "execute " + ginitvim_filepath)
vim.fn.command("PrefGui", "Preferences")
vim.fn.command("Pg", "PreferencesGui")

--  dein.toml open
-- TODO: ERASE?
--
-- vim.fn.command("Plugins", "execute " + basic_plugin_filepath)
-- vim.fn.command("Plu", "Plugins")
-- 
-- --  dein_lazy.toml open
-- vim.fn.command("PluginsLazy", "execute " + lazy_load_plugin_filepath)
-- vim.fn.command("Pll", "PluginsLazy")
-- 
-- --  themes.toml open
-- vim.fn.command("PluginsTheme", "execute " + theme_plugin_filepath)
-- vim.fn.command("Pt", "PluginsTheme")

--  init.vim reload
local function reload_preference()
  if vim.fn.has("gui_running") then
    vim.fn.execute("source " + ginitvim_filepath)
  end
  -- TODO: ERASE?
  -- vim.fn.call('dein#call_hook("add")')
  -- vim.fn.exe
end

local function reload_all()
  reload_preference()
  -- reload_plugin_hard(vim.g.dein_plugins)
end

vim.fn.command("ReloadPreference",  reload_preference())
vim.fn.command("Rer", "ReloadPreference")
vim.fn.command("ReloadAll", reload_all())
vim.fn.command("Rea", "ReloadAll")

--  show dein.vim install and update progress
vim.fn.command("DeinProgress", vim.fn.echo(vim.fn['dein#get_progress']()))
vim.fn.command("Dp", "DeinProgress")

if vim.g.is_enable_my_debug then
  vim.fn.echo("end " + vim.fn.expand('%/h') + " load")
end
