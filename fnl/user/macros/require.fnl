(lambda require-as! [name module]
   `(local (_# ,name) (xpcall 
      (lambda [] (require ,module))
      (lambda [err#] 
         (_G.logger:error err#)
      )
   ))
)

(lambda let-require! [[name module] ...]
   `(let
      [
         (status_ok# ,name) (xpcall 
            (lambda [] (require ,module))
            (lambda [err#] 
               (_G.logger:error err#)
            )
         )
      ]
      (if status_ok# (do ,...))
   )
)

{
 : require-as!
 : let-require!
}
