#190702

Write-Host "using .NET Class"
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32API {
[DllImport("user32.dll", CharSet = CharSet.Auto)]
public static extern IntPtr PostMessage(int hWnd, UInt32 Msg, int wParam, int lParam);
}
"@

$hwnd = Get-Process javaw | Where-Object {$_.MainWindowTitle -match "Minecraft"} | Select-Object Index,Id,Name,MainWindowTitle,MainWindowHandle
$hwnd

if ($hwnd.Connt -eq 0)
{
    Write-Error "Error: Minecraft Process not found."
    return
} elseif ($hwnd.Count -ge 2)
{
    $ProcessId = Read-Host "Type Id"
    $hwnd = Get-Process javaw | Where-Object {$_.Id -eq $ProcessId} | Select-Object Index,Id,Name,MainWindowTitle,MainWindowHandle
    if ($hwnd.Connt -eq 0)
    {
        Write-Error "Error: No such process."
        return
    }
}

Write-Host "Starting after 10 sec..."
Start-Sleep -Seconds 10

#WM_RBUTTONDOWN
[Win32API]::PostMessage($hwnd.MainWindowHandle, 0x0204, 1, 0)
Start-Sleep -MilliSeconds 100
#WM_LBUTTONDOWN
[Win32API]::PostMessage($hwnd.MainWindowHandle, 0x0201, 1, 0)
Read-Host "Processing...[Enter: Stop]"

#WM_RBUTTONUP
[Win32API]::PostMessage($hwnd.MainWindowHandle, 0x0205, 0, 0)
#WM_LBUTTONUP
[Win32API]::PostMessage($hwnd.MainWindowHandle, 0x0202, 0, 0)