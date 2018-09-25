#Tested on PS Version 5

#Start Session on \\ServerName\Folder
set-location \\ServerName\Folder

#Format the list
Get-location | Format-List

#Get permissions for folder and format
Get-Acl \\ServerName\Folder | Format-List accesstostring

#Get current date and time
Get-Date -Format g

#Screenshot the powershell session and desktop for additional proof
#############################################################################
# Capturing a screenshot
#############################################################################
$File = "C:\temp\MyFancyScreenshot.jpg"
Add-Type -AssemblyName System.Windows.Forms
Add-type -AssemblyName System.Drawing
# Gather Screen resolution information
$Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
$Width = $Screen.Width
$Height = $Screen.Height
$Left = $Screen.Left
$Top = $Screen.Top
# Create bitmap using the top-left and bottom-right bounds
$bitmap = New-Object System.Drawing.Bitmap $Width, $Height
# Create Graphics object
$graphic = [System.Drawing.Graphics]::FromImage($bitmap)
# Capture screen
$graphic.CopyFromScreen($Left, $Top, 0, 0, $bitmap.Size)
# Save to file
$bitmap.Save($File) 
Write-Output "Screenshot saved to:"
Write-Output $File
#############################################################################




    # Send text to my phone and Email to users, include attachment and email template.

    $properties = @{
    to         = '##########@txt.att.net','Username@domain.com'
    from       = 'ITgroup@domain.com'
    body       = "Hello Username,

Attached are the screen shot(s) of who has access to folder located at \\ServerName\Folder.
Please reply to all with your approval/rejection to the recertification.
"
    subject    = "Monthly FolderName Recertification Test"
    Attachment = $File
    smtpserver = 'smtp.domain.com'
    }
    
    Send-MailMessage @properties





#Prevent powershell from closing before screenshot is taken and press enter to exit.
Read-Host -Prompt “Press Enter to exit”
