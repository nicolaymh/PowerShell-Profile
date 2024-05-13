# Configuración de PSReadLine.

# Sets the prediction source to use history for PowerShell command prediction.
Set-PSReadLineOption -PredictionSource History

# Sets the prediction view style to ListView for PowerShell command prediction.
Set-PSReadLineOption -PredictionViewStyle ListView


########################################################################################
########################################################################################


# Defines the prompt function to customize the appearance of the PowerShell prompt.
function prompt {
    # Retrieves the current directory path.
    $path = (Get-Location).Path

    # Extracts the leaf portion of the directory path (i.e., the folder name).
    $folderName = Split-Path -Path $path -Leaf

    # Specifies the label to be displayed before the folder name.
    $folderLabel = "Folder:"

    # Defines the color for the folder name text.
    $folderNameColor = "Green"

    # Specifies the separator character.
    $separator = "&"

    # Retrieves information about the current user's role.
    $userPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

    # Checks if the current user is in the Administrator role.
    if ($userPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        # Sets the user type to "Root" if the user is an Administrator.
        $userType = "Root"

        # Defines the color for the "Root" text.
        $userTypeColor = "Yellow"

        # Defines the color for the separator when the user is an Administrator.
        $separatorColor = "Red"
    } else {
        # Sets the user type to "USER" if the user is not an Administrator.
        $userType = "USER"

        # Defines the color for the "USER" text.
        $userTypeColor = "Green"

        # Defines the color for the separator when the user is not an Administrator.
        $separatorColor = "Red"
    }

    # Displays the folder label with magenta color.
    Write-Host -NoNewline "[$($folderLabel) " -ForegroundColor Magenta

    # Displays the folder name with green color.
    Write-Host -NoNewline "$($folderName)] " -ForegroundColor Green

    # Displays the separator character with the specified color.
    Write-Host -NoNewline "$($separator)" -ForegroundColor $separatorColor

    # Adds a space after the separator.
    Write-Host -NoNewline " "

    # Displays the user type (Root or USER) with the specified color.
    Write-Host -NoNewline "$($userType)> " -ForegroundColor $userTypeColor
}
