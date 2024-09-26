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
            Loop parse, A_LoopReadLine {
                this.parseLine(A_LoopReadLine)
            }
        }else
            MsgBox(this.fileLocation . " not found.")
    }

    static currentWinTitle := ""
    static parseLine(line){
        ;save line as window title
        if (InStr(line, "    ") = 0){
            this.currentWinTitle := line
            return
        }

        ;or else that line is an ItemMenu
        line := LTrim(line)
        if(StrLen(line) = 0){
            line := " " ;indent-empty line in myCommand.txt considered as empty menu option 
        } 
        item := ItemMenu(line, this.currentWinTitle, "SendText###" . line)
        this.items.Push(item)
    }

}


