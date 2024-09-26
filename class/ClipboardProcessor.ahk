#Requires AutoHotkey v2.0

/**
 * Whenever clipboard change, this class examine if new clipboard match any memory pattern.
 * If match, this class will save new clipboard value to specific memory slot, then you can recall it later through DynamicMenu
 * 
 */
class ClipboardProcessor {

    static memories := Map()
    static patterns := Map()
    static memoryMenuItem := unset

    static __New() {
        OnClipboardChange(ClipboardProcessor.onClipChanged)
        this.parseFileMemoryPattern()

        this.memoryMenuItem := ItemMenu.parseFromString("Memory~~.", false)
        this.memoryMenuItem.childs := Array()
    }

    static onClipChanged := ObjBindMethod(ClipboardProcessor, "clipChanged")
    static clipChanged(dataType) {
        if (dataType != 1) ;ignore non-text data
            return
        
        ;---DEFINE MEMORY PATTERN IN memoryPattern.txt---
        for memoryKey, regex in this.patterns{
            this.collect(memoryKey, regex)
        }
    }


    static collect(memoryKey, regex){
        value := A_Clipboard

        if(RegExMatch(value, regex) != 0){
            this.memories.Set(memoryKey, value)
            this.flashToolTip(value)
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
        for memoryKey, value in this.memories {
            itemMenu1 := ItemMenu.parseFromString(memoryKey . '~~Send###' . value)
            itemMenu1.text := memoryKey . ' - ' . value
            childs.Push(itemMenu1)
        }

        this.memoryMenuItem.setChild(childs)
    }

    static fillParamInto(text){
        if (InStr(text, '{{') = 0)
            return text

        cloneText := text
        for k,v in this.memories {
            target := '{{' . k . '}}'

            if (InStr(text, target) > 0) 
                cloneText := StrReplace(cloneText, target, v)
        }

        ;TODO: Should params, which are not filled yet, replaced with 1 space

        return cloneText
    }

    static fileLocation := "memoryPattern.txt"
    static parseFileMemoryPattern(){
        Loop read, this.fileLocation {
            Loop parse, A_LoopReadLine {
                patchs := StrSplit(A_LoopReadLine, "=", unset, 2)
                this.patterns.Set(patchs[1], patchs[2])
            }
        }else
            MsgBox(this.fileLocation . " not found.")
    }
}

