import UIKit


class EntryViewController: UIViewController {
    @IBOutlet weak var entryDatePicker: UIDatePicker!
    @IBOutlet weak var entryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let entry = Entry(context: context)
            entry.date = entryDatePicker.date
            entry.text = entryTextView.text
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
    }
}
