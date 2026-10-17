
import UIKit

class AnnouncementsViewController: UITableViewController {

    private let announcements = CampusAnnouncement.sampleAnnouncements

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Campus Announcements"
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return announcements.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "AnnouncementCell",
            for: indexPath
        ) as! AnnouncementCell

        let announcement = announcements[indexPath.row]
        cell.configure(with: announcement)

        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let detailVC = storyboard!.instantiateViewController(
            withIdentifier: "AnnouncementDetail"
        ) as! DetailViewController

        detailVC.announcement = announcements[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

