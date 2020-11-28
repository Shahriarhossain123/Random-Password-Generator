//
//  BookmarkVCell.swift
//  Random Password Generator
//
//  Created by Shishir_Mac on 11/16/20.
//

import UIKit

class BookmarkVCell: UITableViewCell {
    @IBOutlet weak var viewConten: UIView!
    @IBOutlet weak var labelTagName: UILabel!
    @IBOutlet weak var labelTagPassword: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewConten.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
