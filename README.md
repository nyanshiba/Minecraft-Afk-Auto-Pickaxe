<!--190702-->

<!-- TOC -->

- [概要](#概要)
- [使い方](#使い方)

<!-- /TOC -->

## 概要

鉱石(Ore)やコンクリート(Concrete)の製造時に、マウスをビニールテープで固定するのは精神衛生上よろしくないのでつくった。  
一般的なマクロとは仕様が異なり、Minecraftの画面※1に対し左右クリックを送っているので、画面外での誤爆の心配は無い。  
要するにバックグラウンドウィンドウにも対応してる。Minecraftが対応してないけど。  

※1 javaw且つMainWindowTitleに"Minecraft"が含まれるプロセスのMainWindowHandle  

## 使い方

1. Clone for Downloadsからこのスクリプトをダウンロード。  

2. (管理者権限が不要な)好きな場所に置く。例: `C:\bin\Minecraft-Afk-Auto-Pickaxe\AutoPickaxe.ps1`  
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy RemoteSigned -File .\VultrStartup.ps1

3. Windows PowerShell(powershell.exe) または Windows上のPowerShell Core(pwsh.exe) を起動する。  

- スタートメニュー右クリック -> Windows PowerShell
- `Win` - `S` -> `powershell`, `pwsh` -> Enter
- `Win` - `R` -> `powershell`, `pwsh` -> Enter

4. スクリプトの実行を許可する(されていない場合)。  

```powershell
#実行ポリシーを確認
Get-ExecutionPolicy

#実行ポリシーを変更
Set-ExecutionPolicy RemoteSigned
```

5. スクリプトをテキストエディタで開き、設定を用途に合わせて変更する  
下記は畑植え放置の例

```powershell
#ユーザ設定
$Settings =
@{
    #右押下
    RightButtonDown = $True
    #左押下
    LeftButtonDown = $False
    #ウィンドウを小さくするか
    SmallWindow = $False
}
```

6. スクリプトを実行する。  

```powershell
#実行
.\AutoPickaxe.ps1

#powershell外から実行
powershell .\AutoPickaxe.ps1
```

7. 10秒以内にMinecraftの画面をアクティブにして、十字を合わせる。  

```
Starting after 10 sec...
Alt-Tab -> Minecraft, Press 'Esc'.
```

8. PowerShellのコンソールに戻り、`Enter`キーでスクリプトを終了する。  

```
Processing...[Enter: Stop]:
```

9. `exit`でPowerShellを終了する。  
