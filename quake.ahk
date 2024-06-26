#SingleInstance Force
#WinActivateForce
^`::
{
  wez := "ahk_class org.wezfurlong.wezterm"
  switch
  {
    case WinActive(wez):
      WinHide ;
      SetTitleMatchMode "RegEx"
      ids := WinGetList(,, "i)(^Program Manager$)|(^$)|(\\RainMeter\\Skins\\)")
      if ids.Length > 0 {
        WinActivate ids[1]
      }
    case not WinExist(wez):
        try {
          WinShow wez
          WinActivate wez
        } catch TargetError as err {
          Run "wezterm-gui"
        }
    default:
      WinActivate wez
  }
}
