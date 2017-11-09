//
//  KamusTableViewCell.swift
//  KamusApp
//
//  Created by Jun  on 11/9/17.
//  Copyright © 2017 Arjuna. All rights reserved.
//

import UIKit

class KamusTableViewCell: UITableViewCell {

    @IBOutlet weak var indodesc: UILabel!
    @IBOutlet weak var inggrisdesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
