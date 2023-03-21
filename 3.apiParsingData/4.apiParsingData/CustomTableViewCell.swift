//
//  CustomTableViewCell.swift
//  4.apiParsingData
//
//  Created by Rajeev on 17/03/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet var apiImage: UIImageView!
    @IBOutlet var apiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
