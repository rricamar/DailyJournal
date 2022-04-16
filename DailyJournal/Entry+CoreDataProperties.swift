import CoreData
import Foundation

extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?

}

extension Entry: Identifiable {

    func month() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"

        if let dateToBeFormatted = date {
            return formatter.string(from: dateToBeFormatted).uppercased()
        }

        return "???"
    }

    func day() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"

        if let dateToBeFormatted = date {
            return formatter.string(from: dateToBeFormatted).uppercased()
        }

        return "??"
    }
}
