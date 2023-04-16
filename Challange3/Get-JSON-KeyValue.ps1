###########################################################################################################################################
#                            GET JSON KEY & VALUE (DYNAMIC)
# Ex. ./Script.ps1 -JsonStr '{ "Accounts":{ "Users": { "jdoe":{ "givenName":"John", "surname":"Doe", "department":"Finance" }, "jdoe2":{ "givenName":"John2", "surname":"Doe2",   "department":"Finance2" }}}}' -KeyName "Accounts/Users/jdoe/givenName"
# Ex. ./Script.ps1 -JsonStr '{ "Accounts":{ "Users": { "jdoe":{ "givenName":"John", "surname":"Doe", "department":"Finance" }, "jdoe2":{ "givenName":"John2", "surname":"Doe2",   "department":"Finance2" }}}}' -KeyName "Accounts/Users/jdoe/surname"
# Ex. ./Script.ps1 -JsonStr '{ "Accounts":{ "Users": { "jdoe":{ "givenName":"John", "surname":"Doe", "department":"Finance" }, "jdoe2":{ "givenName":"John2", "surname":"Doe2",   "department":"Finance2" }}}}' -KeyName "Accounts/Users/jdoe/surname"
# Ex. ./Script.ps1 -JsonStr '{ "a":{ "b": { "c":{ "d":"e"}}}}' -KeyName "a/b/c/d"
###########################################################################################################################################
param (
    [Parameter( Mandatory=$true)]
    [string]$JsonStr,
    [string]$KeyName
)

#Convert JSON to PS Object
$myJson = $JsonStr | ConvertFrom-Json

#Split the Key Input
$a = $KeyName -split "/"
$c=$myJson

# Get the last Level Key Value
foreach ($i in $a) {
    $c=$c.$i
    if ($i -eq $a[-1]) {
        Write-Host "Value is - $c" -ForegroundColor DarkGreen -BackgroundColor Yellow
    }
}
