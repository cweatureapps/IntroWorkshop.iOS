//
//  NibDesignableView.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 14/03/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import UIKit

/// Subclass `NibDesignableView` for views which need to render in the designer.
@IBDesignable
class NibDesignableView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /// Replaces the view with one loaded from a Nib file with the same name as the class.
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        super.awakeAfter(using: aDecoder)
        return viewFromNib()
    }

    // MARK: - Designable support

    /**
    The view loaded from the Nib in the designer.
    Subclass can override the `didSet` so that it can set any `IBOutlet` of the view,
    by referencing the ones which are connected to the `designerView`.
    */
    var designerView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = viewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        _setDesignerView(view)
        addSubview(view)
    }

    private func _setDesignerView(_ view: UIView) {
        self.designerView = view
    }
}
