//
//  TransactionCell.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 18/07/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var seperatorHeightConstraint: NSLayoutConstraint!
    
    var descriptionString: String = "" {
        didSet {
            descriptionLabel.text = descriptionString
        }
    }
    
    var amount: String = "" {
        didSet {
            amountLabel.text = amount
        }
    }

    var seperatorHidden: Bool = false {
        didSet {
            seperatorView.isHidden = seperatorHidden
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        seperatorHeightConstraint.constant = 1 / UIScreen.main.scale
    }

    // MARK: - Cell reuse

    override func awakeFromNib() {
        resetCell()
    }

    override func prepareForReuse() {
        resetCell()
    }

    private func resetCell() {
        descriptionString = ""
        amount = ""
        seperatorHidden = false
    }
    
}
