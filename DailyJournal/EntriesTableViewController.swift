import CoreData
import UIKit

class EntriesTableViewController: UITableViewController {
  
    var entries: [Entry] = []

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?
      .persistentContainer.viewContext
    {

      let request: NSFetchRequest<Entry> = Entry.fetchRequest()
      request.sortDescriptors = [
        NSSortDescriptor(key: "date", ascending: false)
      ]

      if let entriesFromCoreData =
        try? context.fetch(request)
      {
        entries = entriesFromCoreData
        tableView.reloadData()
      }

    }
  }

  override func tableView(
    _ tableView: UITableView, numberOfRowsInSection section: Int
  ) -> Int {
    return entries.count
  }

  override func tableView(
    _ tableView: UITableView, cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let entry = entries[indexPath.row]

    if let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell")
      as? EntryTableViewCell
    {
      cell.entryTextLabel.text = entry.text
      cell.monthLabel.text = entry.month()
      cell.dayLabel.text = entry.day()
      return cell
    } else {
      return UITableViewCell()
    }
  }

  override func tableView(
    _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
  ) {
    let entry = entries[indexPath.row]
    performSegue(withIdentifier: "segueToEntry", sender: entry)
  }

  override func tableView(
    _ tableView: UITableView, heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    return 100
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let entryVc = segue.destination as? EntryViewController {
      if let entryToBeSent = sender as? Entry {
        entryVc.entry = entryToBeSent
      }
    }
  }
}
