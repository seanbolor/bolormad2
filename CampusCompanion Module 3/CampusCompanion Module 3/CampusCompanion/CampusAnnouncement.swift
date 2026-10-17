import Foundation

struct CampusAnnouncement {
    let title: String
    let date: String
    let category: String
}

extension CampusAnnouncement {
    static let sampleAnnouncements: [CampusAnnouncement] = [
        CampusAnnouncement(
            title: "Enrollment Period Extended",
            date: "August 3, 2026",
            category: "Registrar"
        ),
        CampusAnnouncement(
            title: "Campus Wi-Fi Maintenance",
            date: "August 5, 2026",
            category: "IT Services"
        ),
        CampusAnnouncement(
            title: "Foundation Week Activities",
            date: "August 10, 2026",
            category: "Student Affairs"
        ),
        CampusAnnouncement(
            title: "Library Hours Update",
            date: "August 12, 2026",
            category: "Library"
        ),
        CampusAnnouncement(
            title: "Scholarship Application Deadline",
            date: "August 15, 2026",
            category: "Scholarships"
        ),
        CampusAnnouncement(
            title: "Career Fair Registration",
            date: "August 18, 2026",
            category: "Career Center"
        )
    ]
}
