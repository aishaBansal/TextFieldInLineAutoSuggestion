//
//  ViewController.swift
//  AutoSuggestionInline
//
//  Created by Aishwarya on 14/07/22.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate{
    let suggestionsArray = [ "black", "blue","GREEN", "green", "yellow", "orange", "purple" , "greep", "greav"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return !autoCompleteText( in : textField, using: string, suggestionsArray: suggestionsArray)
    }
    func autoCompleteText( in textField: UITextField, using string: String, suggestionsArray: [String]) -> Bool {
            if !string.isEmpty,
                let selectedTextRange = textField.selectedTextRange,
                selectedTextRange.end == textField.endOfDocument,
                let prefixRange = textField.textRange(from: textField.beginningOfDocument, to: selectedTextRange.start),
                let text = textField.text( in : prefixRange) {
                let prefix = text + string
                let matches = suggestionsArray.filter {
                    $0.hasPrefix(prefix, caseSensitive: true)     //
//                    $0.hasPrefix(prefix)
                }
                if (matches.count > 0) {
                    textField.text = matches[0]
                    if let start = textField.position(from: textField.beginningOfDocument, offset: prefix.count) {
                        textField.selectedTextRange = textField.textRange(from: start, to: textField.endOfDocument)
                        return true
                    }
                }
            }
            return false
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
    }
    
}

extension String {
    
    
public func hasPrefix(_ prefix: String, caseSensitive: Bool) -> Bool {

if caseSensitive { return self.hasPrefix(prefix) }

let prefixRange = self.range(of: prefix, options: [.anchored, .caseInsensitive])
return prefixRange != nil
}
}
