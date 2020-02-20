# Unit 6 - Photo Map
## Milestone 1: Get comfortable with the starter files

- **PhotoMapViewController**
    - Contains the MapView object
    - Configures the annotations(or pins)
    - Contains Image Picker methods
- **LocationsViewController**
    - Queries data from *FourSquare API*
        - Triggered by tapping on the search bar and calling the 'fetchLocations' method
        - Given city → returns JSON of places in that city + descriptions
    - Contains Tableview of data queried from the FourSquare API
- **FullImageViewController**
    - Bonus Feature
    - Adding a fullscreen image

## Milestone 2: Setup MapKit

1. Drag a MapKit object onto the PhotoMapVC + Drag to **ALL** corners
    - **DO NOT** apply constraints with constraints button
    - Control Drag: 'Map View' → 'View'
        - While holding shift, select four constraints

            ![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7f5f3958-b615-430d-94cd-89324413bd6b/Screen_Shot_2020-02-17_at_1.52.29_PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7f5f3958-b615-430d-94cd-89324413bd6b/Screen_Shot_2020-02-17_at_1.52.29_PM.png)

2. Hide the top navigation bar (modern look) - viewDidLoad() in PhotoMapVC. Notice that PhotoMapVC is a subclass of UINavigationControllerDelegate  
    ```Swift
    navigationController?.navigationBar.isHidden = true
    ```

3. Add Photo Button
    - Constraints

        ![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5d846ebd-0887-451f-bf5b-88af136e7c8e/Screen_Shot_2020-02-17_at_6.07.57_PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5d846ebd-0887-451f-bf5b-88af136e7c8e/Screen_Shot_2020-02-17_at_6.07.57_PM.png)

    - Change the background color to white
    - Create outlet to PhotoMapVC + Adjust button corner radius

        ```Swift
        override func viewDidLoad() {
            super.viewDidLoad()
                
            navigationController?.navigationBar.isHidden = true
                
            photoButton.layer.cornerRadius = 45.0
            //cornerRadius = Height / 2 , assuming square dimensions
        }
         ```

4. Set Initial Visible Region around UCI  
    ```Swift
    func setInitialLocation(){
        //UCI latitude & longitude
        let mapCenter = CLLocationCoordinate2D(latitude: 33.6405, longitude: -117.8443)
        // Note: One degree of latitude is approximately 111 kilometers (69 miles) at all times.
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            
        //Assign mapCenter & mapSpan to region of mapView
        let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
            
        // Set animated property to true to animate the transition to the region
        self.mapView.setRegion(region, animated: true)
    }
    ```

5. Call setInitialLocation() in viewDidLoad() of PhotoMapVC

    ```Swift
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationController?.navigationBar.isHidden = true
                
        photoButton.layer.cornerRadius = 45.0
                
        setInitialLocation()            
     }
     ```

    - EXTRA ANIMATION: Zooms into region instead of loading on region
        ```Swift
        override func viewDidLoad() {
            super.viewDidLoad()
            
            navigationController?.navigationBar.isHidden = true
            
            photoButton.layer.cornerRadius = 45.0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.setInitialLocation()
            }
        }
        ```

## Milestone 3: Configure Photo Button

1. Create modal segue from PhotoMapVC to LocationsVC
2. Set identifier of modal segue to 'tagSegue'
3. Connect button-pressed action to PhotoMapVC
    ```Swift
    @IBAction func PhotoPressed(_ sender: Any) {
        selectPhoto()
    }
    ```

4. Change parameter of Query to 'Irvine' instead of 'San Francisco'  
   ```Swift
   func fetchLocations(_ query: String, near: String = "Irvine"
   ```

## Milestone 4: Drop a Pin on the map

1. Add Protocol to the LocationsVC to communicate with PhotoMapViewController
    ```Swift
    protocol LocationsViewControllerDelegate: class {
        func LocationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber)
    }
    ```

2. Add delegate property to LocationsVC
    ```Swift
    weak var delegate: LocationsViewControllerDelegate!
    ```

3. PhotoMapVC inherits from the LocationsVCDelegate
    ```Swift
    class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate, LocationsViewControllerDelegate {
        func LocationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber) {
        <#code#>
    }
    ```

4. Create addPin Function to add the pin to the map
    ```Swift
    func addPin(lat: CLLocationDegrees, lng: CLLocationDegrees) {
            
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            
        annotation.coordinate = locationCoordinate
        //text that shows up on the pin
        annotation.title = String(describing: lat)
            
        //give permission to our view controller to modify the map view
        
        mapView.addAnnotation(annotation)
    }
    ```

5. Add the 'addPin' function to the 'locationsPickedLocation'
    ```Swift
    /* ----- TODO: Retrieve coordinates from LocationsViewController   */
    func LocationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber) {
        
        addPin(lat: CLLocationDegrees(latitude), lng: CLLocationDegrees(longitude))
        	
        //dismiss locationsVC after pin is added
        controller.dismiss(animated: true, completion: nil)
    }
    ```

6. Call the LocationsPickedLocation method after user taps a tableview cell
    ```Swift
    // Set the latitude and longitude of the venue and send it to the protocol
    delegate.locationsPickedLocation(controller: self, latitude: lat, longitude: lng)
    ```

7. Override the Prepare func in the PhotoMapVC to configure the delegate
    ```Swift
    /* ----- TODO: Override prepare (for segue) funcion to show Present LocationsViewController */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let locationViewController = segue.destination as! LocationsViewController
            
        locationViewController.delegate = self
    }
    ```

## Milestone 5: Customize the annotations!

1. Set mapView delegate in PhotoMapVC ViewDidLoad()
    ```Swift
    mapView.delegate = self
    ```

2. Add customization function in PhotoMapVC
    ```Swift
    /* ----- TODO: Customize mapview to add custom map notations */
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
        let reuseID = "annotation"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
            
        //add content to the view
        if (annotationView == nil){
            //if there is nothing on the view, then create the view
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            //when you tap on it, it tells you a pop-up
            annotationView!.canShowCallout = true
            annotationView!.leftCalloutAccessoryView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        }
            
            
        //insert the picture into the annotationview
        let imageView = annotationView?.leftCalloutAccessoryView as! UIImageView
        imageView.image = pickedImage
            
        return annotationView
    }
    ```

3. Run Application
    - Notice how the annotation changed when you click it
