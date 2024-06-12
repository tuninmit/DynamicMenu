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
            if ((item.winTitle = '') || WinActive(item.winTitle))
                displayItems.Push(item)
        }
    
        ; Creates the menu:
        MyMenu := Menu()
        MyMenu.customHandler := Map()
        For i, item in displayItems{


            if (item.hasChild){
                MyMenu.Add(item.text, item.toMenu(defaultHandler))
            }else{
                if(item.isBreakNewColumn){
                    MyMenu.Add(item.text, defaultHandler, 'BarBreak')
                }else{
                    MyMenu.Add(item.text, defaultHandler)
                }
                
                MyMenu.customHandler.Set(item.text, item.handler)
                MyMenu.winTitle := item.winTitle
                if(item.isEnable = false){
                    MyMenu.Disable(item.text)
                } 
            }
        }
        
        MyMenu.Show()
    }
}

defaultHandler(itemName, itemPos, menuAhk){
    handler := menuAhk.customHandler.Get(itemName)
    patchs := StrSplit(handler, MenuProccessor.PARAM_DELIMITER)
    function := patchs[1]

    if (menuAhk.winTitle != '')
        WinActivate(menuAhk.winTitle)
    else
        Sleep(100)

    
    switch patchs.Length {
        case 1:
            dummyFunction := %function%.Bind()
        case 2:
            dummyFunction := %function%.Bind(patchs[2])
        case 3:
            dummyFunction := %function%.Bind(patchs[2], patchs[3])
        case 4:
            dummyFunction := %function%.Bind(patchs[2], patchs[3], patchs[4])
        default:
            dummyFunction := ObjBindMethod(ClipboardProcessor, 'flashToolTip', function)
    }
    dummyFunction()
}






