#SingleInstance Ignore
SetWorkingDir A_ScriptDir
Persistent

path:=IniRead("setting.ini", "dir", "path", "")
hotkeys:=IniRead("setting.ini", "hotkey", "key", "!q")
fullscreen_enable:=IniRead("setting.ini", "hotkey", "fullscreen", "0")
uiType:=IniRead("setting.ini", "ui", "type", "2")

#include isFullScreen.ahk
#include ahko_setup_gui.ahk

customTrayMenu:={valid:true}
customTrayMenu.menu:=[]
customTrayMenu.menu.push({name:"Setup",func:ahko_setup_show})

setupWatchFolder(*)
{
	newpath:=RegExReplace(DirSelect(,0), "\\$")
	if(newpath!="") {
		IniWrite("path=" newpath,"setting.ini", "dir")
		Reload
	}
}

if(!DirExist(path)) {
	ahko_setup_show()
	Return
}

TrayTip "ahko start at " path, "ahko", 0x14

ahko := []
ahko_init(&ahko, path)
{
	Loop files path "\*", "FD"
	{
		ahko.Push({name:filenameWithoutExt(A_LoopFileName),attrib:A_LoopFileAttrib,path:A_LoopFileFullPath,sub:[],icon:""})
		if(InStr(A_LoopFileAttrib,"D")){
			local icon_map:=Map()
			local target_count:=0
			Loop files A_LoopFileFullPath "\*", "FD"
			{
				if(A_LoopFileName == "_icon.png") {
					ahko[-1].icon := A_LoopFileFullPath
					Continue
				}
				if(RegExMatch(A_LoopFileName,"(.+)\.png$",&iconFileName)) {
					icon_map.set(iconFileName[1], A_LoopFileFullPath)
					Continue
				}
				if(target_count >= 16){
					Continue
				}
				ahko[-1].sub.Push({name:filenameWithoutExt(A_LoopFileName),attrib:A_LoopFileAttrib,path:A_LoopFileFullPath,icon:""})
				target_count+=1
			}
			for k,v in ahko[-1].sub
			{
				if(icon_map.Has(v.name)){
					v.icon := icon_map.Get(v.name)
				}
			}
		}
		if(A_Index >= 16){
			Break
		}
	}
}
ahko_init(&ahko, path)
filenameWithoutExt(name)
{
	SplitPath(name,,,,&outname)
	Return outname
}
fileGethIcon(file)
{
	fileinfo := Buffer(fisize := A_PtrSize + 688)
	; Get the file's icon.
    if DllCall("shell32\SHGetFileInfoW", "WStr", file
        , "UInt", 0, "Ptr", fileinfo, "UInt", fisize, "UInt", 0x100)
    {
        hicon := NumGet(fileinfo, 0, "Ptr")
		Return "HICON:" hicon
    }
	Return
}

isNotFullScreen(*)
{
	Return not isFullScreen()
}

#Include ahko_ui.ahk
ahko_ui_init()
if(fullscreen_enable)
{
	Hotkey hotkeys, ahko_show, "On"
} else {
	Hotif isNotFullScreen
	Hotkey hotkeys, ahko_show, "On"
	Hotif
}


