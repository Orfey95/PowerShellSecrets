# Class of secret properties
Class FieldsOfSecrets
{
[int64]$ID             
[string]$TypeOfSecret     # Example: site
[string]$Name             # Example: Sasha
[string]$Password         # Example: 1234
[string]$URL              # Example: google.com
[string]$Tags             # Example: google password secret
[DateTime]$ExpiresTime    # Example: 2019/11/17 00:00:00
[string]$PasswordsHistory
}
# Creation of dictionary of secrets
$Global:DictionaryOfSecrets = @()
# Get dictionary of secrets from .secret file
$Global:PathToSecretFile = "C:\Users\Aleksandr\Desktop\DevOpsLabs\PowerShell_Task\Secrets.secret" 
$Global:DictionaryOfSecrets += (Get-Content $Global:PathToSecretFile | ConvertFrom-Json)
# Clear .secret file
"" | Out-File $Global:PathToSecretFile -NoNewline -Encoding ASCII
# Writing dictionary of secrets to .secret file
$Global:DictionaryOfSecrets | ConvertTo-Json | Out-File $Global:PathToSecretFile
# Function to add new secrets
function Add-Secret {
       <#
       .SYNOPSIS
            Addition new secret.       
       .DESCRIPTION
            Secret fields:
            ID. ID is generated automatically. It consists: hhmmssddMMyyyy(hours + minutes + seconds + day + month + year) at the moment of creation of the secret.
            Name. If no name is entered, the field will have the following contents: NoName.
            Password; If no password is entered, the field will be empty.
            URL. If no URL is entered, the field will have the following contents: NoURL.
            Tags. There can be any number of tags. If no tags is entered, the field will have the following contents: NoTags.
            ExpiresTime. This field has next format: year/mounth/day hours:minutes:seconds. Example: 2019/11/17 00:00:00. If no ExpiresTime is entered, the field will have the following contents: current date and time plus 30 days.
       #>
       [CmdletBinding()]
       # Creating an object from a class
       $Secret = New-Object FieldsOfSecrets 
       # Creating ID for secret
       $Secret.ID = Convert-DateTimeToID 
       # Receiving type of secret
       $Secret.TypeOfSecret = Read-Host 'What is type of your secret?' 
       if($Secret.TypeOfSecret -eq '') { 
            $Secret.TypeOfSecret = "site" 
       }
       # Receiving name for secret
       $Secret.Name = Read-Host 'What is your name?' 
       if($Secret.Name -eq '') { 
            $Secret.Name = "NoName" 
       }
       # Receiving password for secret
       for(;;){
            $Secret.Password = Read-Host 'What will be your password?'
            if($Secret.Password -ne ""){
                # Add password to history
                $Secret.PasswordsHistory += $Secret.Password
                break 
            } else {
                echo "Input password again!!!"
            }
       }
       # Receiving URL for secret
       $Secret.URL = Read-Host 'What is the URL of your secret?' 
       if($Secret.URL -eq '') { 
            $Secret.URL = "NoURL" 
       }
       # Receiving tags for secret
       $Secret.Tags = Read-Host 'Input tags for your secret?' 
       if($Secret.Tags -eq '') { 
            $Secret.Tags = "NoTags" 
       }
       # Receiving expires time for secret
       try {
       $Secret.ExpiresTime = Read-Host 'Input expires time for your secret?' 
       } catch {
            if($Secret.ExpiresTime -eq "01.01.0001 0:00:00") { 
                $Secret.ExpiresTime = (Get-Date).AddDays(30) 
            }
       }
       # Adding new secret to dictionary of secrets
       $Global:DictionaryOfSecrets += $Secret
       echo "`nYou have successfully created a new secret!"
       # Writing dictionary of secrets to .secret file
       $Global:DictionaryOfSecrets | ConvertTo-Json | Out-File $Global:PathToSecretFile       
}
# Function to delete all secrets
function Delete-AllSecrets {
       [CmdletBinding()]
       $Global:DictionaryOfSecrets = $null;
       "" | Out-File $Global:PathToSecretFile -NoNewline -Encoding ASCII
}

# Function to convert Date and Time to ID
function Convert-DateTimeToID {
       Return [int64]$ID = "{0:hhmmssddMMyyyy}" -f (Get-Date)
}
# Function to get secret by ID
function Get-SecretByID {
       [CmdletBinding()]
       param (
            [Parameter(Mandatory = $true)]
            [Int64]
            $IdOfSecret
       )
       $Global:DictionaryOfSecrets | Where-Object {$_.ID -eq $IdOfSecret} | Select-Object -Property ID, Name, Password, URL, Tags, ExpiresTime
       if(!($Global:DictionaryOfSecrets | Where-Object {$_.ID -eq $IdOfSecret})) {
            echo "`nThere is no secret with such ID!"
       }
}
# Function to get secret by name
function Get-SecretByName {
       [CmdletBinding()]
       param (
            [Parameter(Mandatory = $false)]
            [String]
            $NameOfSecret
       )
       if($NameOfSecret -eq '') { 
            $NameOfSecret = "NoName" 
       }
       $Global:DictionaryOfSecrets | Where-Object {$_.Name -eq $NameOfSecret} | Select-Object -Property ID, Name, Password, URL, Tags, ExpiresTime
}
# Function to get secret by days to expire
function Get-SecretByExpiresTime {
       [CmdletBinding()]
       param (
            [Parameter(Mandatory = $true)]
            [Int64]
            $DaysToExpire
       )
       $Global:DictionaryOfSecrets | Where-Object {($_.ExpiresTime).AddDays(-$DaysToExpire) -le (Get-Date)}
}
# Function to change expires time by secret`s ID
function Set-ExpiresTimeBySecretID {
       [CmdletBinding()]
       param (
            [Parameter(Mandatory = $true)]
            [Int64]
            $IdOfSecret
       )
       # Receiving expires time for secret
       try {
            [DateTime]$NewExpiresTime = Read-Host 'Input NEW expires time for your secret?' 
       } catch {
            if(!$NewExpiresTime) { $NewExpiresTime = (Get-Date).AddDays(30) }
       }
       Write-Host -NoNewline "`nNew expire time is: " $NewExpiresTime "`n"
       for ([int]$i = 0; $i -lt $Global:DictionaryOfSecrets.Length; $i++) {
            if($Global:DictionaryOfSecrets[$i].ID -eq $IdOfSecret) {
                $Global:DictionaryOfSecrets[$i].ExpiresTime = $NewExpiresTime
            }
       }
       # Writing dictionary of secrets to .secret file
       $Global:DictionaryOfSecrets | ConvertTo-Json | Out-File $Global:PathToSecretFile
}
# Function to extend expires time by secret`s ID
function Set-ExtendExpiresTimeBySecretID {
       [CmdletBinding()]
       param (
            [Parameter(Mandatory = $true)]
            [Int64]
            $IdOfSecret,

            [Parameter(Mandatory = $true)]
            [Int]
            $CountOfDays
       )
       for ([int]$i = 0; $i -lt $Global:DictionaryOfSecrets.Length; $i++) {
            if($Global:DictionaryOfSecrets[$i].ID -eq $IdOfSecret) {
                $Global:DictionaryOfSecrets[$i].ExpiresTime = $Global:DictionaryOfSecrets[$i].ExpiresTime.AddDays($CountOfDays)
            }
       }
       # Writing dictionary of secrets to .secret file
       $Global:DictionaryOfSecrets | ConvertTo-Json | Out-File $Global:PathToSecretFile
}
# Function to remove secret by ID
function Remove-SecretByID {     
       [CmdletBinding()]
       param (
            [Parameter(Mandatory = $true)]
            [Int64]
            $IdOfSecret
       )
       $Global:DictionaryOfSecrets = $Global:DictionaryOfSecrets | Where-Object { $_.ID –ne $IdOfSecret }
       # Writing dictionary of secrets to .secret file
       $Global:DictionaryOfSecrets | ConvertTo-Json | Out-File $Global:PathToSecretFile
}
# Function to change secret by ID
function Update-SecretByID {
       [CmdletBinding()]
       param (
            [Parameter(Mandatory = $true)]
            [Int64]
            $IdOfSecret
       )
       # Receiving type of secret
       [string]$NewTypeOfSecret = Read-Host 'What is NEW type of your secret?'
       # Receiving name for secret
       [string]$NewName = Read-Host 'What is NEW your name?'
       # Receiving password for secret
       [string]$NewPassword = Read-Host 'What will be your NEW password?'
       # Receiving URL for secret
       [string]$NewURL = Read-Host 'What is the NEW URL of your secret?'
       # Receiving tags for secret
       [string]$NewTags = Read-Host 'Input NEW tags for your secret?'
       # Receiving expires time for secret
       try {
            [DateTime]$NewExpiresTime = Read-Host 'Input NEW expires time for your secret?' 
       } catch {}
       # Overriding secret`s fields
       for ([int]$i = 0; $i -lt $Global:DictionaryOfSecrets.Length; $i++) {
            if($Global:DictionaryOfSecrets[$i].ID -eq $IdOfSecret) {
                if($NewTypeOfSecret) {
                    $Global:DictionaryOfSecrets[$i].TypeOfSecret = $NewTypeOfSecret
                }
                if($NewName) {
                    $Global:DictionaryOfSecrets[$i].Name = $NewName
                }
                if($NewPassword) {
                    $Global:DictionaryOfSecrets[$i].Password = $NewPassword
                    # Add password to history
                    $Global:DictionaryOfSecrets[$i].PasswordsHistory += " $NewPassword"
                }
                if($NewURL) {
                    $Global:DictionaryOfSecrets[$i].URL = $NewURL
                }
                if($NewTags) {
                    $Global:DictionaryOfSecrets[$i].Tags = $NewTags
                }
                if($NewExpiresTime) {
                    $Global:DictionaryOfSecrets[$i].ExpiresTime = $NewExpiresTime
                }
            }
       }
       # Writing dictionary of secrets to .secret file
       $Global:DictionaryOfSecrets | ConvertTo-Json | Out-File $global:PathToSecretFile
}
# Function to change tags by secret`s ID
function Set-TagsBySecretID {
       [CmdletBinding()]
       param (
            [Parameter(Mandatory = $true)]
            [Int64]
            $IdOfSecret
       )
       # Receiving tags for secret
       [string]$NewTags = Read-Host 'Input NEW tags for your secret?'
       if(!$NewTags) { 
            $NewTags="NoTags" 
       }        
       for ([int]$i = 0; $i -lt $Global:DictionaryOfSecrets.Length; $i++) {
            if($Global:DictionaryOfSecrets[$i].ID -eq $IdOfSecret) {
                $Global:DictionaryOfSecrets[$i].Tags = $NewTags
            }
       }
       # Writing dictionary of secrets to .secret file
       $Global:DictionaryOfSecrets | ConvertTo-Json | Out-File $Global:PathToSecretFile
}
# Function to add tags by secret`s ID
function Add-TagsBySecretID {
       [CmdletBinding()]
       param (
            [Parameter(Mandatory = $true)]
            [Int64]
            $IdOfSecret
       )
       # Receiving tags for secret
       [string]$NewTags = Read-Host 'Input NEW tags for your secret?'
       if(!$NewTags) {
            break;
       }             
       for ([int]$i = 0; $i -lt $Global:DictionaryOfSecrets.Length; $i++) {
            if($Global:DictionaryOfSecrets[$i].ID -eq $IdOfSecret) {
                if($Global:DictionaryOfSecrets[$i].Tags -ne "NoTags") {
                    $Global:DictionaryOfSecrets[$i].Tags += " $NewTags"
                } else {
                    $Global:DictionaryOfSecrets[$i].Tags = ""
                    $Global:DictionaryOfSecrets[$i].Tags += "$NewTags"
                }
            }
       }
       # Writing dictionary of secrets to .secret file
       $Global:DictionaryOfSecrets | ConvertTo-Json | Out-File $Global:PathToSecretFile
}
# Function to get password history by secret`s ID
function Get-PasswordHistoryByID {
       [CmdletBinding()]
       param (
            [Parameter(Mandatory = $true)]
            [Int64]
            $IdOfSecret
       )
       $Global:DictionaryOfSecrets | Where-Object {$_.ID -eq $IdOfSecret} | Select-Object -Property PasswordsHistory
       if(!($Global:DictionaryOfSecrets | Where-Object {$_.ID -eq $IdOfSecret})) {
            echo "`nThere is no secret with such ID!"
       }
}
# Function to set password from password history by secret`s ID
function Set-PasswordFromHistoryByID {
       [CmdletBinding()]
       param (
            [Parameter(Mandatory = $true)]
            [Int64]
            $IdOfSecret
       )       
       if(!($Global:DictionaryOfSecrets | Where-Object {$_.ID -eq $IdOfSecret})) {
            echo "`nThere is no secret with such ID!"
            break
       }
       for ([int]$i = 0; $i -lt $Global:DictionaryOfSecrets.Length; $i++) {
            if($Global:DictionaryOfSecrets[$i].ID -eq $IdOfSecret) {                
                $PasswordHistoryArray = $Global:DictionaryOfSecrets[$i].PasswordsHistory.Split(" ")
                for([int]$j = 0; $j -lt $PasswordHistoryArray.Length; $j++){
                    Write-Host -NoNewline $j -  $PasswordHistoryArray[$j] `n
                }
                for(;;){
                    [int]$PasswordID = Read-Host 'Choose one of the passwords, or or leave the request unanswered so that nothing changes'
                    if($PasswordHistoryArray.Length -le $PasswordID){
                        echo "You have selected an invalid password number!!`n"
                    } else {
                        $Global:DictionaryOfSecrets[$i].Password = $PasswordHistoryArray[$PasswordID]
                        break
                    }
                }
            }
       }
}
