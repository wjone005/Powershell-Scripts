#Run with AutoSys Job Scheduling tool CA Workload Automation AE 


#Declare variables
param (
    $localPath = "c:\Folder\",
    $remotePath = "/Folder/",
    $backupPath = "C:\Folder\"
)

# Copy file from server and place it in C drive subfolder with a new name.
Copy-Item -Path \\ServerName\Folder\File.csv -Destination C:\Folder\NewFileName.csv
 
try
{
    # Load WinSCP .NET assembly
    Add-Type -Path 'C:\Program Files (x86)\WinSCP\WinSCPnet.dll'

    # Read XML configuration file for encrypted credentials
[xml]$config = Get-Content "C:\Folder\config.xml"
 
 
    # Setup session options
    $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
        Protocol = [WinSCP.Protocol]::Sftp
        HostName = ""
        UserName = $config.Configuration.UserName
        SecurePassword = ConvertTo-SecureString $config.Configuration.Password
        SshHostKeyFingerprint = ""
    }
 
    $session = New-Object WinSCP.Session
 
    try
    {
        # Connect
        $session.Open($sessionOptions)
 
        # Upload files, collect results
        $transferResult = $session.PutFiles($localPath, $remotePath)
 
        # Iterate over every transfer
        foreach ($transfer in $transferResult.Transfers)
        {
            # Success or error?
            if ($transfer.Error -eq $Null)
            {
                Write-Host "Upload of $($transfer.FileName) succeeded, moving to backup"
                # Upload succeeded, move source file to backup
                Move-Item $transfer.FileName $backupPath

    # Send text message to my phone and email to Jira to create a ticket.
    # Sender will be audit officer and will Jira will assign them as a reporter.
    $properties = @{
    to         = '##########@txt.att.net','test@JiraDomainName.com'
    from       = 'AuditOfficer@company.com'
    body       = "Upload of $($transfer.FileName) succeeded, moving to backup"
    subject    = "Weekly Task Name Week of $(get-date -f MM-dd-yy)"
    attachment = "C:\Backup\NewFileName.CSV"
    smtpserver = 'smtp.name.com'
    }

Send-MailMessage @properties

            }
            else
            {
                Write-Host "Upload of $($transfer.FileName) failed: $($transfer.Error.Message)"
    #Email me if task fails and reason why.
    $properties = @{
    to         = '##########@txt.att.net','test@JiraDomainName.com'
    from       = AuditOfficer@company.com'
    body       = "Upload of $($transfer.FileName) failed: $($transfer.Error.Message)"
    subject    = "Task Name Failed"
    smtpserver = 'smtp.name.com'
    }

Send-MailMessage @properties

            }
        }
    }
    finally
    {
        # Disconnect, clean up
        $session.Dispose()
    }
 
    exit 0
}
catch
{
    Write-Host "Error: $($_.Exception.Message)"
    exit 1
}


