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
```
PS C:\Users\Aleksandr> Add-Secret

What is type of your secret?: site
What is your name?: Aleksandr
What will be your password?: 1234
What is the URL of your secret?: google.com
Input tags for your secret?: google password gmail
Input expires time for your secret?:

You have successfully created a new secret!
```
2) Function to get secret by ID: `Get-SecretByID (ID)`; <br>
```
PS C:\Users\Aleksandr> Get-SecretByID 10395320112019

ID           : 10395320112019
TypeOfSecret : site
Name         : Aleksandr
Password     : 1234
URL          : google.com
Tags         : google password gmail
ExpiresTime  : 20.12.2019 22:40:20
```
3) Function to get secret by Name: `Get-SecretByName (Name)`; <br>
```
PS C:\Users\Aleksandr> Get-SecretByName Aleksandr

ID           : 10395320112019
TypeOfSecret : site
Name         : Aleksandr
Password     : 1234
URL          : google.com
Tags         : google password gmail
ExpiresTime  : 20.12.2019 22:40:20
```
4) Function to get secret by Days to expire: `Get-SecretByExpiresTime (Days)`; <br>
```
PS C:\Users\Aleksandr> Get-SecretByExpiresTime 30

ID           : 10395320112019
TypeOfSecret : site
Name         : Aleksandr
Password     : 1234
URL          : google.com
Tags         : google password gmail
ExpiresTime  : 20.12.2019 22:40:20
```
5) Function to change expires time by ID: `Set-ExpiresTimeBySecretID (ID)`; <br>
**Description**. After performing this function, field ExpiresTime will be requested again. If you do not enter the new content for this field, then it will not change.<br>
```
PS C:\Users\Aleksandr> Set-ExpiresTimeBySecretID 10395320112019
Input NEW expires time for your secret?: 2020/01/01 00:00:00

New expire time is:  01.01.2020 0:00:00 
```
6) Function to extend expires time by ID: `Set-ExtendExpiresTimeBySecretID (ID, Days)`; <br>
```
PS C:\Users\Aleksandr> Set-ExtendExpiresTimeBySecretID 10395320112019 366

PS C:\Users\Aleksandr> Get-SecretByID 10395320112019

ID           : 10395320112019
TypeOfSecret : site
Name         : Aleksandr
Password     : 1234
URL          : google.com
Tags         : google password gmail
ExpiresTime  : 01.01.2021 0:00:00
```
7) Function to remove secret by ID: `Remove-SecretByID (ID)`; <br>
```
PS C:\Users\Aleksandr> Remove-SecretByID 10395320112019

PS C:\Users\Aleksandr> Get-SecretByID 10395320112019

There is no secret with such ID!
```
8) Function to change secret by ID: `Update-SecretByID (ID)`; <br>
**Description**. After performing this function, all fields will be requested again. If no ExpiresTime is entered, the field will have the following contents: current date and time plus 30 days. <br>
```
PS C:\Users\Aleksandr> Update-SecretByID 10395320112019
What is NEW type of your secret?: 
What is NEW your name?: Sasha
What will be your NEW password?: 
What is the NEW URL of your secret?: 
Input NEW tags for your secret?: 
Input NEW expires time for your secret?: 

PS C:\Users\Aleksandr> Get-SecretByID 10395320112019

ID           : 10395320112019
TypeOfSecret : site
Name         : Sasha
Password     : 1234
URL          : google.com
Tags         : google password gmail
ExpiresTime  : 01.01.2021 0:00:00
```
9) Function to change tags by ID: `Set-TagsBySecretID (ID)`; <br>
```
PS C:\Users\Aleksandr> Set-TagsBySecretID 10395320112019
Input NEW tags for your secret?: NewTag1

PS C:\Users\Aleksandr> Get-SecretByID 10395320112019

ID           : 10395320112019
TypeOfSecret : site
Name         : Sasha
Password     : 1234
URL          : google.com
Tags         : NewTag1
ExpiresTime  : 01.01.2021 0:00:00
```
10) Function to add tags by ID: `Add-TagsBySecretID (ID)`. <br>
```
PS C:\Users\Aleksandr> Add-TagsBySecretID 10395320112019
Input NEW tags for your secret?: NewTag2

PS C:\Users\Aleksandr> Get-SecretByID 10395320112019

ID           : 10395320112019
TypeOfSecret : site
Name         : Sasha
Password     : 1234
URL          : google.com
Tags         : NewTag1 NewTag2
ExpiresTime  : 01.01.2021 0:00:00
```
