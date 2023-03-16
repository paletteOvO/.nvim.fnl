vim.bo.indentexpr = "g:GetFennelIndent(v:lnum)"

local indentation_regex = vim.regex([[^\s\+]])

local function get_indentation_for_line(line)
   local istart, iend = indentation_regex:match_str(line)

   if istart ~= nil then
      -- XXX: The docs say `tabstop` should be respected, but this doesn't seem
      -- to be happening (check this on go files).
      return string.sub(line, istart, iend)
   end

   return ""
end

local function find_left_bucket(lines, lnum, cur, counting)
   -- counting :: {  [1] = "()" [2] = "[]" [3] = "{}" }

   local line = lines[lnum]
   -- logger:debug("find_left_bucket: " .. lnum .. ": " .. line)
   local start = cur + 1
   if cur == 0 then
      start = #line
   end
   local letters = {}
   for letter in line:gmatch(".[\128-\191]*") do
      table.insert(letters, letter)
   end

   local s = "["

   for _, v in ipairs(letters) do
      s = s .. " " .. v
   end
   -- logger:info("find_left_bucket: " .. lnum .. ": " .. s .. " ]")

   local i = start
   while i > 0 do
      local letter = letters[i]
      -- logger:info("find_left_bucket: " .. i .. ": " .. letter)
      if letter == "(" then
         counting[1] = counting[1] - 1
      end
      if letter == ")" then
         counting[1] = counting[1] + 1
      end

      if letter == "[" then
         counting[2] = counting[2] - 1
      end
      if letter == "]" then
         counting[2] = counting[2] + 1
      end

      if letter == "{" then
         counting[3] = counting[3] - 1
      end
      if letter == "}" then
         counting[3] = counting[3] + 1
      end

      if counting[1] < 0 then
         return 1, lnum
      end
      if counting[2] < 0 then
         return 2, lnum
      end
      if counting[3] < 0 then
         return 3, lnum
      end

      i = i - 1
   end

   if #get_indentation_for_line(line) == 0 and counting == 0 then
      -- logger:info("find_left_bucket: " .. lnum .. ": " .. " early returning 0")
      return 0, lnum
   end

   if lnum > 1 then
      return find_left_bucket(lines, lnum - 1, 0, counting)
   end

   return 0, 0
end

function vim.g.GetFennelIndent()
   local pos = vim.fn.getpos(".")
   -- local cur = pos[1]
   local lnum = pos[2]

   local status_ok, ret = xpcall(function()
      local lines = vim.api.nvim_buf_get_lines(0, 0, lnum, false)
      local found, lf_bkt_lnum = find_left_bucket(lines, lnum - 1, 0, { 0, 0, 0 })
      -- logger:info("bucket at " .. lf_bkt_lnum)

      local indent_level = math.floor(#get_indentation_for_line(lines[lf_bkt_lnum]) / vim.bo.shiftwidth)
      -- logger:info("indent_level: " .. indent_level)
      if found == 0 then
         return indent_level * vim.bo.shiftwidth
      end
      if found == 1 or found == 2 or found == 3 then
         return (indent_level + 1) * vim.bo.shiftwidth
      end
      -- should't happen
      return 0
   end, function(err)
      logger:error(err)
   end)

   if status_ok then
      return ret
   else
      return 0
   end
end
