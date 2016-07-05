//
//  FirstViewController.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 16/05/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // remove the back button text from the next page
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    @IBAction func unwindToFirstViewController(segue: UIStoryboardSegue) {
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? SecondViewController,
            segue.identifier == "segueToSecondPage" {
            destinationVC.something = "foobar"
        }
    }

}
