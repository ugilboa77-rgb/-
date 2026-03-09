Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip = [System.IO.Compression.ZipFile]::OpenRead('c:\Users\User\challenge\סיכום משחק _חי או לא חי_.xlsx')
$entry = $zip.Entries | Where-Object { $_.Name -eq 'sharedStrings.xml' }
if ($entry) {
    $reader = New-Object System.IO.StreamReader($entry.Open())
    $content = $reader.ReadToEnd()
    $reader.Close()
    Write-Host $content
}
$entry2 = $zip.Entries | Where-Object { $_.FullName -eq 'xl/worksheets/sheet1.xml' }
if ($entry2) {
    $reader2 = New-Object System.IO.StreamReader($entry2.Open())
    $content2 = $reader2.ReadToEnd()
    $reader2.Close()
    Write-Host "=== SHEET1 ==="
    Write-Host $content2
}
$zip.Dispose()
