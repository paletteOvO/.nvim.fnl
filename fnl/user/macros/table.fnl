(lambda merge! [a ...]
   (let [r a]
      (each [_ t (ipairs (list ...))]
         (each [k v (pairs t)]
            (tset r k v)
         )
      )
      r
   )
)

{ : merge! }
