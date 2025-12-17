# Ultra Simple Windows Activator by Sanek

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$windowsKey = "1AAA1-2BBB2-3CCC3-4DDD4-5EEE5"
$kmsServer = "kms.digiboy.ir"

$form = New-Object System.Windows.Forms.Form
$form.Text = "Activator by Sanek"
$form.Size = New-Object System.Drawing.Size(300, 150)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::White
$form.FormBorderStyle = "FixedDialog"

$button = New-Object System.Windows.Forms.Button
$button.Text = "ACTIVATE WINDOWS"
$button.Font = New-Object System.Drawing.Font("Segoe UI", 12, "Bold")
$button.Size = New-Object System.Drawing.Size(200, 60)
$button.Location = New-Object System.Drawing.Point(50, 40)
$button.BackColor = [System.Drawing.Color]::FromArgb(0, 120, 215)
$button.ForeColor = [System.Drawing.Color]::White
$button.FlatStyle = "Flat"

$button.Add_Click({
    $button.Enabled = $false
    $button.Text = "ACTIVATING..."
    
    cscript //B "$env:SystemRoot\System32\slmgr.vbs" /ipk $windowsKey 2>&1 | Out-Null
    cscript //B "$env:SystemRoot\System32\slmgr.vbs" /skms $kmsServer 2>&1 | Out-Null
    cscript //B "$env:SystemRoot\System32\slmgr.vbs" /ato 2>&1 | Out-Null
    
    $button.Text = "DONE! RESTART PC"
    $button.BackColor = [System.Drawing.Color]::Green
})

$form.Controls.Add($button)
[void]$form.ShowDialog()
