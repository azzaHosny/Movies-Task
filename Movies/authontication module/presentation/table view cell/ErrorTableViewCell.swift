//
//  ErrorTableViewCell.swift
//  Movies
//
//  Created by SmartPan on 1/1/22.
//

import UIKit

class ErrorTableViewCell: UITableViewCell {

    @IBOutlet weak var errorTextLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(error: String) {
        errorTextLB.text = error
    }
    
}
