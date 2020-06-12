#ユーザ設定
$Settings =
@{
    #右押下
    RightButtonDown = $True
    #左押下
    LeftButtonDown = $True
    #ウィンドウを小さくするか
    SmallWindow = $True
}

Write-Host "using .NET Class"
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class SWP {
[DllImport("user32.dll")] 
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
}

public class PMSG {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern IntPtr PostMessage(int hWnd, UInt32 Msg, int wParam, int lParam);
}
"@

$hwnd = Get-Process javaw | Where-Object {$_.MainWindowTitle -match "Minecraft"} | Select-Object Index,Id,Name,MainWindowTitle,MainWindowHandle
$hwnd

if ($hwnd.Count -eq 0)
{
    Write-Error "Error: Minecraft Process not found."
    return
} elseif ($hwnd.Count -ge 2)
{
    $ProcessId = Read-Host "Type Id"
    $hwnd = Get-Process javaw | Where-Object {$_.Id -eq $ProcessId} | Select-Object Index,Id,Name,MainWindowTitle,MainWindowHandle
    if ($hwnd.Count -eq 0)
    {
        Write-Error "Error: No such process."
        return
    }
}

#HWND_TOPMOST, SWP_NOMOVE
#[SWP]::SetWindowPos($hwnd.MainWindowHandle, -1, 0, 0, 0, 0, 0x0002)

#SWP_NOSIZE
if ($Settings.SmallWindow)
{
    [SWP]::SetWindowPos($hwnd.MainWindowHandle, 0, 0, 0, 0, 0, 0)
}

Write-Host "Starting after 10 sec..."
Write-Host "Alt-Tab -> Minecraft, Press 'Esc'."
Start-Sleep -Seconds 10

#WM_RBUTTONDOWN
if ($Settings.RightButtonDown)
{
    [PMSG]::PostMessage($hwnd.MainWindowHandle, 0x0204, 1, 0)
    Start-Sleep -MilliSeconds 100
}
#WM_LBUTTONDOWN
if ($Settings.LeftButtonDown)
{
    [PMSG]::PostMessage($hwnd.MainWindowHandle, 0x0201, 1, 0)
}

Read-Host "Processing...[Enter: Stop]"

#WM_RBUTTONUP
if ($Settings.RightButtonDown)
{
    [PMSG]::PostMessage($hwnd.MainWindowHandle, 0x0205, 0, 0)
}
#WM_LBUTTONUP
if ($Settings.LeftButtonDown)
{
    [PMSG]::PostMessage($hwnd.MainWindowHandle, 0x0202, 0, 0)
}
