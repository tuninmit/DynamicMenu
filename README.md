# DynamicMenu
Customizable context **Menu** based on activating window. Items to be shown are pre-defined by user.

# Features
* Allows you to define snippets of text that can be recall in particular application (based on window tittle)
* Save clipboard if it matches any regex you setup in ```memoryPattern.txt```. Recall from **Memory** option in **Menu**

# Installation
1. Install AutoHotKey from [https://www.autohotkey.com](https://www.autohotkey.com) (v2 is required)
2. Double click `DynamicMenu.ahk` to run script.
3. (Optional) Put a SHORTCUT of `DynamicMenu.ahk` in startup folder, then script will auto run on window startup

   Just in case, in order to open startup folder quickly, press `Window + R`, then enter `shell:startup`

# Usage
Trigger **Menu** by holding middle mouse for a short time, then select an item to send text

## Customize script
Save file after changed, then reload the script
* `myCommand.txt`
  
  ```
  Window tittle contains this text
      Snippets of text that are so long to remember or we are too lazy to type manually 1
      Snippets of text have many line\nLine 1\nLine 2`nFinal line

  Notepad
      Today I got emootional damage, cannot go to work in {{number}} day
  ```
   Here we have `{{number}}` placeholder, it will be replaced if **Memory** had value in slot `number`

* `memoryPattern.txt`
   ```
   keyName=Regex
   number=^\d+(\.)?\d*$
   contain_cat_or_dog=cat|dog
   ```

