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
       # Get the number of capital letters (A). Example: A4 -> 4.
       $RegexForCapitalLetters = [regex]"A[0-9]+";
       $NumberOfCapitelLetters = $RegexForCapitalLetters.Match($StringAfterPercentSign).Value;
       if($RegexForCapitalLetters.Match($StringAfterPercentSign).Success)
       {
            $NumberOfCapitelLetters = $NumberOfCapitelLetters.Substring(1);
            [int]$LengthOfSpecificPartOfPassword = $RegexForCapitalLetters.Match($StringAfterPercentSign).Length;
            $IndexOfCapitelLetters = $StringAfterPercentSign.IndexOf($RegexForCapitalLetters.Match($StringAfterPercentSign).Value);
       } 
       else 
       {
            $NumberOfCapitelLetters = 0;
            $IndexOfCapitelLetters = -1;
       }
       Echo "Number of capital letters: $NumberOfCapitelLetters";
       # Get the number of small letters (a). Example: a4 -> 4.
       $RegexForSmallLetters = [regex]"a[0-9]+";
       $NumberOfSmallLetters = $RegexForSmallLetters.Match($StringAfterPercentSign).Value;
       if($RegexForSmallLetters.Match($StringAfterPercentSign).Success)
       {
            $NumberOfSmallLetters = $NumberOfSmallLetters.Substring(1);
            $LengthOfSpecificPartOfPassword += $RegexForSmallLetters.Match($StringAfterPercentSign).Length;
            $IndexOfSmallLetters = $StringAfterPercentSign.IndexOf($RegexForSmallLetters.Match($StringAfterPercentSign).Value);
       } 
       else 
       {
            $NumberOfSmallLetters = 0;
            $IndexOfSmallLetters = -1;
       }
       Echo "Number of small letters: $NumberOfSmallLetters";
       # Get the number of digits (D). Example: D3 -> 3.
       $RegexForDigits = [regex]"D[0-9]+";
       $NumberOfDigits = $RegexForDigits.Match($StringAfterPercentSign).Value;
       if($RegexForDigits.Match($StringAfterPercentSign).Success)
       {
            $NumberOfDigits = $NumberOfDigits.Substring(1);
            $LengthOfSpecificPartOfPassword += $RegexForDigits.Match($StringAfterPercentSign).Length;
            $IndexOfDigits = $StringAfterPercentSign.IndexOf($RegexForDigits.Match($StringAfterPercentSign).Value);
       } 
       else 
       {
            $NumberOfDigits = 0;
            $IndexOfDigits = -1;
       }
       Echo "Number of digits: $NumberOfDigits";
       # Get the number and composition of the rest of password. Example: Ada and 9.
       $CompositionOfTheRestOfPassword = $StringAfterPercentSign.Substring($LengthOfSpecificPartOfPassword);
       Echo "Composition of the rest of password: $CompositionOfTheRestOfPassword";
       [int]$NumberOfTheRestOfPassword = $PasswordLength - $NumberOfCapitelLetters - $NumberOfSmallLetters - $NumberOfDigits;
       if($NumberOfTheRestOfPassword -lt 0)
       {
            Echo "`nError in generating password structure";
            break;
       }
       Echo "Number of the rest of password: $NumberOfTheRestOfPassword";

       #-----------------------------------------------GENERATION-----------------------------------------------
       
       [string]$Password;
       [string]$SpecificDigitsOfPassword;
       [string]$SpecificCapitelLettersOfPassword;
       [string]$SpecificSmallLettersOfPassword;

       while($i -ne $NumberOfDigits) 
       {
            $SpecificDigitsOfPassword += [string](0..9 | Get-Random); 
            $i++;
       }

       while($j -ne $NumberOfCapitelLetters) 
       {
            $SpecificCapitelLettersOfPassword += [string](65..90 | Get-Random | % {[char]$_}); 
            $j++;
       }

       while($k -ne $NumberOfSmallLetters) 
       {
            $SpecificSmallLettersOfPassword += [string](97..122 | Get-Random | % {[char]$_}); 
            $k++;
       }
       #    $IndexOfCapitelLetters < $IndexOfDigits < $IndexOfSmallLetters
       if(($IndexOfCapitelLetters -lt $IndexOfDigits) -and ($IndexOfDigits -lt $IndexOfSmallLetters))
       {
            $Password += $SpecificCapitelLettersOfPassword + $SpecificDigitsOfPassword + $SpecificCapitelLettersOfPassword;                
       }

       echo "Password is: $Password";
}
