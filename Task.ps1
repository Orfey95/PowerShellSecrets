# Class of secrets properties
Class FieldsOfSecrets
{
[int64]$ID;             
[string]$TypeOfSecret;  # Example: site
[string]$Name;          # Example: Sasha
[string]$Password;      # Example: 1234
[string]$URL;           # Example: google.com
[string]$Tags;          # Example: google password secret
[DateTime]$ExpiresTime; # Example: 2019/11/17 00:00:00
}
# Creation of dictionary of secrets
$global:DictionaryOfSecrets = @()
# Get dictionary of secrets from .secret file
$global:DictionaryOfSecrets += (Get-Content "C:\Users\Aleksandr\Desktop\DevOpsLabs\PowerShell_Task\Secrets.secret" | ConvertFrom-Json);
# Clear .secret file
"" | Out-File "C:\Users\Aleksandr\Desktop\DevOpsLabs\PowerShell_Task\Secrets.secret" -NoNewline -Encoding ASCII

# Function to add new secrets
Function Add-Secret ()
{
       # Creating an object from a class
       $Secret = New-Object FieldsOfSecrets;
       # Creating ID for secret
       $Secret.ID = Convert-DateTimeToID;
       # Creating ID for secret
       $Secret.TypeOfSecret = Read-Host 'What is type of your secret?';
       if($Secret.TypeOfSecret -eq '') { $Secret.TypeOfSecret = "site"; }
       # Receiving name for secret
       $Secret.Name = Read-Host 'What is your name?';
       if($Secret.Name -eq '') { $Secret.Name = "NoName"; }
       # Receiving password for secret
       $Secret.Password = Read-Host 'What will be your password?';
       # Receiving URL for secret
       $Secret.URL = Read-Host 'What is the URL of your secret?';
       if($Secret.URL -eq '') { $Secret.URL = "NoURL"; }
       # Receiving tags for secret
       $Secret.Tags = Read-Host 'Input tags for your secret?';
       if($Secret.Tags -eq '') { $Secret.Tags = "NoTags"; }
       # Receiving expires time for secret
       try {$Secret.ExpiresTime = Read-Host 'Input expires time for your secret?'; }
       catch {
            if($Secret.ExpiresTime -eq "01.01.0001 0:00:00") { $Secret.ExpiresTime = (Get-Date).AddDays(30); }
       }
       # Adding new secret to dictionary of secrets
       $global:DictionaryOfSecrets += $Secret;
       Echo "`nYou have successfully created a new secret!"
       # Writing dictionary of secrets to .secret file
       $global:DictionaryOfSecrets | ConvertTo-Json | Out-File "C:\Users\Aleksandr\Desktop\DevOpsLabs\PowerShell_Task\Secrets.secret";  
}
# Function to convert Date and Time to ID
Function Convert-DateTimeToID () 
{
       [int64]$ID = "{0:hhmmssddMMyyyy}" -f (Get-Date);
       Return  ($ID);
}
# Function to get secret by ID
Function Get-SecretByID ([int64] $IdOfSecret)
{
       $global:DictionaryOfSecrets | Where-Object {$_.ID -eq $IdOfSecret}
}
# Function to get secret by name
Function Get-SecretByName ([string] $NameOfSecret)
{
       if($NameOfSecret -eq '') { $NameOfSecret = "NoName"; }
       $global:DictionaryOfSecrets | Where-Object {$_.Name -eq $NameOfSecret}
}
# Function to get secret by days to expire
Function Get-SecretByExpiresTime ([int] $DaysToExpire)
{
       $global:DictionaryOfSecrets | Where-Object {($_.ExpiresTime).AddDays(-$DaysToExpire) -le (Get-Date)};
}
# Function to change expires time by secret`s ID
Function Set-ExpiresTimeBySecretID ([int64] $IdOfSecret)
{
       # Receiving expires time for secret
       try {[DateTime]$NewExpiresTime = Read-Host 'Input NEW expires time for your secret?'; }
       catch {
            if(!$NewExpiresTime) { $NewExpiresTime = (Get-Date).AddDays(30); }
       }
       Write-Host -NoNewline "`nNew expire time is: " $NewExpiresTime "`n";
       for ([int]$i = 0; $i -lt $global:DictionaryOfSecrets.Length; $i++)
       #foreach ($i in $global:DictionaryOfSecrets)
       {
            if($global:DictionaryOfSecrets[$i].ID -eq $IdOfSecret)
            {
                $global:DictionaryOfSecrets[$i].ExpiresTime = $NewExpiresTime;
            }
       }
       # Writing dictionary of secrets to .secret file
       $global:DictionaryOfSecrets | ConvertTo-Json | Out-File "C:\Users\Aleksandr\Desktop\DevOpsLabs\PowerShell_Task\Secrets.secret";
}
# Function to extend expires time by secret`s ID
Function Set-ExtendExpiresTimeBySecretID ([int64] $IdOfSecret, [int] $CountOfDays)
{
       for ([int]$i = 0; $i -lt $global:DictionaryOfSecrets.Length; $i++)
       {
            if($global:DictionaryOfSecrets[$i].ID -eq $IdOfSecret)
            {
                $global:DictionaryOfSecrets[$i].ExpiresTime = $global:DictionaryOfSecrets[$i].ExpiresTime.AddDays($CountOfDays);
            }
       }
       # Writing dictionary of secrets to .secret file
       $global:DictionaryOfSecrets | ConvertTo-Json | Out-File "C:\Users\Aleksandr\Desktop\DevOpsLabs\PowerShell_Task\Secrets.secret";
}
# Function to remove secret by ID
Function Remove-SecretByID ([int64] $IdOfSecret)
{     
       $global:DictionaryOfSecrets = $global:DictionaryOfSecrets | Where-Object { $_.ID –ne $IdOfSecret }
       # Writing dictionary of secrets to .secret file
       $global:DictionaryOfSecrets | ConvertTo-Json | Out-File "C:\Users\Aleksandr\Desktop\DevOpsLabs\PowerShell_Task\Secrets.secret";
}
