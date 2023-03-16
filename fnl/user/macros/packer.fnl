(local { : require-as! } (require :user.macros.require))
(local { : merge! } (require :user.macros.table))

(lambda use! [name ?opts]
   (let [o# (if (= ?opts nil) {} ?opts) ]
     `(use ,(merge! o# [ name ]))
   )
)

(lambda use-rocks! [name ?opts]
   (let [o# (if (= ?opts nil) {} ?opts)]
     `(use_rocks ,(merge! o# [ name ]))
   )
)

(lambda setup! [name]
   `(lambda [] 
      (vim.schedule 
         (lambda []
            (_G.logger:info ,(.. name " setup"))
            (local (status_ok# _#) (xpcall 
               (lambda [] (require ,(.. :user.setup. name)))
               (lambda [err#] 
                 (_G.logger:error err#)
               )
            ))
            (if status_ok#
               (_G.logger:info ,(.. name " loaded"))
               (_G.logger:error ,(.. name " failed"))
            )
         )
      )
   )
)

(lambda lite-setup! [name opt]
   `(lambda [] 
      (vim.schedule 
         (lambda []
            (_G.logger:info ,(.. name " setup"))
            (local (status_ok# _#) (xpcall 
               (lambda [] 
                  (let [mod# (require ,name)] 
                     (mod#.setup opt)))
               (lambda [err#] 
                 (_G.logger:error err#)
               )
            ))
            (if status_ok#
               (_G.logger:info ,(.. name " loaded"))
               (_G.logger:error ,(.. name " failed"))
            )
         )
      )
   )
)

{ : use!
  : use-rocks!
  : setup!
  : lite-setup!}

