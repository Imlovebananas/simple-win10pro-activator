# Windows10_OneClick_Activate.ps1
# WARNING: KMS activation is typically for volume licensing, not retail keys

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ========== CONFIGURATION ==========
# REPLACE WITH YOUR KEY:
$windowsKey = "1AAA1-2BBB2-3CCC3-4DDD4-5EEE5"
$kmsServer = "kms.digiboy.ir"
# ===================================

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Windows 10 Activator"
$form.Size = New-Object System.Drawing.Size(500, 450)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::White
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
$form.MaximizeBox = $false

# Title
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text = "Windows 10 One-Click Activator"
$labelTitle.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$labelTitle.ForeColor = [System.Drawing.Color]::RoyalBlue
$labelTitle.AutoSize = $true
$labelTitle.Location = New-Object System.Drawing.Point(90, 20)
$form.Controls.Add($labelTitle)

# Warning label
$labelWarning = New-Object System.Windows.Forms.Label
$labelWarning.Text = "Note: Using KMS activation with a retail key may not work as expected."
$labelWarning.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$labelWarning.AutoSize = $false
$labelWarning.Size = New-Object System.Drawing.Size(440, 40)
$labelWarning.Location = New-Object System.Drawing.Point(30, 70)
$labelWarning.ForeColor = [System.Drawing.Color]::OrangeRed
$form.Controls.Add($labelWarning)

# Key display
$labelKey = New-Object System.Windows.Forms.Label
$labelKey.Text = "Product Key:"
$labelKey.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$labelKey.AutoSize = $true
$labelKey.Location = New-Object System.Drawing.Point(30, 120)
$form.Controls.Add($labelKey)

$textboxKey = New-Object System.Windows.Forms.TextBox
$textboxKey.Text = $windowsKey
$textboxKey.Location = New-Object System.Drawing.Point(30, 145)
$textboxKey.Size = New-Object System.Drawing.Size(430, 30)
$textboxKey.Font = New-Object System.Drawing.Font("Consolas", 10)
$textboxKey.BackColor = [System.Drawing.Color]::WhiteSmoke
$textboxKey.ReadOnly = $true
$form.Controls.Add($textboxKey)

# KMS Server display
$labelKMS = New-Object System.Windows.Forms.Label
$labelKMS.Text = "KMS Server:"
$labelKMS.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$labelKMS.AutoSize = $true
$labelKMS.Location = New-Object System.Drawing.Point(30, 185)
$form.Controls.Add($labelKMS)

$textboxKMS = New-Object System.Windows.Forms.TextBox
$textboxKMS.Text = $kmsServer
$textboxKMS.Location = New-Object System.Drawing.Point(30, 210)
$textboxKMS.Size = New-Object System.Drawing.Size(430, 30)
$textboxKMS.Font = New-Object System.Drawing.Font("Consolas", 10)
$textboxKMS.BackColor = [System.Drawing.Color]::WhiteSmoke
$textboxKMS.ReadOnly = $true
$form.Controls.Add($textboxKMS)

# Status label
$labelStatus = New-Object System.Windows.Forms.Label
$labelStatus.Text = "Ready to activate..."
$labelStatus.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$labelStatus.AutoSize = $false
$labelStatus.Size = New-Object System.Drawing.Size(440, 60)
$labelStatus.Location = New-Object System.Drawing.Point(30, 250)
$labelStatus.ForeColor = [System.Drawing.Color]::Gray
$form.Controls.Add($labelStatus)

# Activate button
$buttonActivate = New-Object System.Windows.Forms.Button
$buttonActivate.Text = "🔧 Activate Windows"
$buttonActivate.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$buttonActivate.Size = New-Object System.Drawing.Size(200, 50)
$buttonActivate.Location = New-Object System.Drawing.Point(150, 320)
$buttonActivate.BackColor = [System.Drawing.Color]::RoyalBlue
$buttonActivate.ForeColor = [System.Drawing.Color]::White
$buttonActivate.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$form.Controls.Add($buttonActivate)

# Progress bar
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(30, 380)
$progressBar.Size = New-Object System.Drawing.Size(430, 20)
$progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
$progressBar.Visible = $false
$form.Controls.Add($progressBar)

# Activation function
$buttonActivate.Add_Click({
    $buttonActivate.Enabled = $false
    $labelStatus.Text = "Step 1/3: Installing product key..."
    $labelStatus.ForeColor = [System.Drawing.Color]::DarkOrange
    $progressBar.Visible = $true
    
    try {
        # Step 1: Install product key
        $output1 = cmd /c "cscript //B `"$env:SystemRoot\System32\slmgr.vbs`" /ipk $windowsKey" 2>&1
        Start-Sleep -Seconds 2
        
        $labelStatus.Text = "Step 2/3: Setting KMS server..."
        
        # Step 2: Set KMS server
        $output2 = cmd /c "cscript //B `"$env:SystemRoot\System32\slmgr.vbs`" /skms $kmsServer" 2>&1
        Start-Sleep -Seconds 2
        
        $labelStatus.Text = "Step 3/3: Activating Windows..."
        
        # Step 3: Activate
        $output3 = cmd /c "cscript //B `"$env:SystemRoot\System32\slmgr.vbs`" /ato" 2>&1
        Start-Sleep -Seconds 3
        
        # Check activation
        $activationCheck = cmd /c "cscript //B `"$env:SystemRoot\System32\slmgr.vbs`" /xpr" 2>&1
        
        if ($activationCheck -match "activated") {
            $labelStatus.Text = "✅ Windows activated successfully!`nPlease restart your computer."
            $labelStatus.ForeColor = [System.Drawing.Color]::Green
            
            [System.Windows.Forms.MessageBox]::Show(
                "Windows activation complete!`n`nStatus: Activated`nKMS Server: $kmsServer`n`nPlease restart your PC.",
                "Success",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        } else {
            $labelStatus.Text = "⚠️ Activation may not be complete.`nCheck Settings > Update & Security > Activation"
            $labelStatus.ForeColor = [System.Drawing.Color]::Orange
        }
    }
    catch {
        $labelStatus.Text = "❌ Error: $_`nTry running as Administrator."
        $labelStatus.ForeColor = [System.Drawing.Color]::Red
    }
    finally {
        $progressBar.Visible = $false
        $buttonActivate.Enabled = $true
    }
})

# Show form
[void]$form.ShowDialog()