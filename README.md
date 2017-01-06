# Tookan Tracking

**Tookan Tracking SDK for iOS.**

## Example ##

```swift
import TookanTracker

//Initialize the LocationTrackerFile Variable
  var loc = LocationTrackerFile.sharedInstance(apiKey: "api-key")

  let response = self.loc.startTracking(jobId: "job-id")
                print(response)
                if(response.isAuthorized == true) {
                    //Authorization successfull
                } else {
                    //Authorization Failed
                    print(response.message)
                }


//To recieve location
func onLocationArrive(_ locations: [CLLocation],message:String) {

}

//On job completion
func onJobComplete() {

}
```
## Installation

Requires Swift 3/Xcode 8.x

1. Drag and drop the TookanTracker.framework and CocoaAsyncSocket.framework to your project.

2. Add TookanTracker.framework in embedded libraries.

3. Import TookanTracker module to your file.

4. inherit the LocationTrackerDelegate protocol to your view controler.

## Delegate Functions

*  **onLocationArrive** - Delegate function for recieving the array of agent's latitude and longitude .

*  **onJobComplete**    - Delegate funtion which is called when the job is successfully completed.  


## Methods ##

 * **sharedInstance(apiKey: String)** - Returns the instance of locationTrackerFile and sets the api-key. You can obtain this API Key from your Tookan Dashboard - https://app.tookanapp.com/#/app/settings/apikey. 
 
 * **startTracking(jobId:String) -> (isAuthorized:Bool,message:String))** - Starts the authentication process and returns the isAuthorized and message variable.
 
 * **stopTrackingService()** - Stop the tracking service.
