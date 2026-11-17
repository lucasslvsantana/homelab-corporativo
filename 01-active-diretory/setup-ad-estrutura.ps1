# Script de provisionamento da estrutura inicial do Active Directory
# Domínio: CORP | Servidor: DC-CORPORATIVO

Import-Module ActiveDirectory

$DominioDNS = (Get-ADDomain).DNSRoot
$BaseDN = (Get-ADDomain).DistinguishedName

# 1. Criação da OU Raiz e Sub-OUs Departamentais
New-ADOrganizationalUnit -Name "Empresa" -Path $BaseDN -ProtectedFromAccidentalDeletion $false
$OUEmpresa = "OU=Empresa,$BaseDN"

$Setores = @("TI", "Financeiro", "RH")
foreach ($Setor in $Setores) {
    New-ADOrganizationalUnit -Name $Setor -Path $OUEmpresa -ProtectedFromAccidentalDeletion $false
    New-ADGroup -Name "GRP_$Setor" -GroupScope Global -GroupCategory Security -Path "OU=$Setor,$OUEmpresa"
}

# 2. Criação de Usuários de Teste e Vínculo aos Grupos
$SenhaPadrao = ConvertTo-SecureString "LabCorp@2026" -AsPlainText -Force

New-ADUser -Name "Ana Silva" -GivenName "Ana" -Surname "Silva" -SamAccountName "ana.silva" -UserPrincipalName "ana.silva@$DominioDNS" -Path "OU=RH,$OUEmpresa" -AccountPassword $SenhaPadrao -Enabled $true
Add-ADGroupMember -Identity "GRP_RH" -Members "ana.silva"

New-ADUser -Name "Carlos Souza" -GivenName "Carlos" -Surname "Souza" -SamAccountName "carlos.souza" -UserPrincipalName "carlos.souza@$DominioDNS" -Path "OU=Financeiro,$OUEmpresa" -AccountPassword $SenhaPadrao -Enabled $true
Add-ADGroupMember -Identity "GRP_Financeiro" -Members "carlos.souza"

New-ADUser -Name "Lucas Admin" -GivenName "Lucas" -Surname "Admin" -SamAccountName "lucas.admin" -UserPrincipalName "lucas.admin@$DominioDNS" -Path "OU=TI,$OUEmpresa" -AccountPassword $SenhaPadrao -Enabled $true
Add-ADGroupMember -Identity "GRP_TI" -Members "lucas.admin"

Write-Output "Estrutura de OUs, grupos e usuários criada com sucesso!"
