#Requires AutoHotkey v2.0


class ItemMenu{
    static SPLIT := '~'
    static SPLIT_ALTERNATIVE := '/\/'   ;if handler uses SPLIT character, write SPLIT_ALTERNATIVE instead. Example: "hays ~ grep needle" need wrote as "hays /\/ grep needle"

    text := ''
    winTitle := ''
    handler := ''

    isBreakNewColumn := false
    isEnable := true

    hasChild := false
    childs := Array()

    __New(text, winTitle, handler) {
        this.text := text
        this.winTitle := winTitle
        this.handler := StrReplace(handler, ItemMenu.SPLIT_ALTERNATIVE, ItemMenu.SPLIT)
    }

    toMenu(defaultHandler){
        MyMenu := Menu()
        MyMenu.customHandler := Map()

        For i, child in this.childs{
            if (child.hasChild){
                MyMenu.Add(child.text, child.toMenu(defaultHandler))
            }else{
                MyMenu.Add(child.text, defaultHandler, child.isBreakNewColumn ? 'BarBreak' : '')
                
                MyMenu.customHandler.Set(child.text, child.handler)
                MyMenu.winTitle := child.winTitle
                if(child.isEnable = false){
                    MyMenu.Disable(child.text)
                } 
            }
        }

        return MyMenu
    }

    setChild(childs){
        this.childs := childs
        this.hasChild := true
    }

    static parseFromString(raw, isEnable := true, isBreakNewColumn := false){
        patchs := StrSplit(raw, ItemMenu.SPLIT)
        try {
            newItem := ItemMenu(patchs[1], patchs[2], patchs[3])
            newItem.isEnable := isEnable
            newItem.isBreakNewColumn := isBreakNewColumn
            return newItem
        } catch Error as e {
            MsgBox e.Message
        }
    }

}



