# Visma Service Restarter
# Tries to gracefully stop and start services, but will kill the services if they refuse to stop within a reasonable amount of time
# For Visma services on Windows Servers - Visma Business/Visma Document Centre
# by Chris Hustad - @attak1t // github
# Last Edit: 01.06.2023

# Specify the list of service names
$serviceNames = "SingleSignOnService", "OPGatewayService", "VismaBusinessServicesHost", "VismaBusinessHostODMessageQueue", "VismaBusinessServicesHostSyncEngine", "VismaWorkflowServerService", "VismaWorkflowServerAutoimportService", "VismaWorkflowServerAutoinvoiceService", "VismaWorkflowServerDocumentCountService", "VismaWorkflowServerODBridgeService", "VismaUpdateService"

# Specify the corresponding list of process names
$processNames = "Visma.Services.UserDirectory.Server.SingleSignOnServiceWcf", "Visma.BusinessHost", "Visma.Services.OPGateway.OPGatewayService", "Visma.BusinessHost.MessageQueue", "Visma.BusinessHost.SyncEngineService", "Visma.Workflow.Server", "Visma.Workflow.Server.AutoimportService", "Visma.Workflow.Server.AutoinvoiceService", "Visma.Workflow.Server.DocumentCountService", "Visma.Workflow.Server.ODBridgeService", "Visma.Services.VismaUpdate.Service.Host"

# Stop services and kill associated processes
foreach ($i in 0..($serviceNames.Length - 1)) {
    $serviceName = $serviceNames[$i]
    $processName = $processNames[$i]

    # Attempt to stop the service
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if ($service -ne $null) {
        if ($service.Status -eq 'Running' -and $service.CanStop) {
            $service.Stop()
            Write-Host "Stopping $serviceName"
            Start-Sleep -Seconds 30  # Give each service 30 seconds to stop before forcing it to
        }
    }

    # Check if the process is still running
    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($process -ne $null) {
        $process.Kill()
        Write-Host "Terminated process associated with $serviceName"
    }
}

# Wait for 60 seconds before starting the services again
Write-Host "Waiting for a minute before starting all the services again."
Start-Sleep -Seconds 60
Write-Host "It's been a minute. Starting the services again."

# Start services again
foreach ($serviceName in $serviceNames) {
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if ($service -ne $null) {
        $service.Start()
        Write-Host "Starting $serviceName"
    }
}
