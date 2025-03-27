
# Desativar Serviços Desnecessários no Windows

**AVISO LEGAL:**  
Este procedimento é destinado a técnicos de informática, administradores de sistemas e usuários avançados.  
**Desativar serviços incorretamente pode afetar o funcionamento do sistema.**  
Use este material com responsabilidade e sempre em ambientes autorizados.

---

## Objetivo

Desativar serviços do Windows considerados desnecessários para a maioria dos usuários, com o objetivo de:

- Reduzir consumo de memória e CPU
- Acelerar a inicialização
- Minimizar processos em segundo plano

Ideal para máquinas domésticas, laboratórios, VMs e equipamentos com hardware limitado.

---

## Lista de Serviços Sugeridos para Desativação

| Serviço                      | Nome interno             | Descrição resumida                                      |
|------------------------------|---------------------------|----------------------------------------------------------|
| Fax                          | `Fax`                     | Serviço de envio/recebimento de fax                     |
| Serviço de impressão XPS     | `XpsPrint`                | Relacionado à impressão de documentos XPS               |
| Mapas offline                | `MapsBroker`              | Cache de mapas, desnecessário para maioria              |
| Superfetch / SysMain         | `SysMain`                 | Pré-carregamento de apps na RAM                         |
| Windows Search               | `WSearch`                 | Indexação de arquivos (útil, mas consome recursos)      |
| Xbox Services                | `XblGameSave`, `XboxNetApiSvc` | Serviços relacionados à integração com Xbox      |
| Diagnóstico de compatibilidade | `DiagTrack`             | Coleta de telemetria para a Microsoft                   |
| BITS                         | `BITS`                    | Transferência em segundo plano (ex: Windows Update)     |
| Serviço de Telefonia         | `TapiSrv`                 | Suporte a telefonia, raramente utilizado                |

---

## Como Desativar

### Via Prompt de Comando (como Administrador):

```cmd
sc stop "NomeDoServico"
sc config "NomeDoServico" start= disabled
```

**Exemplo:**

```cmd
sc stop "SysMain"
sc config "SysMain" start= disabled
```

### Via PowerShell:

```powershell
Stop-Service -Name "SysMain" -Force
Set-Service -Name "SysMain" -StartupType Disabled
```

---

## Sugestão: Script PowerShell

```powershell
$services = @(
  "Fax",
  "XpsPrint",
  "MapsBroker",
  "SysMain",
  "WSearch",
  "XblGameSave",
  "XboxNetApiSvc",
  "DiagTrack",
  "BITS",
  "TapiSrv"
)

foreach ($s in $services) {
  try {
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    Set-Service -Name $s -StartupType Disabled
    Write-Host "Desativado: $s"
  } catch {
    Write-Warning "Falha ao desativar $s"
  }
}
```

---

## Observações

- Faça backup ou crie um ponto de restauração antes de aplicar alterações em massa.
- Alguns serviços podem ser úteis em determinados cenários (ex: Search em SSDs rápidos).
- Recomendado aplicar em máquinas de teste ou ambientes controlados antes de ambientes de produção.

---

## Ética e Responsabilidade

Utilize este material apenas em sistemas sob sua responsabilidade.  
Não aplique mudanças críticas em sistemas corporativos sem planejamento e autorização.

---

## Licença

Distribuído sob a licença [MIT](LICENSE).  
Conteúdo fornecido "como está", sem garantias.
