 function Export-Table-CSV
 {
 param([string]$file_location, [string]$selectdata, [string]$db_name)

  $a ="Invoke-Sqlcmd -QueryTimeout 0 -Database " + $db_name + " -Query """
  $b = """ | Export-Csv """
  $c = """ -Delimiter "","" -NoTypeInformation"

  $sql_text = $a + $selectdata + $b + $file_location + $c
  
  # Execute and Write a log
  $result = $(Get-Date -Format "MM/dd/yyyy HH:mm").ToString() + " Processing..." + $file_location + " in " + $($(Measure-Command { Invoke-Expression -ErrorAction SilentlyContinue $sql_text}).Minutes).ToString() + " mins" | out-file -FilePath "C:\Temp\SSRS\log.txt" -Append
  
  write-host $result 

}
 
 Export-Table-CSV  -file_location "C:\Temp\SSRS\output.csv" -selectdata "SELECT 1" -db_name "DB"
