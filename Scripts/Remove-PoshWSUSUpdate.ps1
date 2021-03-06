function Remove-PoshWSUSUpdate {
    <#  
    .SYNOPSIS  
        Removes an update on WSUS.
        
    .DESCRIPTION
        Removes an update on WSUS.
        
    .PARAMETER Update
        Name of update being removed. 
              
    .NOTES  
        Name: Remove-PoshWSUSUpdate
        Author: Boe Prox
        DateCreated: 24SEPT2010 
        
        To Do:
            Allow for better use of pipelining. ex: Get-PoshWSUSUpdate -Update 986569 | Remove-PoshWSUSUpdate
               
    .LINK  
        https://learn-powershell.net
        
    .EXAMPLE  
    Remove-PoshWSUSUpdate -update "KB986569"

    Description
    ----------- 
    This command will remove all instances of KB986569 from WSUS.
           
    #> 
    [cmdletbinding(
    	DefaultParameterSetName = 'update',
    	ConfirmImpact = 'low',
        SupportsShouldProcess = $True
    )]
        Param(
            [Parameter(
                Mandatory = $True,
                Position = 0,
                ParameterSetName = 'update',
                ValueFromPipeline = $True)]
                [string]$Update                                          
                ) 
    Begin {
        #Gather all updates from given information
        Write-Verbose "Searching for updates"
        $patches = $wsus.SearchUpdates($update)
    }            
    Process {
        ForEach ($patch in $patches) {
            #Storing update guid
            $guid = ($patch.id).updateid              
            If ($pscmdlet.ShouldProcess($($patch.title))) {
                $wsus.DeleteUpdate($guid,$True)
                "$($patch.title) has been deleted from WSUS"
            }         
        }
    }    
} 
