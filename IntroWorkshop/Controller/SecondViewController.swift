//
//  SecondViewController.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 16/05/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var something: String?

    @IBOutlet weak var anotherLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        anotherLabel.text = something
    }
}
