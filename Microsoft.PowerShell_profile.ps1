# Configuración de PSReadLine.

# Establece la fuente de predicción para usar el historial en la predicción de comandos de PowerShell.
Set-PSReadLineOption -PredictionSource History

# Establece el estilo de vista de predicción a ListView para la predicción de comandos de PowerShell.
Set-PSReadLineOption -PredictionViewStyle ListView


########################################################################################
########################################################################################



# Función para definir el prompt personalizado de PowerShell.
function prompt {
    # Obtiene la ruta del directorio actual.
    $path = (Get-Location).Path

    # Extrae el nombre de la carpeta del final de la ruta del directorio.
    $folderName = Split-Path -Path $path -Leaf

    # Etiqueta para el nombre de la carpeta en el prompt.
    $folderLabel = "Folder:"

    # Carácter separador entre la carpeta y el tipo de usuario.
    $separator = "&"

    # Obtiene información sobre el rol del usuario actual.
    $userPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

    # Verifica si el usuario actual está en el rol de Administrador.
    if ($userPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        # Define el tipo de usuario como "Root" si el usuario es un Administrador.
        $userType = "Root"
        # Color para el texto del tipo de usuario.
        $userTypeColor = "Yellow"
    } else {
        # Define el tipo de usuario como "USER" si el usuario no es un Administrador.
        $userType = "USER"
        # Color para el texto del tipo de usuario.
        $userTypeColor = "Green"
    }

    # Imprime la etiqueta de la carpeta con color negro.
    Write-Host -NoNewline "[$($folderLabel) " -ForegroundColor Black

    # Imprime el nombre de la carpeta con color amarillo oscuro.
    Write-Host -NoNewline "$($folderName)] " -ForegroundColor DarkYellow

    # Imprime el separador con color rojo.
    Write-Host -NoNewline "$($separator)" -ForegroundColor Red

    # Imprime un espacio en blanco.
    Write-Host -NoNewline " "

    # Imprime el tipo de usuario con el color correspondiente.
    Write-Host -NoNewline "$($userType)> " -ForegroundColor $userTypeColor
}
