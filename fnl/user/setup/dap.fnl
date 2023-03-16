;; (local dapui (require :dapui))
;;
;; (dapui.setup {
;;    :layout [
;;       {
;;          :elements [
;;             "scopes"
;;             "breakpoints"
;;             "stacks"
;;             "watches"
;;          ]
;;          :size 40
;;          :position :left
;;       }
;;   ]
;; })

(import-macros { : require-as! } :user.macros.require)

(require-as! dap :dap)
(require-as! dapui :dapui)
(require-as! dap-install :dap-install)

(dap-install.setup {})

(dap-install.config "python" {})

(dapui.setup {
              :layout {:elements [
                                  {
                                   :id "scopes"
                                   :size 0.25} ;; Can be float or integer > 1
                                  {:id "breakpoints" :size 0.25}]
                       :size 40
                       :position "right"}})

(vim.fn.sign_define "DapBreakpoint" {:text ""
                                     :texthl "DiagnosticSignError"
                                     :linehl ""
                                     :numhl ""})

(set dap.listeners.after.event_initialized.dapui_config (lambda []
                                                          (dapui.open)))
                                   
(set dap.listeners.before.event_terminated.dapui_config (lambda []
                                                          (dapui.close)))

(set dap.listeners.before.event_exited.dapui_config (lambda [] 
                                                      (dapui.close)))

