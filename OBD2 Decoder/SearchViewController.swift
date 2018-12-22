//
//  SearchViewController.swift
//  OBD2 Decoder
//
//  Created by Georgy Dyagilev on 22/12/2018.
//  Copyright © 2018 Georgy Dyagilev. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var blockTextField: UITextField!
    @IBOutlet weak var numbersTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    let blockCodes = ["B", "C", "P", "U"]
    
    
    let dataManager = DataManager()
    var obdErrors = [OBDError]()
    var searchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blockTextField.delegate = self
        numbersTextField.delegate = self
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        blockTextField.inputView = pickerView
        pickerView.selectRow(2, inComponent: 0, animated: true)
        blockTextField.text = "P"
        searchButton.isEnabled = false
        
        dataManager.fetchDataFromFile { (obdErrors) in
            self.obdErrors = obdErrors
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToResults" {
            
            let result = searchErrorWith(searchText)
            let resultsViewController = segue.destination as! ResultViewController
            resultsViewController.result = result
        }
    }
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ToInfo", sender: nil)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let blockText = blockTextField.text else { return }
        guard let numbersText = numbersTextField.text else { return }
        
        searchText = blockText + numbersText
        
        if searchText.count == 5 {
            performSegue(withIdentifier: "ToResults", sender: nil)
        } else {
            return
        }
    }
    
    func searchErrorWith(_ request: String) -> OBDError {
        var result: OBDError?
        result = obdErrors.first(where: { $0.code == request })
        if let resultError = result {
            return resultError
        } else {
            result = OBDError(code: request, englishDescription: "Nothig found.", russianDescription: "Ничего не найдено.")
            return result!
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == blockTextField {
            textField.becomeFirstResponder()
            textField.tintColor = UIColor.clear
        }
        
        if textField == numbersTextField {
            textField.inputView = nil
            textField.becomeFirstResponder()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == blockTextField {
            textField.resignFirstResponder()
        }
        
        if textField == numbersTextField {
            textField.resignFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == numbersTextField {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            return count <= 4
        }
        return true
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        
        if numbersTextField.text?.count == 4 {
            
            searchButton.isEnabled = true
        } else {
            searchButton.isEnabled = false
        }
    }
    
    
}

extension SearchViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return blockCodes.count
    }
}

extension SearchViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return blockCodes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        blockTextField.text = blockCodes[row]
    }
}
