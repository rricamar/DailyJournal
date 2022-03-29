import UIKit

class EntriesTableViewController: UITableViewController {
    var entries: [Entry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = entries[indexPath.row]
        
        let cell = UITableViewCell()
        cell.textLabel?.text = entry.text
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let entryVc = segue.destination as? EntryViewController {
            entryVc.entriesVc = self
        }
    }
}
