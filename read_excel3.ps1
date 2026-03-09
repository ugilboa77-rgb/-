[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
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
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($content)
        [System.IO.File]::WriteAllBytes('c:\Users\User\challenge\shared_strings.xml', $bytes)
        Write-Host "Saved sharedStrings.xml"
    }
    $zip.Dispose()
}
