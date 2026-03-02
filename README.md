# seccopilotagent

Repo to play around with Security Copilot agents and Sentinel MCP. Use the provided Dev Container definition with VS Code (see https://code.visualstudio.com/docs/devcontainers/containers) to have all the tools and Sentinel MCP configuration at hand.

---

## Dev Container

The repository ships a ready-to-use [Dev Container](https://containers.dev/) under `.devcontainer/`. Opening the folder in VS Code (or GitHub Codespaces) automatically builds and starts the container, giving every contributor an identical, reproducible environment.

### Base image & user

| Property | Value |
|---|---|
| Base image | `fedora:latest` |
| Default user | `sec-copilot` (non-root, passwordless `sudo`) |
| Working directory | `/home/sec-copilot/workspace` |
| Default shell | `bash` (bash-it theme: *nwinkler*) |

---

### Pre-installed tooling

#### System utilities

`git` · `curl` · `wget` · `jq` · `unzip` / `zip` · `tar` · `vim` · `nano` · `less` · `openssh-clients` · `gcc` · `bind-utils` · `iputils` · `procps-ng` · `findutils` · `diffutils`

#### CLIs

| Tool | Notes |
|---|---|
| **Azure CLI** (`az`) | Installed from the official Microsoft RPM repository |
| **GitHub CLI** (`gh`) | Installed from the official GitHub RPM repository |
| **PowerShell** (`pwsh`) | Installed from the Microsoft Fedora/RHEL package feed |
| **Node.js** / **npm** | Installed via `microdnf` system packages |
| **Python 3** / `pip` | Installed via `microdnf` system packages |

#### Node.js global packages

| Package | Purpose |
|---|---|
| `@azure/mcp` | Azure Model Context Protocol (MCP) server |
| `typescript` | TypeScript compiler |
| `ts-node` | TypeScript execution engine |

#### Python packages

| Package | Purpose |
|---|---|
| `azure-identity` | Azure authentication |
| `azure-mgmt-securityinsight` | Microsoft Sentinel management |
| `azure-mgmt-loganalytics` | Log Analytics workspace management |
| `azure-monitor-query` | Query Azure Monitor / Log Analytics |
| `msal` | Microsoft Authentication Library |
| `requests` | HTTP client |
| `pyyaml` | YAML parsing |
| `python-dotenv` | `.env` file support |
| `openai` | OpenAI / Azure OpenAI SDK |
| `semantic-kernel` | Microsoft Semantic Kernel agent framework |
| `mcp` | Model Context Protocol SDK |
| `azure-ai-agents` | Azure AI Agents SDK |
| `pydantic` / `pydantic-settings` | Data validation |

#### PowerShell modules (installed to `CurrentUser` scope)

`Az` · `Az.SecurityInsights` · `Az.Accounts` · `Az.Resources` · `Az.Monitor` · `Az.OperationalInsights` · `Microsoft.Graph`

---

### VS Code extensions

| Extension | Purpose |
|---|---|
| `GitHub.copilot-chat` | GitHub Copilot Chat |
| `ms-vscode.powershell` | PowerShell language support |
| `ms-azuretools.vscode-azureresourcegroups` | Azure Resource Groups explorer |
| `ms-azuretools.vscode-bicep` | Bicep IaC language support |
| `ms-azure-devops.azure-pipelines` | Azure Pipelines support |
| `azure-sentinel.vscode-sentinel` | Microsoft Sentinel integration |
| `ms-azure-devops.azure-kusto-analytics` | KQL / Log Analytics queries |
| `redhat.vscode-yaml` | YAML language support |
| `dbaeumer.vscode-eslint` | ESLint integration |
| `esbenp.prettier-vscode` | Prettier code formatter |
| `hashicorp.terraform` | Terraform IaC support |
| `ms-vscode-remote.remote-containers` | Dev Containers support |
| `ms-azuretools.vscode-docker` | Docker integration |
| `eamodio.gitlens` | Enhanced Git tooling |
| `github.vscode-pull-request-github` | GitHub Pull Request integration |

---

### Environment variables

The following environment variables are forwarded from your **local machine** into the container. Set them in your shell profile (or in a `.devcontainer/.env` file, which is git-ignored) before opening the Dev Container.

| Variable | Description |
|---|---|
| `AZURE_TENANT_ID` | Microsoft Entra ID (Azure AD) tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Azure subscription ID |
| `AZURE_RESOURCE_GROUP` | Resource group containing the Sentinel workspace |
| `AZURE_WORKSPACE_NAME` | Log Analytics / Sentinel workspace name |
| `AZURE_WORKSPACE_ID` | Log Analytics workspace ID |

---

### Post-create setup

After the container is created, `.devcontainer/postCreate.sh` runs automatically and:

1. Runs `npm install` if a `package.json` is present in the workspace.
2. Configures global git defaults (`core.autocrlf = input`, `pull.rebase = false`).
3. Prints a reminder to authenticate with Azure:

   ```
   Run  'az login'  or  'az login --use-device-code'
   to authenticate with Azure before using Sentinel / MCP tools.
   ```

---

### Getting started

1. Install [VS Code](https://code.visualstudio.com/) and the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).
2. Set the required [environment variables](#environment-variables) on your local machine.
3. Open this repository folder in VS Code and, when prompted, choose **Reopen in Container** (or run the command `Dev Containers: Reopen in Container`).
4. Wait for the container to build and post-create scripts to finish.
5. Run `az login` (or `az login --use-device-code`) to authenticate with Azure.
6. You are ready to develop Security Copilot agents with all tools and MCP configuration in place.
