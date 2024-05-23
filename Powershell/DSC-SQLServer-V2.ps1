Configuration Main {
    param (
        [string]$adminUsername,
        [string]$adminPassword,
        [string]$sqlServerCollation,
        [int]$memoryCapMB
    )

    Import-DscResource -ModuleName 'PSDscResources'
    Import-DscResource -ModuleName 'xSQLServer'

    Node localhost {
        WindowsFeature 'NetFramework45' {
            Name   = 'NET-Framework-45-Core'
            Ensure = 'Present'
        }

        xSQLServerSetup 'InstallSQLServer' {
            InstanceName        = 'MSSQLSERVER'
            Features            = 'SQLENGINE,REPLICATION,FULLTEXT'
            SQLCollation        = $sqlServerCollation
            SQLSysAdminAccounts = $adminUsername
            InstallSQLDataDir   = 'D:\MSSQLData'
            SQLUserDBDir        = 'D:\MSSQLData'
            SQLUserDBLogDir     = 'E:\MSSQLLog'
            SQLTempDBDir        = 'D:\MSSQL\TempDB'
            SQLTempDBLogDir     = 'D:\MSSQL\TempDB'
            AgtSvcStartupType   = 'Automatic'
            SQLSvcAccount       = New-Object System.Management.Automation.PSCredential ("$adminUsername", (ConvertTo-SecureString "$adminPassword" -AsPlainText -Force))
            SQLSysAdminAccounts = $adminUsername
        }

        xSQLServerMemory 'SetMaxMemory' {
            SQLInstanceName = 'MSSQLSERVER'
            DynamicAlloc = $false
            MaxMemory = $memoryCapMB
            DependsOn = '[xSQLServerSetup]InstallSQLServer'
        }
    }
}

Main -OutputPath 'C:\DSCConfig'
