$zoneName = "domain.com"
$outputFile = "C:\Users\username\...\zonendaten.txt"

# Nameserver für die Zone ermitteln
$nsServers = (nslookup -type=ns $zoneName | Select-String "nameserver" | ForEach-Object { $_.Line.Split()[-1] })

# Abfrage der DNS-Einträge von einem der Nameserver
$zoneRecords = foreach ($ns in $nsServers) {
    nslookup -type=any $zoneName $ns
}

# Die Einträge in eine Datei schreiben
$zoneRecords | Out-File -FilePath $outputFile

# Ausgabe, um zu bestätigen, dass die Datei erstellt wurde
Write-Host "Zonendaten wurden erfolgreich nach $outputFile exportiert."
