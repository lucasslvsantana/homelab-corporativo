# 01 - Active Directory Domain Services (AD DS)

Configuração do Controlador de Domínio primário e padronização da estrutura organizacional via PowerShell.

## Ambiente Implantado
* **Sistema Operacional:** Windows Server 2022 Standard (Desktop Experience)
* **Hostname:** `DC-CORPORATIVO`
* **Domínio NetBIOS / Floresta:** `CORP`
* **Serviços Ativos:** AD DS e DNS Server

## Estrutura Organizacional Provisionada
A criação da hierarquia foi automatizada através do script [`setup-ad-estrutura.ps1`](./setup-ad-estrutura.ps1) para evitar falhas manuais e garantir padronização:

* **OU Raiz:** `Empresa`
  * **OU `TI`:** Grupo `GRP_TI` | Usuário `lucas.admin`
  * **OU `Financeiro`:** Grupo `GRP_Financeiro` | Usuário `carlos.souza`
  * **OU `RH`:** Grupo `GRP_RH` | Usuário `ana.silva`

## Como Executar na VM
No PowerShell como Administrador:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\setup-ad-estrutura.ps1
