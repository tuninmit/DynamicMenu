#Requires AutoHotkey v2.0
#Include ./ItemMenu.ahk

class SimpleParser{
    
    static fileLocation := "myCommand.txt"

    static items := Array()

    static __New() {
        this.parseFile()
    }

    static parseFile(){
        Loop read, this.fileLocation {
            this.parseLine(A_LoopReadLine)
        }else
            MsgBox(this.fileLocation . " not found.")
    }

    static currentWinTitle := ""
    static emptyOption := " "
    static parseLine(line){
        if(StrLen(line) = 0)
            return

        ;save line as window title
        if (InStr(line, "    ") = 0){
            this.currentWinTitle := line
            this.emptyOption := " "
            return
        }

        ;or else that line is an ItemMenu
        line := LTrim(line)
        line := StrReplace(line, '\n', CHR(10))
        line := StrReplace(line, '``n', CHR(10))
        if(StrLen(line) = 0){
            line := this.emptyOption                    ;indent-empty line in myCommand.txt considered as empty menu option 
            this.emptyOption := this.emptyOption . " "  ;empty options need to be different from each other
        } 
        item := ItemMenu(line, this.currentWinTitle, "SendText###" . line)
        this.items.Push(item)
    }

}


