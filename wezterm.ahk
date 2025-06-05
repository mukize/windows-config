#SingleInstance Force
#WinActivateForce

wezClass := "ahk_class org.wezfurlong.wezterm"

;;;;; quake style ;;;;;
^`::
{
  switch
  {
    case WinActive(wezClass):
      WinHide ;
      SetTitleMatchMode "RegEx"
      ids := WinGetList(,, "i)(^Program Manager$)|(^$)|(\\RainMeter\\Skins\\)")
      if ids.Length > 0 {
        WinActivate ids[1]
      }
    case not WinExist(wezClass):
        try {
          WinShow wezClass
          WinActivate wezClass
        } catch TargetError as err {
          Run "wezterm-gui"
        }
    default:
      WinActivate wezClass
  }
}

;;;;; Center wezterm ;;;;;
!+Enter:: {
    ; if not WinActive(wezClass) {
    ;   return
    ; }
    WinRestore "A"
    Width := A_ScreenWidth * .9
    Height := A_ScreenHeight * .85
    WinMove (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2), Width, Height, "A"
}
