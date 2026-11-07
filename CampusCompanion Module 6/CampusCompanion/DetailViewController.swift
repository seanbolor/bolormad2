import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var campusMapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var announcement: CampusAnnouncement?
    var studentName: String = ""
    var notificationsEnabled: Bool = false
    var selectedRole: String = ""
    var preferredEventDate: Date = Date()
    var numberOfGuests: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let announcement = announcement {
            title = announcement.category ?? ""
            messageLabel.text = """
            \(announcement.title ?? "")
            \(announcement.category ?? "") • \(announcement.date ?? "")
            """
            
            let region = MKCoordinateRegion(
                center: CampusLocation.coordinate,
                latitudinalMeters: 500,
                longitudinalMeters: 500
            )
            campusMapView.setRegion(region, animated: false)

            let annotation = MKPointAnnotation()
            annotation.coordinate = CampusLocation.coordinate
            annotation.title = "Campus"
            campusMapView.addAnnotation(annotation)
            
            let libraryAnnotation = MKPointAnnotation()
            libraryAnnotation.coordinate = LibraryLocation.coordinate
            libraryAnnotation.title = "Campus Library"
            campusMapView.addAnnotation(libraryAnnotation)
            

            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            
            return
            
        }
        
        

        title = "Campus Events"

        let notificationStatus = notificationsEnabled ? "on" : "off"

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateText = formatter.string(from: preferredEventDate)

        messageLabel.text = """
        Welcome, \(studentName)! (\(selectedRole))
        Notifications: \(notificationStatus)
        Preferred Event Date: \(dateText)
        Number of Guests: \(numberOfGuests)
        """
    }
    
    private enum CampusLocation {
        static let coordinate = CLLocationCoordinate2D(
            latitude: 14.6255,
            longitude: 121.0034
        )
    }
    
    private enum LibraryLocation {
        static let coordinate = CLLocationCoordinate2D(
            latitude: 14.6260,
            longitude: 121.0040
        )
    }

    private let locationManager = CLLocationManager()
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()

        case .denied, .restricted:
            distanceLabel.text = "Location access denied."

        default:
            break
            
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let currentLocation = locations.first else { return }

        let campusLocation = CLLocation(
            latitude: CampusLocation.coordinate.latitude,
            longitude: CampusLocation.coordinate.longitude
        )

        let distanceInMeters = currentLocation.distance(from: campusLocation)

        distanceLabel.text = String(
            format: "You are approximately %.0f meters from campus.",
            distanceInMeters
        )
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        distanceLabel.text = "Unable to determine location."
    }
}
