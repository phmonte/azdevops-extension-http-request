[string]$urlToRequest = Get-VstsInput -Name urlToRequest
[int]$timeOutRequest = Get-VstsInput -Name timeOutRequest
[int]$interval = Get-VstsInput -Name interval


$request = try { (Invoke-WebRequest -uri $urlBase -UseBasicParsing) } catch {}

$limit = (Get-Date).AddMinutes($timeOutRequest)

while ((Get-Date) -le $limit) {
	
	Write-Host (Get-Date)
	Write-Host $limit
	
	if($request.StatusCode -eq 200){
		Write-Host 'Fim'
		Break
	}
	
    $request = try { (Invoke-WebRequest -uri $urlToRequest -UseBasicParsing) } catch {}
    Start-Sleep -Seconds $interval
}

If ($request.StatusCode -eq 200) {
	Write-Host Smoke Test Sucess
}else{
	Throw "Http request error"
	Write-Host #vso[task.complete result=Failed;]Failed
}