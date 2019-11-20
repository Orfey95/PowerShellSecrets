## PowerShell Project. Secrets Manager.
Secret fields:
1) ID; <br>
**Description**. ID is generated automatically. It consists of *hhmmssddMMyyyy*(hours + minutes + seconds + day + month + year) of the moment of creation of the secret.
2) Name; <br>
**Description**. If no name is entered, the field will have the following contents: NoName.
3) Password; <br>
**Description**. If no password is entered, the field will be empty.
4) URL; <br>
**Description**. If no URL is entered, the field will have the following contents: NoURL.
5) Tags; <br>
**Description**. There can be any number of tags. If no tags is entered, the field will have the following contents: NoTags.
6) ExpiresTime. <br>
**Description**. This field has next format: *year/mounth/day hours:minutes:seconds*. Example: 2019/11/17 00:00:00. If no ExpiresTime is entered, the field will have the following contents: current date and time plus 30 days.<br>

**All secrets are also stored in .secret file in json format.**<br>
![Secret file](/Images/Secret_File.png)

List of functions:
1) Function to add new secrets: `Add-Secret ()`; <br>
![Add-Secret](/Images/Add_Secret.png)
2) Function to get secret by ID: `Get-SecretByID (ID)`; <br>
![Get-SecretByID](/Images/Get-SecretByID.png)
3) Function to get secret by Name: `Get-SecretByName (Name)`; <br>
![Get-SecretByName](/Images/Get-SecretByName.png)
4) Function to get secret by Days to expire: `Get-SecretByExpiresTime (Days)`; <br>
![Get-SecretByExpiresTime](/Images/Get-SecretByExpiresTime.png)
5) Function to change expires time by ID: `Set-ExpiresTimeBySecretID (ID)`; <br>
**Description**. After performing this function, field ExpiresTime will be requested again. If you do not enter the new content for this field, then it will not change.<br>
![Set-ExpiresTimeBySecretID](/Images/Set-ExpiresTimeBySecretID.png)
6) Function to extend expires time by ID: `Set-ExtendExpiresTimeBySecretID (ID, Days)`; <br>
![Set-ExtendExpiresTimeBySecretID](/Images/Set-ExtendExpiresTimeBySecretID.png)
7) Function to remove secret by ID: `Remove-SecretByID (ID)`; <br>
![Remove-SecretByID](/Images/Remove-SecretByID.png)
8) Function to change secret by ID: `Update-SecretByID (ID)`; <br>
**Description**. After performing this function, all fields will be requested again. If no ExpiresTime is entered, the field will have the following contents: current date and time plus 30 days. <br>
![Update-SecretByID](/Images/Update-SecretByID.png)
9) Function to change tags by ID: `Set-TagsBySecretID (ID)`; <br>
![Set-TagsBySecretID](/Images/Set-TagsBySecretID.png)
10) Function to add tags by ID: `Add-TagsBySecretID (ID)`. <br>
![Add-TagsBySecretID](/Images/Add-TagsBySecretID.png)


`PS C:\Users\Aleksandr> Add-Secret
What is type of your secret?: site
What is your name?: Aleksandr
What will be your password?: 1234
What is the URL of your secret?: google.com
Input tags for your secret?: google password gmail
Input expires time for your secret?: 

You have successfully created a new secret!`
