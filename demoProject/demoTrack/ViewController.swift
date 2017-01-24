/*NOTE:

1.Drag and drop the TookanTracker.framework and CocoaAsyncSocket.framework to your project.
2.Add TookanTracker.framework in embedded libraries.
3.Import TookanTracker module to your file.
4.inherit the LocationTrackerDelegate protocol to your view controler.
5.Define the onLocationArrive and onJobComplete Delegate functions.
6.Get the locationTrackerFile Variable by calling LocationTrackerFile.sharedInstance() , and set the api key .
7.Give its delegate to self.
8.call the startTracking function of locationTrackingFile and pass the job id in it and check the response, if responese is Autherized then the tracking would start.
9.you would recieve the updated lat  long in the onLocationArrive function and if the job was completed successfully the onJobComplete function would be called.
10.to stop the tracking call stoptrackingservice function.
 */


import UIKit
import  CoreLocation



import TookanTracker
import GoogleMaps


class ViewController: UIViewController,LocationTrackerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    
    //Initialize the LocationTrackerFile Variable , you could get the api-key from https://app.tookanapp.com/#/app/settings/apikey
    var loc = LocationTrackerFile.sharedInstance(apiKey: "2bb9d611bbada3c385f0b5291f1ea75640ad9d0e87f8ad1d407cd5ea10c3b4c7")
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loc.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func textFieldHandler(textField: UITextField!)
    {
        if (textField) != nil {
            textField.text = ""
        }
    }
    
    
    @IBAction func startTracking(_ sender: UIButton) {
        let alert = UIAlertController(title: "Enter your job id", message: "", preferredStyle:
            UIAlertControllerStyle.alert)
        alert.addTextField(configurationHandler: textFieldHandler)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
            if alert.textFields?[0].text != ""{
                print(alert.textFields![0].text!)
                
                //Get authorised for getting coordinates
                 let response = self.loc.startTracking(jobId: "\(alert.textFields![0].text!)")
                print(response)
                if(response.isAuthorized == true) {
                    //Authorisation successfull
                } else {
                    //Authorisation Failed
                    print(response.message)
                    UIAlertView(title: "", message: response.message, delegate: self, cancelButtonTitle: "OK").show()
                }
            }
            
        }))
        
        self.present(alert, animated: true, completion:nil)
    }
    
    //Did recieve tracking coordinates
    func onLocationArrive(_ locations: [CLLocation],message:String) {
        print(locations)
        print(message)
        if locations.count > 0{
        longLabel.text = "\(locations[locations.count - 1].coordinate.latitude)"
        latLabel.text = "\(locations[locations.count - 1].coordinate.longitude)"
            mapView.clear()
            let currentMarker = GMSMarker()
            currentMarker.position = locations[locations.count - 1].coordinate
            currentMarker.map = self.mapView
            let camera = GMSCameraPosition.camera(withLatitude: locations[locations.count - 1].coordinate.latitude, longitude: locations[locations.count - 1].coordinate.longitude, zoom: 15)
            self.mapView.animate(to: camera)
        }
    }
    
    //Job completed succesfully
    func onJobComplete() {
        UIAlertView(title: "", message: "Job completed Successfully.", delegate: self, cancelButtonTitle: "OK").show()
    }
    
    @IBAction func stopTracking(_ sender: AnyObject) {
        //For stoping the track service
        loc.stopTrackingService()
    }
    
    

}

