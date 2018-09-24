$Error.Clear()

function Fetch-PDF {

# Insert URL, clear the session and then convert web page to pdf.

$Uri = "http://website.net/ReportServer/Pages/ReportViewer.aspx?/ReportSummary&rs:ClearSession=true&rs:format=pdf"

# Output the file into your directory of choice and name the file Template Name Summary(Current Date).

$Outputfile = "G:\FilePath\$(get-date -f yyyy)\Template Name Summary_$(get-date -f yyyyMMdd).pdf" 

# Declare -Uri a URL, Outputfile a file type and -UseDefaultCredentials will use current signed on user credentials. 

Invoke-RestMethod -Uri $Uri -OutFile $Outputfile -UseDefaultCredentials -TimeoutSec 60

}

if($Error.count -gt 0){

    Start-Sleep -seconds 5

function Email-Users {


    # Send text to me and Email IT group, along with the reason of the error. Then run the script again.

    $properties = @{
    to         = '##########@txt.att.net','ITGroup@domain.com'
    from       = 'ITGroup@domain.com'
    body       = "Script will run again. The error message was $Error"
    subject    = "Template Name Summary Script Failed"
    smtpserver = 'smtp.domain.com'
    }
    
    Send-MailMessage @properties

    }

    }

    # Attempt to fetch PDF from website reporter.
    
    # Insert URL, clear the session and then convert web page to pdf.

$Uri = "http://website.net/ReportServer/Pages/ReportViewer.aspx?/ReportSummary&rs:ClearSession=true&rs:format=pdf"

# Output the file into your directory of choice and name the file Template Name Summary(Current Date).

$Outputfile = "G:\FilePath\$(get-date -f yyyy)\Template Name Summary_$(get-date -f yyyyMMdd).pdf" 

# Declare -Uri a URL, Outputfile a file type and -UseDefaultCredentials will use current signed on user credentials. 

Invoke-RestMethod -Uri $Uri -OutFile $Outputfile -UseDefaultCredentials -TimeoutSec 60

if (!$error) {

 $properties = @{
    to         = '##########@txt.att.net','ITGroup@domain.com'
    from       = 'ITGroup@domain.com'
    body       = "No Error Occured"
    subject    = "Template Name Summary Script Completed"
    smtpserver = 'smtp.domain.com'
    }

Send-MailMessage @properties

}
