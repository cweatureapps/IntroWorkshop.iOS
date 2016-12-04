//
//  TransactionSectionHeaderView.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 18/07/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

class TransactionSectionHeaderCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var daysAgoLabel: UILabel!

    var dateString: String = "" {
        didSet {
            dateLabel.text = dateString
        }
    }
    
    var daysAgo: String = "" {
        didSet {
            daysAgoLabel.text = daysAgo
        }
    }

}
