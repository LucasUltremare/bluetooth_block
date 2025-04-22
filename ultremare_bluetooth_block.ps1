# 🚫 Script by Ultremare
# Desativar a transferência de arquivos via Bluetooth (OBEX).

Write-Host "🔧 Iniciando configuração... (Ultremare Systems)"

#Desativa o serviço BthObex
$serviceName = "BthObex"
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

if ($service) {
    if ($service.Status -eq "Running") {
        Stop-Service -Name $serviceName -Force
        Write-Host "Serviço BthObex parado."
    }
    Set-Service -Name $serviceName -StartupType Disabled
    Write-Host "Serviço BthObex desativado na inicialização."
} else {
    Write-Host "Serviço BthObex não encontrado neste sistema."
}

#Protege o Registro contra alteração futura
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\BthObex"
try {
    $acl = Get-Acl $regPath

    # Remove herança de permissões
    $acl.SetAccessRuleProtection($true, $false)

    # Permite acesso total apenas para Administradores
    $admin = New-Object System.Security.Principal.NTAccount("Administradores")
    $rule = New-Object System.Security.AccessControl.RegistryAccessRule($admin, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
    $acl.SetAccessRule($rule)

    # Aplica as novas permissões
    Set-Acl -Path $regPath -AclObject $acl

    Write-Host "Permissões do Registro protegidas com sucesso."
} catch {
    Write-Host "Erro ao proteger o Registro: $_"
}

Write-Host "`n Concluído. Transferência de arquivos Bluetooth permanentemente desativada."
