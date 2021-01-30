FROM mcr.microsoft.com/powershell

# Install Pester and force to bypass confirmation
RUN \
    pwsh -c "Install-Module -Name Pester -Force" \
    && pwsh -c "Import-Module Pester -PassThru"
