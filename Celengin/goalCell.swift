//
//  goalCell.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 05/04/22.
//

import UIKit

class goalCell: UITableViewCell {
    
    @IBOutlet weak var goalName: UILabel!
    @IBOutlet weak var deadline: UILabel!
    @IBOutlet weak var percent: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
