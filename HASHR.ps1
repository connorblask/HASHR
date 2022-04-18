#HASHR
#Written by Connor Blaszkiewicz

#Insert your own API key for VirusTotal below.
$yekIPA = ""


Write-Host "Welcome to HASHR" -ForegroundColor Yellow
$fileName = Read-Host -Prompt "Enter a file name within your current directory you would like to hash: "
$filePath = "./$fileName"

Get-FileHash $filePath -Algorithm MACTripleDES | Format-List
Get-FileHash $filePath -Algorithm MD5 | Format-List
Get-FileHash $filePath -Algorithm RIPEMD160 | Format-List
Get-FileHash $filePath -Algorithm SHA1 | Format-List
Get-FileHash $filePath -Algorithm SHA256 | Format-List
Get-FileHash $filePath -Algorithm SHA384 | Format-List
Get-FileHash $filePath -Algorithm SHA512 | Format-List

$virusTotalDecision = Read-Host -Prompt "Would you like to check this hash with VirusTotal? [y/n]"

if ($virusTotalDecision -like 'y'){

    $hashType = Read-Host -Prompt "What hash would you like to upload? SHA1 [1], SHA256 [2], or MD5 [3]"
    if($hashType -eq 1){
        $checksum = (Get-FileHash $filePath -Algorithm SHA1).Hash
    }elseif($hashType -eq 2){
        $checksum = (Get-FileHash $filePath -Algorithm SHA256).Hash
    }elseif($hashType -eq 3){
        $checksum = (Get-FileHash $filePath -Algorithm MD5).Hash
    }else{
        echo "Please restart the script and choose options '1' '2' or '3'"
    }

    $B = @{apikey = $yekIPA; resource = $checksum;}
    $R = Invoke-RestMethod -Method GET -Uri 'https://www.virustotal.com/vtapi/v2/file/report' -Body $B
    $R   
    echo "Thank you for using HASHR!"
        
}else{
echo "Thank you for using HASHR!"
}

