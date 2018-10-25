//
//  MapViewController.swift
//  BusSchedules
//
//  Created by Daniil Subbotin on 04/08/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit
import MapKit
import Foundation
import UserNotifications

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private var pathViewController: PathViewController?
    
    private var stationsNearServiceCall: ServiceCall?
    private var currentCenterPoint: CLLocation?
    private var annotations: [StationAnnotation]?
    
    private let moscowRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.915215,
                                       longitude: 37.744741),
        span: MKCoordinateSpan(latitudeDelta: 0.05,
                               longitudeDelta: 0.05)
    )
    
    var appState: AppState?
    
    private var fromStation: Station? {
        didSet {
            appState?.fromStation = fromStation
            pathViewController?.update()
        }
    }
    private var toStation: Station? {
        didSet {
            appState?.toStation = toStation
            pathViewController?.update()
        }
    }
    
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let pathVC = children.first as? PathViewController else  {
            fatalError("Check storyboard for missing PathViewCOntroller")
        }
        
        pathViewController = pathVC
        pathViewController?.appState = appState
        
        initMap()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stationsNearServiceCall?.cancel()
    }
    
    func initMap() {
        mapView.setRegion(moscowRegion, animated: false)
        mapView.delegate = self
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        mapView.deselectAnnotation(view.annotation, animated: false)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "PathElementViewController") as? PathElementViewController {
            
            guard let annotation = view.annotation as? StationAnnotation else { return }
            
            if let title = annotation.title {
                vc.setStationName(title)
            }
            
            vc.transitioningDelegate = slideInTransitioningDelegate
            vc.modalPresentationStyle = .custom
            vc.completionHandler = { element in
                if element == PathElement.start {
                    self.fromStation = annotation.station
                } else if element == PathElement.finish {
                    self.toStation = annotation.station
                }
                
                if self.fromStation != nil && self.toStation != nil {
                    self.tabBarController?.selectedIndex = 1
                }
            }
            present(vc, animated: true, completion: nil)
        }
    }
    
    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
        let annotation = MKClusterAnnotation(memberAnnotations: memberAnnotations)
        return annotation
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKClusterAnnotation {
            return BusStopClusterView(annotation: annotation, reuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        } else {
            return BusStopAnnotationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        }
    }
    
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        
        // if zoom = street view
        if (mapView.region.span.latitudeDelta < 0.027) {
            
            let newLocation = CLLocation(latitude: mapView.region.center.latitude,
                                         longitude: mapView.region.center.longitude)
            
            var distance: CLLocationDistance?
            if let point = currentCenterPoint {
                distance = newLocation.distance(from: point)
            }
            
            // If center is inside circle
            if distance == nil || distance! >= 5000 {
                
                if stationsNearServiceCall != nil {
                   stationsNearServiceCall?.cancel()
                }
                
                stationsNearServiceCall = RaspService.shared.stationsNear(
                    lat: mapView.region.center.latitude,
                    lng: mapView.region.center.longitude,
                    completion: stationsNearCompletion)
                
                currentCenterPoint = CLLocation(latitude: mapView.region.center.latitude,
                                                longitude: mapView.region.center.longitude)
                
            }
        }
    }
    
    func stationsNearCompletion(result: StationsNearServiceResult) {
        showStations(result.stationsNear?.stations)
    }
    
    func showStations(_ stations:[Station]?) {
        guard let stations = stations else { return }
        
        DispatchQueue.main.async {
            if self.annotations != nil {
                self.mapView.removeAnnotations(self.annotations!)
            }
            
            self.annotations = stations.map({ return StationAnnotation(station: $0) })
        
            self.mapView.addAnnotations(self.annotations!)
        }
    }
    
}

class StationAnnotation: MKPointAnnotation {
    let station: Station
    
    init(station: Station) {
        self.station = station
        super.init()
        coordinate = CLLocationCoordinate2D(latitude: station.lat!, longitude: station.lng!)
        title = station.title
    }
}
