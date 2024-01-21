
//
//  PaddingLabel.swift
//  ADVA
//
//  Created by iOSAYed on 17/01/2024.
//

import UIKit

class PaddedLabel: UILabel {
    // Set the default padding
    var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: padding)
        return super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
    }
}
