<#
To Do:
    1. New-PoshWSUSLocalPackage
    2. Get-PoshWSUSLocalPackage
    3. Get-PoshWSUSUpdateApproval
    4. Set-PoshWSUSConfiguration
    5. New-PoshWSUSClient
#>

#Validate user is an Administrator
Write-Verbose "Checking Administrator credentials"
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You are not running this as an Administrator!`nPlease re-run module with an Administrator Account."
    Break
}

#Load Functions
$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
Try {
    Get-ChildItem "$ScriptPath\Scripts" | Select -Expand FullName | ForEach {
        $Function = Split-Path $_ -Leaf
        . $_
    }
} Catch {
    Write-Warning ("{0}: {1}" -f $Function,$_.Exception.Message)
    Continue
}