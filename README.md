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
**Description**. This field has next format: *year/mounth/day hours:minutes:seconds*. Example: 2019/11/17 00:00:00. If no URL is entered, the field will have the following contents: current date and time plus 30 days.

List of functions:
1) Function to add new secrets: <code>Add-Secret ()</code>;
2) Function to get secret by ID: <code>Get-SecretByID (ID)</code>;
3) Function to get secret by Name: <code>Get-SecretByName (Name)</code>;
4) Function to get secret by Days to expire: <code>Get-SecretByExpiresTime (DaysToExpire)</code>;
5) Function to change expires time by ID: <code>Set-ExpiresTimeBySecretID (ID)</code>;
6) Function to extend expires time by ID: <code>Set-ExtendExpiresTimeBySecretID (ID, Days)</code>;
7) Function to remove secret by ID: <code>Remove-SecretByID (ID)</code>;
8) Function to change secret by ID: <code>Update-SecretByID (ID)</code>;
9) Function to change tags by ID: <code>Set-TagsBySecretID (ID)</code>;
10) Function to add tags by ID: <code>Add-TagsBySecretID (ID)</code>.
