import Foundation
import UIKit

fileprivate let toolbarHeight: CGFloat = 50

extension UITextField {
    
    func addDoneToolbar(onDone: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        let toolbar = UIToolbar(frame:CGRect(x: 0,
                                             y: 0,
                                             width: UIScreen.main.bounds.width,
                                             height: toolbarHeight))
//        toolbar.barStyle = .
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done",
                            style: .done,
                            target: onDone.target,
                            action: onDone.action)
        ]
        toolbar.sizeToFit()
        self.keyboardAppearance = UIKeyboardAppearance.dark
        self.inputAccessoryView = toolbar
    }
    
    //MARK:- Default actions
    @objc func doneButtonTapped() { self.resignFirstResponder() }
}
