import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!

    var announcement: CampusAnnouncement?
    var studentName: String = ""
    var notificationsEnabled: Bool = false
    var selectedRole: String = ""
    var preferredEventDate: Date = Date()
    var numberOfGuests: Int = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let announcement = announcement {
            title = announcement.category
            messageLabel.text = """
            \(announcement.title)
            \(announcement.category) • \(announcement.date)
            """
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
}
