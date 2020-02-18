//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

/* -- Comment -- */

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate, LocationsViewControllerDelegate {
    
    /* ---- TODO: Create mapView outlet*/

    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var photoButton: UIButton!
    // Store picked image
    var pickedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        photoButton.layer.cornerRadius = 45.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.setInitialLocation()
        }
        
        mapView.delegate = self
    }
    
    
    /* ------ TODO: Set initial location after launching app */
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
    
    
       
    /* ----- TODO: Instantiate UIImagePicker after camera button tapped */
    @IBAction func PhotoPressed(_ sender: Any) {
         selectPhoto()
    }

    
    
    /* ----- TODO: Override prepare (for segue) funcion to show Present LocationsViewController */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let locationViewController = segue.destination as! LocationsViewController
        
        locationViewController.delegate = self
    }
    
    
    
    /* ----- TODO: Retrieve coordinates from LocationsViewController   */
    func LocationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber) {
        
        addPin(lat: CLLocationDegrees(latitude), lng: CLLocationDegrees(longitude))
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    /* ----- TODO: add pin to the map */
    func addPin(lat: CLLocationDegrees, lng: CLLocationDegrees) {
        
        
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        annotation.coordinate = locationCoordinate
        //thing that shows up on the pin
        annotation.title = String(describing: lat)
        
        //give permission to our view controller to midify the map view
        
        mapView.addAnnotation(annotation)
    }
    
    
    
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
    
    
    
    
    // Instantiate Image Picker and set delegate to this view controller
    func selectPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // Present camera, if available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            imagePicker.sourceType = .camera
            
            // Present photo library
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            imagePicker.sourceType = .photoLibrary
            // Present imagePicker source type (either camera or library)
        }
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        // Get the image captured by the UIImagePickerController
        let _ = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage
        let editedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as! UIImage
        
        // Do something with the images (based on your use case)
        pickedImage = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "tagSegue", sender: nil)
        
    }

}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
