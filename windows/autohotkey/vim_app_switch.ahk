; for keychron k3
; end & [::Send,{Blind}{Up}
; end & /::Send,{Blind}{Down}
; end & `;::Send,{Blind}{Left}
; end & '::Send,{Blind}{Right}

; HyperSwitch like app switcher keybind
#IfWinActive ahk_class XamlExplorerHostIslandWindow
; for Windows 10
; #IfWinActive ahk_class MultitaskingViewFrame
h::left
j::down
k::up
l::right
#IfWinActive
