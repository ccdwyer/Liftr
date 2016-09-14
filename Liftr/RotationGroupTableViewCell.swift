//
//  RotationGroup.swift
//  Liftr
//
//  Created by Christopher Dwyer on 8/29/16.
//  Copyright © 2016 Christopher Dwyer. All rights reserved.
//

import UIKit

class RotationGroupTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setControlsAlpha(_ alpha: CGFloat) {
        titleLabel.alpha = alpha
        statusLabel.alpha = alpha
        arrowImageView.alpha = alpha
    }

}
