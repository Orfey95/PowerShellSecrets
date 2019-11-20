# PowerShell Project. Secrets Manager.
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
10) Function to add tags by ID: <code>Add-TagsBySecretID (ID)</code>;
