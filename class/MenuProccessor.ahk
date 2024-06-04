#Requires AutoHotkey v2.0


class MenuProccessor{

    static MOUSE_DELAY := 10                    ; This is how long the mouse button must be held to cause the menu to appear
    static PARAM_DELIMITER := '###'

    static rootItems := Array()
    static items := Array()

    static mouseCallMenu(){
        iss := this.isMouseClickLongEnough()
        if (iss)
            this.displayItems(this.rootItems)
    }

    static isMouseClickLongEnough(){
        HowLong := 0
        Loop
        {
            HowLong++
            Sleep 10
            if !GetKeyState("MButton", "P")
                Break
        }

        return (HowLong >= this.MOUSE_DELAY)
    }

    static displayItems(newItems){
        this.items := newItems
        this.displayMenu()
    }

    static displayMenu(){
        ; Prepares dynamic menu:

        displayItems := Array()
        For i, item in this.items
        {
            if WinActive(item.winTitle)
                displayItems.Push(item)
        }
    
        ; Creates the menu:
        MyMenu := Menu()
        For i, item in displayItems{


            if (item.hasChild){
                MyMenu.Add(item.text, item.toMenu(defaultHandler))
            }else{
                if(item.isBreakNewColumn){
                    MyMenu.Add(item.text, defaultHandler, 'BarBreak')
                }else{
                    MyMenu.Add(item.text, defaultHandler)
                }
                
                MyMenu.customHandler := item.handler
                MyMenu.winTitle := item.winTitle
                if(item.isEnable = false){
                    MyMenu.Disable(item.text)
                } 
            }
        }
        
        MyMenu.Show()
    }


    ; WinActivate(selectedItem.winTitle)
    ; %selectedItem.handler%()

}

defaultHandler(itemName, itemPos, menuAhk){
    handler := menuAhk.customHandler.Get(itemName)
    patchs := StrSplit(handler, MenuProccessor.PARAM_DELIMITER)
    function := patchs[1]

    WinActivate(menuAhk.winTitle)
    switch function, false {
        case "Send":
            Send(patchs[2])
        default:
            ToolTip('TBD')
    }
}




