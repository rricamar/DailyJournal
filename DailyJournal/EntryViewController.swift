import UIKit


class EntryViewController: UIViewController {
    @IBOutlet weak var entryDatePicker: UIDatePicker!
    @IBOutlet weak var entryTextView: UITextView!
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isCreate() {
            
        } else {
            entryTextView.text = entry!.text
            
            if let entryDate = entry!.date {
                entryDatePicker.date = entryDate
            }
        }
    }

    
    
    override func viewWillDisappear(_ animated: Bool) {
        let delegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        
        if isCreate() {
            if let viewContext = (delegate)?.persistentContainer.viewContext {
                let entry = Entry(context: viewContext)
                entry.date = entryDatePicker.date
                entry.text = entryTextView.text
            }
        }
        
        (delegate)?.saveContext()
    }
    
    fileprivate func isCreate() -> Bool { return entry == nil }
    
    @IBAction func deleteTapped(_ sender: Any) {
        if !isCreate() {
            let delegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
            
            if let viewContext = (delegate)?.persistentContainer.viewContext {
                viewContext.delete(entry!)
                try? viewContext.save()
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
}
