FROM fedora:latest

LABEL maintainer="Security Copilot Agent Dev Container"
LABEL description="Development environment for Microsoft Security Copilot agent development"

# ─── System packages ──────────────────────────────────────────────────────────
RUN dnf update -y && \
    dnf install -y \
        git \
        curl \
        wget \
        jq \
        unzip \
        zip \
        tar \
        sudo \
        less \
        vim \
        nano \
        python3 \
        python3-pip \
        nodejs \
        npm \
        openssh-clients \
        ca-certificates \
        gnupg2 \
        bind-utils \
        iputils \
        procps-ng \
        findutils \
        diffutils \
        'dnf-command(config-manager)' \
    && dnf clean all && \
    rm -rf /var/cache/dnf

# ─── GitHub CLI ───────────────────────────────────────────────────────────────
RUN dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo && \
    dnf install -y gh && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# ─── Azure CLI ────────────────────────────────────────────────────────────────
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    cat > /etc/yum.repos.d/azure-cli.repo << 'EOF'
[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
    dnf install -y azure-cli && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# ─── PowerShell ───────────────────────────────────────────────────────────────
RUN curl -sSL https://packages.microsoft.com/config/rhel/9/prod.repo \
        -o /etc/yum.repos.d/microsoft-prod.repo && \
    dnf install -y powershell && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# ─── PowerShell Azure & Sentinel modules ──────────────────────────────────────
# Installed to AllUsers scope so the sec-copilot user can use them
RUN pwsh -NoLogo -NonInteractive -Command " \
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted; \
    Install-Module -Name Az                   -Force -AllowClobber -Scope AllUsers; \
    Install-Module -Name Az.SecurityInsights  -Force -AllowClobber -Scope AllUsers; \
    Install-Module -Name Az.Accounts          -Force -AllowClobber -Scope AllUsers; \
    Install-Module -Name Az.Resources         -Force -AllowClobber -Scope AllUsers; \
    Install-Module -Name Az.Monitor           -Force -AllowClobber -Scope AllUsers; \
    Install-Module -Name Az.OperationalInsights -Force -AllowClobber -Scope AllUsers; \
    Install-Module -Name Microsoft.Graph      -Force -AllowClobber -Scope AllUsers; \
    Write-Host 'PowerShell modules installed successfully'"

# ─── Python packages for agent development ────────────────────────────────────
RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir \
        azure-identity \
        azure-mgmt-securityinsight \
        azure-mgmt-loganalytics \
        azure-monitor-query \
        msal \
        requests \
        pyyaml \
        python-dotenv \
        openai \
        semantic-kernel

# ─── Node.js global packages ──────────────────────────────────────────────────
RUN npm install -g \
        @azure/mcp \
        typescript \
        ts-node

# ─── Create non-root user: sec-copilot ────────────────────────────────────────
RUN useradd -m -s /bin/bash sec-copilot && \
    echo "sec-copilot ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/sec-copilot && \
    chmod 0440 /etc/sudoers.d/sec-copilot

USER sec-copilot
WORKDIR /home/sec-copilot

# Ensure the user's local bin is on PATH
ENV PATH="/home/sec-copilot/.local/bin:${PATH}"

CMD ["/bin/bash"]
