import UIKit
import MapKit
import CoreLocation

class StoreLocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var storeAddressListTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var storeLocations: [StoreLocation] =  Arrays.storeLocations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupMapView()
        setupLocationManager()
        showAllStoreLocationsOnMap()
    }
    
    func setupTableView() {
        storeAddressListTableView.delegate = self
        storeAddressListTableView.dataSource = self
        storeAddressListTableView.register(UINib(nibName: NibName.StoreLocationTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.StoreLocationTableViewCell)
    }
    
    func setupMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 500000) // Adjust as needed
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func showAllStoreLocationsOnMap() {
        for store in storeLocations {
            let annotation = MKPointAnnotation()
            annotation.title = store.name
            annotation.subtitle = store.address
            annotation.coordinate = store.coordinate
            mapView.addAnnotation(annotation)
        }
        if let firstLocation = storeLocations.first {
            mapView.setRegion(MKCoordinateRegion(center: firstLocation.coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000), animated: true)
        }
    }
    
    // UITableViewDataSource and UITableViewDelegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.StoreLocationTableViewCell, for: indexPath) as! StoreLocationTableViewCell
        let store = storeLocations[indexPath.row]
        cell.storeAddressLabel.text = store.address
        cell.StoreNameLabel.text = store.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let store = storeLocations[indexPath.row]
        mapView.setRegion(MKCoordinateRegion(center: store.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
    }
    
    // MKMapViewDelegate method to customize annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier.StoreLocationPin) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Identifier.StoreLocationPin)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    // Show options when annotation is tapped
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else { return }
        
        let alert = UIAlertController(title: annotation.title!, message: nil, preferredStyle: .actionSheet)
        
        let openInMapsAction = UIAlertAction(title: Title.OpenInMaps, style: .default) { _ in
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate))
            mapItem.name = annotation.title ?? Texts.EmptyString
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }
        
        let calculateDistanceAction = UIAlertAction(title: Title.CalculateDistance, style: .default) { [weak self] _ in
            guard let currentLocation = self?.locationManager.location else { return }
            let storeLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            let distance = currentLocation.distance(from: storeLocation)
            let distanceInKM = distance / 1000
            let distanceAlert = UIAlertController(title: Title.Distance, message: "You are \(String(format: "%.2f", distanceInKM)) km away from this location.", preferredStyle: .alert)
            distanceAlert.addAction(UIAlertAction(title: Title.ok, style: .default))
            self?.present(distanceAlert, animated: true)
        }
        
        alert.addAction(openInMapsAction)
        alert.addAction(calculateDistanceAction)
        alert.addAction(UIAlertAction(title: Title.Cancel, style: .cancel))
        
        present(alert, animated: true)
    }
}
