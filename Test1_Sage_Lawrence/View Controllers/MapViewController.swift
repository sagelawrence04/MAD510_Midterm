//
//  MapViewController.swift
//  Test1_Sage_Lawrence
//
//  Created by Sage Lawrence on 2024-10-21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    //MARK: Properties
    var fanClub: FanClub? //allows me to access the passed value
    
    //MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        guard let fanClub = fanClub else {return}
        print("Latitude: \(fanClub.latitude), Longitude: \(fanClub.longitude)")

        
        let pinLocation = CLLocationCoordinate2D(latitude: fanClub.latitude, longitude: fanClub.longitude)
        let region = MKCoordinateRegion(center: pinLocation, latitudinalMeters: 1_000, longitudinalMeters: 1_000)
        mapView.setRegion(region, animated: true)
        
        let pin = MapPin(coordinate: pinLocation, title: fanClub.manager, subtitle: fanClub.address)
        mapView.addAnnotation(pin)
        
        mapView.isZoomEnabled = false
        mapView.isRotateEnabled = false
        mapView.isScrollEnabled = false
        mapView.mapType = .standard
    }

}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MapPin {
            let identifier = "mapPin"
            var view: MKMarkerAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true // Enable callout
            }
            
            return view
        }
        return nil
    }
}
