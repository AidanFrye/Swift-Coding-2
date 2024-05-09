//
//  LifeFormTableViewCell.swift
//  Life Form Search
//
//  Created by lab on 4/2/24.
//

import UIKit

class LifeFormTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var scientificNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = "Name"
        scientificNameLabel.text = "Name2"
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updatexiv()
    {
        nameLabel.text = "Name"
        scientificNameLabel.text = "Name2"
    }
    
}
