Configuration SQLServerConfig {
    param (
        [Parameter(Mandatory = $true)]
        [string]$SqlInstanceName,

        [Parameter(Mandatory = $true)]
        [string]$adminUsername,

        [Parameter(Mandatory = $true)]
        [string]$adminPassword,

        [Parameter(Mandatory = $true)]
        [string]$sqlServerCollation,

        [Parameter(Mandatory = $true)]
        [int]$memoryCapMB
    )

    Import-DscResource -ModuleName 'xSQLServer'

    Node localhost {
        # Ensure the NetFramework is installed (required by SQL Server)
        WindowsFeature 'NetFramework' {
            Name   = 'NET-Framework-Features'
            Ensure = 'Present'
        }

        # Configure SQL Server Collation
        xSQLServerSetup 'SetSQLCollation' {
            InstanceName        = $SqlInstanceName
            SQLCollation        = $sqlServerCollation
            SQLSvcAccount       = PSCredential {
                UserName = $adminUsername
                Password = (ConvertTo-SecureString $adminPassword -AsPlainText -Force)
            }
            DependsOn           = '[WindowsFeature]NetFramework'
            Action              = 'Install'
            Force               = $true
        }

        # Configure SQL Server Memory Cap
        xSQLServerMemory 'SetSQLMemory' {
            InstanceName = $SqlInstanceName
            DynamicAlloc = $false
            MaxMemory    = $memoryCapMB
            DependsOn    = '[xSQLServerSetup]SetSQLCollation'
        }
    }
}

SQLServerConfig -OutputPath 'C:\DSCConfig'
