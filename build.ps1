$root = "t"
mkdir "../$root" -Force | Out-Null

$indexHtml = "../$root/index.html"

"<!-- auto generated -->" | Out-File -FilePath $indexHtml -Encoding utf8BOM
"<a href='/$root/wtp'>WTP</a><br />" | Out-File -FilePath $indexHtml -Encoding utf8BOM -Append

Get-ChildItem -Directory 
| ForEach-Object {    
    $name = $_.Name
    
    Write-Host "Generating for $name"

    "<a href='/$root/$name'>$name</a><br />" | Out-File -FilePath $indexHtml -Encoding utf8BOM -Append
    $thisIndexHtml = "../$root/$name/index.html"
    mkdir "../$root/$name" -Force | Out-Null

    "<!-- auto generated -->" | Out-File -FilePath $thisIndexHtml -Encoding utf8BOM
    "<ul>" | Out-File -FilePath $thisIndexHtml -Encoding utf8BOM -Append
    Get-ChildItem $name
    | ForEach-Object {
        $fileName = $_.Name
        "<li><a href='/$root/$name/$fileName'>$fileName</a></li>" | Out-File -FilePath $thisIndexHtml -Encoding utf8BOM -Append        
        Get-Content $_.FullName | Out-File -FilePath "../$root/$name/$($_.Name)" -Encoding utf8BOM
    }
    "</ul>" | Out-File -FilePath $thisIndexHtml -Encoding utf8BOM -Append
}