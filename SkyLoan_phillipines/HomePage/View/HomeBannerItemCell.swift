//
//  HomeBannerItemCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/15.
//

import UIKit
import FSPagerView

class HomeBannerItemCell: FSPagerViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.selectedBackgroundView = nil
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.contentMode = .scaleAspectFill
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
