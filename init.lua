-- print = function (...)
--    logger:info(...)
-- end

vim.cmd([[
  let g:neovide_transparency=0.8
]])

function _G.dump(o)
   if type(o) == "table" then
      local s = "{ "
      for k, v in pairs(o) do
         if type(k) ~= "number" then
            k = '"' .. k .. '"'
         end
         s = s .. "[" .. k .. "] = " .. _G.dump(v) .. ","
      end
      return s .. "} "
   else
      return tostring(o)
   end
end

local function fprint(string, ...)
   print(string.format(string, ...))
end

vim.g["nya#bootstrap"] = {}

local function bootstrap(plugin, commit)
   local _, _, plugin_name = string.find(plugin, [[%S+/(%S+)]])
   -- local plugin_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/" ..
   local plugin_path = vim.fn.stdpath("data") .. "/lazy/" .. plugin_name
   vim.g["nya#bootstrap"][plugin] = false
   if vim.fn.empty(vim.fn.glob(plugin_path)) > 0 then
      fprint("Couldn't find '%s', cloning new copy to %s", plugin_name, plugin_path)

      if commit ~= "" and commit ~= nil then
         vim.fn.system({ "git", "clone", "https://github.com/" .. plugin, plugin_path })
         fprint("Selecting " .. commit .. " for " .. plugin)
         vim.fn.system({ "git", "-C", plugin_path, "checkout", commit })
      else
         vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/" .. plugin, plugin_path })
      end
      -- vim.cmd("helptags " .. plugin_path .. "/doc")
      vim.g["nya#bootstrap"][plugin] = true
   end
   vim.opt.rtp:prepend(plugin_path)
end

-- bootstrap("wbthomason/packer.nvim")
bootstrap("folke/lazy.nvim")
bootstrap("rktjmp/hotpot.nvim")
bootstrap("Tastyep/structlog.nvim", "6f1403a192791ff1fa7ac845a73de9e860f781f1")

do
   local status_ok, hotpot = pcall(require, "hotpot")
   if status_ok then
      hotpot.setup({
         provide_require_fennel = true,
         compiler = {
            -- options passed to fennel.compile for modules, defaults to {}
            modules = {
               -- not default but recommended, align lua lines with fnl source
               -- for more debuggable errors, but less readable lua.
               correlate = true,
            },
            -- options passed to fennel.compile for macros, defaults as shown
            macros = {
               env = "_COMPILER", -- MUST be set along with any other options
            },
         },
      })
      debug.traceback = require("fennel").traceback
   else
      fprint("failed to load hotpot")
      return
   end
end

do
   local status_ok, log = pcall(require, "structlog")
   -- local status_ok = false

   if status_ok then
      _G.logger = log.Logger("user", {
         log.sinks.File(log.level.TRACE, vim.fn.stdpath("config") .. "/logger-user.log", {
            processors = {
               log.processors.Namer(),
               log.processors.Timestamper("%H:%M:%S"),
            },
            formatter = log.formatters.Format( --
               "%s [%s] %s: %-30s",
               { "timestamp", "level", "logger_name", "msg" }
            ),
         }),
      })
      logger:info("structlog init")
   else
      _G.logger = {
         ["info"] = function(...) end,
         ["error"] = function(...) end,
      }
   end
end

if _G.logger then
   logger:info("init.lua loaded")
end
require("config")
