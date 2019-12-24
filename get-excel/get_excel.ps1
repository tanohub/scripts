# Specify the path to the Excel file and the WorkSheet Name
$FilePath = "C:\temp\spla.xlsx"
$SheetName = "Foglio1"

# Create an Object Excel.Application using Com interface
$objExcel = New-Object -ComObject Excel.Application
# Disable the 'visible' property so the document won't open in excel
$objExcel.Visible = $false

# Open the Excel file and save it in $WorkBook
$WorkBook = $objExcel.Workbooks.Open($FilePath)
$WorkSheet = $WorkBook.sheets.item($SheetName)
$rowMax = ($WorkSheet.UsedRange.Rows).count

# Define Variables 
# Expire in xx days
$expire_in = 10

# Expired Server counter
$expired_srv = 0

for ($row = 2; $row -le $rowmax ; $row++)
{
	$customer = $worksheet.Cells.Item($row,3).text
    $expire_on = $worksheet.Cells.Item($row,4).text
	$server = $worksheet.Cells.Item($row,2).text
	$expire_data = [datetime]::ParseExact($expire_on, "dd/MM/yyyy", $null)
	$current_data = (Get-Date).toshortdatestring()
	$warranty_days =(new-timespan -start $current_data -end $expire_data).days
	If ($warranty_days -lt $expire_in )
		{
			write-host 'Warranty expires in ' $warranty_days ' days ( ' $expire_on ' ) for Customer:' $customer ' on Server:' $server 
			$expired_srv++
		}
}

if ($expired_srv -gt 0)
	{
	write-host 'Server out of warranty: ' $expired_srv
	}
	else
	{
	write-host 'No Warranty expirations in ' $expire_in ' days .'
	}

$WorkBook.Close();
$objExcel.quit();

start-sleep -s 2

$kill = 'taskkill /im excel.exe /f'
iex $kill