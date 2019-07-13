# Auto-scale Azure SignalR
A Logic App that auto-scales Azure SignalR based on concurrent connection count.

## !!! Warning !!!
Azure SignalR Service Units are **billed by day**, not hour, and not part of hour.  Any change to unit count will be immediately reflected on your bill.  As such, by default this tool will auto-scale to a maximum of 5 units.  You can override this with the `maxUnits` parameter if, bling bling, money ain't no thing.

Additionally, **SignalR Service can only be scaled to unit counts of 1, 2, 5, 10, 20, 50, 100**, so by passing 5900 concurrent connections will scale you to 10 units, because 6 is not a valid unit count.

## Usage
The Logic App will use Azure REST APIs to query and modify your SignalR Service's connections and unit capacity respectively.  Add a service principal that will authenticate with Azure REST API on your behalf:

```
az ad sp create-for-rbac -n "azure-signalr-logic-apps"
```

The above will output the values you need to create yourself a `parameters.json`, for supplying the parameters expected by `template.json`.  At a minimum you'll need `rest-authentication` and `signalrName` which represents the SignalR Service you want to auto-scale.

You can then deploy the logic app to your resource group:

```bash
az group deployment create --resource-group yourResourceGroup --template-file template.json --parameters @parameters.json
```

You can test different `scaleIntervals` and `maxUnits` (see warning above) if you wish by passing those parameters along with the deployment command above

```
az group deployment create --resource-group yourResourceGroup --template-file template.json --parameters @parameters.json --parameters scaleInterval=10 --parameters maxUnits=5
```
