az group create -l westus -n azure-signalr
az signalr create --name autoscale --resource-group azure-signalr --sku Standard_S1
az signalr create --name autoscale-free --resource-group azure-signalr --sku Free_F1
az signalr key list -n autoscale -g azure-signalr --query primaryConnectionString -o tsv
az monitor metrics list --resource autoscale-free --resource-group azure-signalr --resource-type Microsoft.SignalRService/SignalR

https://blog.jongallant.com/2017/11/azure-rest-apis-postman/
az ad sp create-for-rbac -n "azure-signalr-logic-apps"
az ad sp reset-credentials --name "azure-signalr-logic-apps"

az account show --query id


dotnet bin\debug\netcoreapp3.0\BenchmarkServer.dll Azure:SignalR:ConnectionString=<connectionStringFromAbove>
dotnet bin\Debug\netcoreapp3.0\Crankier.dll local --target-url http://localhost:5000/echo
