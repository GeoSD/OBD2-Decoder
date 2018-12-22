//
//  AboutOBDViewController.swift
//  OBD2 Decoder
//
//  Created by Georgy Dyagilev on 22/12/2018.
//  Copyright © 2018 Georgy Dyagilev. All rights reserved.
//

import UIKit

class AboutOBDViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLayoutSubviews() {
        textView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
}
