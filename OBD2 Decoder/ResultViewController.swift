//
//  ResultViewController.swift
//  OBD2 Decoder
//
//  Created by Georgy Dyagilev on 22/12/2018.
//  Copyright © 2018 Georgy Dyagilev. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var englishDescriptionLabel: UILabel!
    @IBOutlet weak var russianDescriptionLabel: UILabel!
    
    
    var result: OBDError?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let result = result {
            updateUIWith(result)
        }
    }
    
    func updateUIWith(_ result: OBDError) {
        codeLabel.text = result.code
        englishDescriptionLabel.text = result.englishDescription
        russianDescriptionLabel.text = result.russianDescription
    }
    
}
