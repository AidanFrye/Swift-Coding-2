//
//  ReviewTableViewCell.swift
//  TableView Practice
//
//  Created by lab on 2/6/24.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleAuthor: UILabel!
    @IBOutlet weak var bookGenre: UILabel!
    @IBOutlet weak var bookRating: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
