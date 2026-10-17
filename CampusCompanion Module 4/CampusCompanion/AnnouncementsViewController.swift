import UIKit
import CoreData

class AnnouncementsViewController: UITableViewController {

    private var announcements: [CampusAnnouncement] = []

    private var context: NSManagedObjectContext {
        (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Campus Announcements"
        seedAnnouncementsIfNeeded()
        loadAnnouncements()
    }

    private func loadAnnouncements() {
        let request: NSFetchRequest<CampusAnnouncement> =
            CampusAnnouncement.fetchRequest()

        request.sortDescriptors = [
            NSSortDescriptor(key: "title", ascending: true)
        ]

        do {
            announcements = try context.fetch(request)
        } catch {
            print("Could not fetch announcements: \(error)")
        }

        tableView.reloadData()
    }

    private func seedAnnouncementsIfNeeded() {
        let request: NSFetchRequest<CampusAnnouncement> =
            CampusAnnouncement.fetchRequest()

        let count = (try? context.count(for: request)) ?? 0

        guard count == 0 else { return }

        let samples = [
            ("Library Hours Update", "Library", "August 12, 2026"),
            ("Campus Festival", "Events", "August 20, 2026"),
            ("Enrollment Reminder", "Academics", "August 25, 2026")
        ]

        for sample in samples {
            let announcement = CampusAnnouncement(context: context)
            announcement.title = sample.0
            announcement.category = sample.1
            announcement.date = sample.2
        }

        try? context.save()
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        announcements.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "AnnouncementCell",
            for: indexPath
        ) as! AnnouncementCell

        let announcement = announcements[indexPath.row]
        cell.configure(with: announcement)

        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)

        let detailVC = storyboard!.instantiateViewController(
            withIdentifier: "AnnouncementDetail"
        ) as! DetailViewController

        detailVC.announcement = announcements[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    @IBAction func addAnnouncementTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "New Announcement",
            message: "Enter announcement details",
            preferredStyle: .alert
        )

        alert.addTextField { $0.placeholder = "Title" }
        alert.addTextField { $0.placeholder = "Category" }
        alert.addTextField { $0.placeholder = "Date" }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            let announcement = CampusAnnouncement(context: self.context)

            announcement.title = alert.textFields?[0].text ?? ""
            announcement.category = alert.textFields?[1].text ?? ""
            announcement.date = alert.textFields?[2].text ?? ""

            try? self.context.save()
            self.loadAnnouncements()
        })

        present(alert, animated: true)
    }
    
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }

        let announcement = announcements[indexPath.row]
        context.delete(announcement)

        try? context.save()
        loadAnnouncements()
    }
}
