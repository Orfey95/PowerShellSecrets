Function Get-Password()
{
       [string]$Password; 

       # Example string
       $test = "#20aDA%A4D3a4Ada";
       # Get substring before sing %. Example: #20aDA.
       $PercentSign = $test.IndexOf("%");
       $StringBeforePercentSign = $test.Substring(0,$PercentSign);
       # Get length of password and password alphabet. Example: 20 and aDA.
       if($StringBeforePercentSign.IndexOf("D") -ne "-1"){$FirstLetter = $StringBeforePercentSign.IndexOf("D")};
       if($StringBeforePercentSign.IndexOf("A") -ne "-1"){if($StringBeforePercentSign.IndexOf("A") -lt $FirstLetter){$FirstLetter = $StringBeforePercentSign.IndexOf("A")}};
       if($StringBeforePercentSign.IndexOf("a") -ne "-1"){if($StringBeforePercentSign.IndexOf("a") -lt $FirstLetter){$FirstLetter = $StringBeforePercentSign.IndexOf("a")}};
       $PasswordLength = $test.Substring(1, $FirstLetter-1);
       $PasswordAlphabet = $StringBeforePercentSign.Substring($FirstLetter);
       Echo "Password Length: $PasswordLength";
       Echo "PasswordAlphabet: $PasswordAlphabet";
       # Get substring after sing %. Example: A4D3a4Ada.
       $StringAfterPercentSign = $test.Substring($PercentSign+1);
       echo $StringAfterPercentSign;
       # Get the number of capital letters (A) in a string. Example: A4 -> 4.
       $RegexForCapitalLetters = [regex]"A[0-9]+"
       $NumberOfCapitelLetters = $RegexForCapitalLetters.Match($StringAfterPercentSign).Value;
       if($RegexForCapitalLetters.Match($StringAfterPercentSign).Success){$NumberOfCapitelLetters = $NumberOfCapitelLetters.Substring(1)} else {$NumberOfCapitelLetters = 0}
       Echo "Number of capital letters: $NumberOfCapitelLetters";
       # Get the number of small letters (a) in a string. Example: a4 -> 4.
       $RegexForSmallLetters = [regex]"a[0-9]+"
       $NumberOfSmallLetters = $RegexForSmallLetters.Match($StringAfterPercentSign).Value;
       if($RegexForSmallLetters.Match($StringAfterPercentSign).Success){$NumberOfSmallLetters = $NumberOfSmallLetters.Substring(1)} else {$NumberOfSmallLetters = 0}
       Echo "Number of small letters: $NumberOfSmallLetters";
       # Get the number of digits (D) in a string. Example: D3 -> 3.
       $RegexForDigits = [regex]"D[0-9]+"
       $NumberOfDigits = $RegexForDigits.Match($StringAfterPercentSign).Value;
       if($RegexForDigits.Match($StringAfterPercentSign).Success){$NumberOfDigits = $NumberOfDigits.Substring(1)} else {$NumberOfDigits = 0}
       Echo "Number of digits: $NumberOfDigits";
}