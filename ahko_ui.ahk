

ahko_show(*)
{
	if(uiType=="2") {
		ahko_gridview.Show()
		if(!winwait("ahk_id " ahko_gridview.grid_gui.hwnd,,3)){
			Return
		}
		Try{
			WinActivate("ahk_id " ahko_gridview.grid_gui.hwnd)
		}
	}
}

ahko_ui_init(*)
{
	global
	if(uiType=="2") {
		ahko_gridview := ahko_gridview_class()
		ahko_gridview.showat := showat
	}
}

; icon support format: ICO, CUR, ANI, EXE, DLL, CPL, SCR
#Include ahko_gridview_ui.ahk
