Function Get-Password($Pattern)
{      
       # Example string: #20aDA%A4D3a4ADa;
       # Check password pattern
       $RegexForPattern = [regex]"^#[0-9]+[AaD]+%[AaD]+[0-9]+[AaD]*$";
       if(!$RegexForPattern.Match($Pattern).Success)
       {
            Echo "`nPassword format error";
            break;
       }
       # Get substring before sing %. Example: #20aDA.
       $PercentSign = $Pattern.IndexOf("%");
       $StringBeforePercentSign = $Pattern.Substring(0,$PercentSign);
       # Get length of password. Example: 20.
       $RegexForLengthOfPassword = [regex]"[0-9]+";
       $PasswordLength = $RegexForLengthOfPassword.Match($StringBeforePercentSign).Value;
       # Get password alphabet. Example:aDA.
       $RegexForAlphabetOfPassword = [regex]"[aAD]+";
       $PasswordAlphabet = $RegexForAlphabetOfPassword.Match($StringBeforePercentSign).Value;
       # Get substring after sing %. Example: A4D3a4Ada.
       $StringAfterPercentSign = $Pattern.Substring($PercentSign+1);
       #-----------------------------------------------GENERATION-----------------------------------------------
       [string]$Password;
       $RegexForSpecificPartOfPassword = [regex]"[AaD]+[0-9]+";
       $TempSpecificPartOfPassword = $RegexForSpecificPartOfPassword.Matches($StringAfterPercentSign).Value;
       # Get substring after specific part of password. Example: Ada.
       $LengthOfStringOfSpecificPartOfPassword = (-join $RegexForSpecificPartOfPassword.Matches($StringAfterPercentSign).Value).Length;
       $StringAfterSpecificPartOfPassword = $StringAfterPercentSign.Substring($LengthOfStringOfSpecificPartOfPassword);
       # Generation specific part of password
       foreach($count in $TempSpecificPartOfPassword)
       {           
           if(($count.Substring(0,1)).Equals("D"))
           {
                while($i -ne $count.Substring(1)) 
                {
                    $Password += [string](0..9 | Get-Random); 
                    $i++;
                }
                $i = 0;
           }
           if(($count.Substring(0,1)).Equals("A"))
           {
                while($i -ne $count.Substring(1)) 
                {
                    $Password += [string](65..90 | Get-Random | % {[char]$_}); 
                    $i++;
                }
                $i = 0;
           }
           if(($count.Substring(0,1)).Equals("a"))
           {
                while($i -ne $count.Substring(1)) 
                {
                    $Password += [string](97..122 | Get-Random | % {[char]$_}); 
                    $i++;
                }
                $i = 0;
           }
       }
       # Get length of specific part of password
       $LengthOfRestPartOfPassword = $PasswordLength - $Password.Length;
       if($LengthOfRestPartOfPassword -lt 0)
       { 
            Echo "Password format error";
            break;
       }
       # Generation rest part of password
       if(([regex]"D").Match($StringAfterSpecificPartOfPassword).Value)
       {
            $Alphabet += (0..9);
       }
       if(([regex]"A").Match($StringAfterSpecificPartOfPassword).Value)
       {
            $Alphabet += (65..90 | % {[char]$_});
       }
       if(([regex]"a").Match($StringAfterSpecificPartOfPassword).Value)
       {
            $Alphabet += (97..122 | % {[char]$_});
       }
       for($j = 0; $j -ne $LengthOfRestPartOfPassword; $j++) 
       {
            $Password += [string]($Alphabet | Get-Random);
       }
       Echo $Password;
}
