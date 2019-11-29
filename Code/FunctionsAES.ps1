# Function to get secret key
function Get-CryptographyKey {
       # Create Key 
       $Global:Key = New-CryptographyKey -Algorithm AES 
       $Global:Key = ConvertFrom-SecureString -securestring $Global:Key
       $Global:Key | Out-File $Global:PathToKey
       echo "`nYou have successfully created AES key!"
}
# Function to encrypt the secret file
function Protect-SecretFile {
       $Global:Key = (Get-Content $Global:PathToKey | ConvertTo-SecureString)
       Protect-File -FileName $Global:PathToSecretFile -Key $Global:Key -Algorithm AES -CipherMode CBC -RemoveSource
}
# Function to decrypt the secret file
function Unprotect-SecretFile {
       [string]$AESFilePath = $Global:PathToSecretFile + '.AES'
       $Global:Key = (Get-Content $Global:PathToKey | ConvertTo-SecureString)
       Unprotect-File -FileName $AESFilePath -Key $Global:Key -Algorithm AES -CipherMode CBC -RemoveSource
}