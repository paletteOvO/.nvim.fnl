(import-macros { : require-as! } :user.macros.require)

(require-as! code_runner "code_runner")

(code_runner.setup {
   :filetype {
      :java "cd $dir && javac $fileName && java $fileNameWithoutExt"
      :python "python -u"
      :typescript "deno run"
      :rust "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
   }
})

