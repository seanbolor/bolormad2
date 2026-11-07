import UIKit

class AnnouncementCell: UITableViewCell {

    @IBOutlet weak var categoryIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func configure(with announcement: CampusAnnouncement) {
        titleLabel.text = announcement.title ?? ""
        dateLabel.text = "\(announcement.category ?? "") • \(announcement.date ?? "") • \(announcement.location ?? "") • \(announcement.priorityLevel ?? "")"
        categoryIconImageView.image = UIImage(systemName: "megaphone.fill")
    }
}
