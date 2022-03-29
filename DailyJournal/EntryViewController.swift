import UIKit


class EntryViewController: UIViewController {
    @IBOutlet weak var entryDatePicker: UIDatePicker!
    @IBOutlet weak var entryTextView: UITextView!
    
    var entriesVc: EntriesTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        let entry = Entry()
        entry.date = entryDatePicker.date
        entry.text = entryTextView.text
        
        entriesVc?.entries.append(entry)
        entriesVc?.tableView.reloadData()
    }
}
