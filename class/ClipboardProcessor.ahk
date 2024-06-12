#Requires AutoHotkey v2.0

/**
 * Whenever clipboard change, this class examine if new clipboard match any memory pattern.
 * If match, this class will save new clipboard value to specific memory slot, then you can recall it later through DynamicMenu
 * 
 */
class ClipboardProcessor {

    static memories := Map()
    static memoryMenuItem := unset

    static __New() {
        OnClipboardChange(ClipboardProcessor.onClipChanged)

        this.memoryMenuItem := ItemMenu.parseFromString("Memory||.", false)
        this.memoryMenuItem.childs := Array()
    }

    static onClipChanged := ObjBindMethod(ClipboardProcessor, "clipChanged")
    static clipChanged(dataType) {
        if (dataType != 1) ;ignore non-text data
            return
        
        ;---DEFINE MEMORY PATTERN HERE---
        ; this.collect('something', 'someRegexPattern')
        this.collect('serialNumber', '^(VNPT|ALCL|DSNW|ZTEG)[\w]{8}$')
    }


    static collect(memoryKey, regex){
        raw := A_Clipboard

        if(RegExMatch(raw, regex) != 0){
            this.memories.Set(memoryKey, raw)
            this.flashToolTip(raw)
            this.buildChildItemMenu()
        }
    }

    ;a tooltip indicate that a memory collected
    static flashToolTip(text){
        ToolTip(text)
        SetTimer(ToolTip, -3000)
    }


    ;convert memories to list of ItemMenu.
    ;must called each time this.memories changed
    static buildChildItemMenu(){
        this.memoryMenuItem.isEnable := (this.memories.Count > 0)

        childs := Array()
        for mem, value in this.memories {
            itemMenu1 := ItemMenu.parseFromString(mem . '||Send###' . value)
            itemMenu1.text := mem . ' - ' . value
            childs.Push(itemMenu1)
        }

        this.memoryMenuItem.setChild(childs)
    }



}

