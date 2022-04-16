import UIKit

class EntryViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var entryDatePicker: UIDatePicker!
    @IBOutlet weak var entryTextView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    var entry: Entry?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        if isCreate() {
            if let viewContext = (getDelegate())?.persistentContainer.viewContext {
                entry = Entry(context: viewContext)
                entry?.date = entryDatePicker.date
                entry?.text = entryTextView.text
                entryTextView.becomeFirstResponder()
            }
        }

        entryTextView.text = entry?.text

        if let entryDate = entry?.date {
            entryDatePicker.date = entryDate
        }

        entryTextView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        let delegate: AppDelegate? = getDelegate()
        (delegate)?.saveContext()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            bottomConstraint.constant = keyboardHeight
        }
    }

    @IBAction func deleteTapped(_ sender: Any) {
        if !isCreate() {
            if let viewContext = (getDelegate())?.persistentContainer.viewContext {
                viewContext.delete(entry!)
                try? viewContext.save()
            }
        }

        navigationController?.popViewController(animated: true)
    }

    @IBAction func dateValueChanged(_ sender: Any) {
        entry?.date = entryDatePicker.date
        getDelegate()?.saveContext()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        entry?.text = textView.text
        getDelegate()?.saveContext()
    }

    fileprivate func isCreate() -> Bool {
        return entry == nil
    }

    fileprivate func getDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}
