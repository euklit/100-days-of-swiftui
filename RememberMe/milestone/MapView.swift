//
//  MapView.swift
//  milestone
//
//  Created by Niklas Lieven on 14.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    var person: Person

    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: person.latitude!, longitude: person.longitude!) // mapView will only be called when person has a location so it should be safe to force unwrap
        mapView.setRegion(MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: 10000, longitudinalMeters: 10000), animated: false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = centerCoordinate
        annotation.title = person.name
        annotation.subtitle = "You met this person here."
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {

    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
//        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//            guard let placemark = view.annotation as? MKPointAnnotation else { return }
//
//            parent.selectedPlace = placemark
//            parent.showingPlaceDetails = true
//        }
        
//        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//
//            parent.centerCoordinate = mapView.centerCoordinate
//        }
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            //this is our unique identiefier for view reuse
            let identifier = "Placemark"
            
            // attempt to find a cell we can recycle
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                // we didnt find one; make a new one
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                // allow this to show pop up information
                annotationView?.canShowCallout = true
                
            } else {
                // we have a view to reuse, so give it the new annotation
                annotationView?.annotation = annotation
            }
            
            // whether its a new view or a recycled one, send it back
            return annotationView
        }
        

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(person: Person(imageData: (UIImage(systemName: "plus")?.jpegData(compressionQuality: 0.1))!, name: "Heino"))
    }
}


