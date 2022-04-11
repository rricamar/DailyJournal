import UIKit

class EntriesTableViewController: UITableViewController {
    var entries: [Entry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as?
                          AppDelegate)?.persistentContainer.viewContext
        {
            
            if let entriesFromCoreData =
                try? context.fetch(Entry.fetchRequest())
            {
                entries = entriesFromCoreData
                tableView.reloadData()
            }
                                                            
        }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        performSegue(withIdentifier: "segueToEntry", sender: entry)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let entryVc = segue.destination as? EntryViewController {
            if let entryToBeSent = sender as? Entry {
                entryVc.entry = entryToBeSent
            }
        }
    }
}
