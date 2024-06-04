#Requires AutoHotkey v2.0
#SingleInstance
#Include ./class/MenuProccessor.ahk
#Include ./class/ItemMenu.ahk
#Include ./module/Onelink.ahk

; ToolTip Mouse Menu (based on the v1 script by Rajat)
; https://www.autohotkey.com
; This script displays a popup menu in response to briefly holding down
; the middle mouse button.  Select a menu item by left-clicking it.
; Cancel the menu by left-clicking outside of it.  A recent improvement
; is that the contents of the menu can change depending on which type of
; window is active (Notepad and Word are used as examples here).

;___________________________________________
;_____Menu Definitions______________________
; Create Menu Items here.
MenuProccessor.rootItems.Push(OneLinkItem)
;___________________________________________

Exit


;___________________________________________
;_____Menu Sections_________________________

; Create / Edit Menu Sections here.



;___________________________________________
;_____Hotkey Section________________________

~MButton::MenuProccessor.mouseCallMenu()
