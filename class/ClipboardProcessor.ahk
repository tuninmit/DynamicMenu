#Requires AutoHotkey v2.0

class ClipboardProcessor {

    static memory := Map()

    static __New() {
        OnClipboardChange(ClipboardProcessor.onClipChanged)
    }

    static onClipChanged := ObjBindMethod(ClipboardProcessor, "clipChanged")
    static clipChanged(dataType) {
        ;data không phải dạng text
        if (dataType != 1){
            return
        }
    
        try{
            this.collect('serialNumber', '^(VNPT|ALCL|DSNW|ZTEG)[\w]{8}$')


        } catch Error as e {
            MsgBox e.Message, 'ClipboardProcessor'
        }
    }

    static collect(key, regex){
        raw := A_Clipboard

        if(RegExMatch(raw, regex) != 0){
            this.memory.Set(key, raw)
            this.flashToolTip(raw)
        }
    }

    static flashToolTip(text){
        ToolTip(text)
        SetTimer(ToolTip, -3000)
    }


}

