//
//  TextFieldDemoViewController.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 25/07/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

class TextFieldDemoViewController: UIViewController {
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
 
    override func viewDidAppear(_ animated: Bool) {
        descriptionTextField.becomeFirstResponder()
    }

    @IBAction func viewTapped(sender: AnyObject) {
        view.endEditing(true)        
    }
}

extension TextFieldDemoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === descriptionTextField {
            amountTextField.becomeFirstResponder()
        } else if textField === amountTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = (textField.text ?? "") as NSString
        let newString = nsString.replacingCharacters(in: range, with: string)
        
        if textField === descriptionTextField {
            return newString.characters.count <= 20
            
        } else if textField === amountTextField {
            // allows field to be completely cleared
            guard !newString.isEmpty else { return true }

            // only numeric and decimal characters
            guard newString.range(of: "^[0-9\\.]*$", options: .regularExpression) != nil else { return false }

            // can convert to a Double (e.g. prevents "1.2.3")
            return Double(newString) != nil

        } else {
            return true
        }
    }
    
}
