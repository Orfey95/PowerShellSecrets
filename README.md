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
**Description**. This field has next format: *year/mounth/day hours:minutes:seconds*. Example: 2019/11/17 00:00:00. If no URL is entered, the field will have the following contents: current date and time plus 30 days.<br>
**All secrets are also stored in .secret file in json format.**<br>
List of functions:
1) Function to add new secrets: `Add-Secret ()`; <br>
2) Function to get secret by ID: `Get-SecretByID (ID)`; <br>
3) Function to get secret by Name: `Get-SecretByName (Name)`; <br>
4) Function to get secret by Days to expire: `Get-SecretByExpiresTime (Days)`; <br>
5) Function to change expires time by ID: `Set-ExpiresTimeBySecretID (ID)`; <br>
6) Function to extend expires time by ID: `Set-ExtendExpiresTimeBySecretID (ID, Days)`; <br>
7) Function to remove secret by ID: `Remove-SecretByID (ID)`; <br>
8) Function to change secret by ID: `Update-SecretByID (ID)`; <br>
**Description**. After performing this function, all fields will be requested again. If you do not enter the new contents of the fields, then it will not change.
9) Function to change tags by ID: `Set-TagsBySecretID (ID)`; <br>
10) Function to add tags by ID: `Add-TagsBySecretID (ID)`. <br>
