Function Get-Password()
{      
       # Example string
       $test = "#20aDA%A4D3a4Ada";
       # Get substring before sing %. Example: #20aDA.
       $PercentSign = $test.IndexOf("%");
       $StringBeforePercentSign = $test.Substring(0,$PercentSign);
       # Get length of password. Example: 20.
       $RegexForLengthOfPassword = [regex]"[0-9]+";
       $PasswordLength = $RegexForLengthOfPassword.Match($StringBeforePercentSign).Value;
       Echo "Password Length: $PasswordLength";
       # Get password alphabet. Example:aDA.
       $RegexForAlphabetOfPassword = [regex]"[aAD]+";
       $PasswordAlphabet = $RegexForAlphabetOfPassword.Match($StringBeforePercentSign).Value;       
       Echo "Password alphabet: $PasswordAlphabet";
       # Get substring after sing %. Example: A4D3a4Ada.
       $StringAfterPercentSign = $test.Substring($PercentSign+1);
       #-----------------------------------------------GENERATION-----------------------------------------------
       [string]$Password;
       $RegexForSpecificPartOfPassword = [regex]"[AaD]+[0-9]+";
       $TempSpecificPartOfPassword = $RegexForSpecificPartOfPassword.Matches($StringAfterPercentSign).Value;
       # Get substring after specific part of password. Example: Ada.
       $LengthOfSpecificPartOfPassword = (-join $RegexForSpecificPartOfPassword.Matches($StringAfterPercentSign).Value).Length;
       $StringAfterSpecificPartOfPassword = $StringAfterPercentSign.Substring($LengthOfSpecificPartOfPassword);
       Echo "Rest part of password: $StringAfterSpecificPartOfPassword";
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
       Echo $Password;
}
