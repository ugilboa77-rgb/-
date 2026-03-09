Add-Type -AssemblyName System.IO.Compression.FileSystem
$dir = 'c:\Users\User\challenge'
$files = Get-ChildItem $dir -Filter "*.xlsx"
foreach ($f in $files) {
    Write-Host "Found: $($f.FullName)"
    $zip = [System.IO.Compression.ZipFile]::OpenRead($f.FullName)
    $entry = $zip.Entries | Where-Object { $_.Name -eq 'sharedStrings.xml' }
    if ($entry) {
        $stream = $entry.Open()
        $reader = New-Object System.IO.StreamReader($stream, [System.Text.Encoding]::UTF8)
        $content = $reader.ReadToEnd()
        $reader.Close()
        Write-Host $content
    }
    $entry2 = $zip.Entries | Where-Object { $_.FullName -eq 'xl/worksheets/sheet1.xml' }
    if ($entry2) {
        $stream2 = $entry2.Open()
        $reader2 = New-Object System.IO.StreamReader($stream2, [System.Text.Encoding]::UTF8)
        $content2 = $reader2.ReadToEnd()
        $reader2.Close()
        Write-Host "=== SHEET ==="
        Write-Host $content2
    }
    $zip.Dispose()
}
