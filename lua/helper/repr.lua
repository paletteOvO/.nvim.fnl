local M = {}

function M.lua_arr_to_fennel(arr,indent)
   if indent == nil then
      indent = -1
   end
   for _ = 0,indent do
      io.write(" ")
   end

   io.write("[")
   print()
   for _, v in ipairs(arr) do
      if type(v) == 'table' then
         if v[#v] ~= nil then
            M.lua_arr_to_fennel(v, indent + 2)
         else
            M.lua_tbl_to_fennel(v, indent + 2)
         end
      else
         for _ = 0,indent + 2 do
            io.write(" ")
         end
         if type(v) ~= "string" then
            print(tostring(v))
         else
            print('"' .. v .. '"')
         end
      end
   end
   for _ = 0,indent do
      io.write(" ")
   end
   io.write("]")
   print()
end

function M.lua_tbl_to_fennel(tbl,indent)
   if indent == nil then
      indent = -1
   end
   for _ = 0,indent do
      io.write(" ")
   end

   io.write("{")
   print()
   for k, v in pairs(tbl) do
      for _ = 0,indent + 2 do
         io.write(" ")
      end
      if type(k) == "string" then
         k = ':' .. k
      end
      io.write(k .. " ")
      if type(v) == 'table' then
         if v[#v] ~= nil then
            M.lua_arr_to_fennel(v, indent + 2)
         else
            M.lua_tbl_to_fennel(v, indent + 2)
         end
      else
         if type(v) == "string" then
            print('"' .. v .. '"')
         else
            print(tostring(v))
         end
      end
   end
   for _ = 0,indent do
      io.write(" ")
   end
   io.write("}")
   print()
end

return M
