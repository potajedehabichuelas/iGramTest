//
//  MediaCollectionViewCell.swift
//  iGram
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MediaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        self.activityIndicator.type = .ballZigZagDeflect
    }
}
