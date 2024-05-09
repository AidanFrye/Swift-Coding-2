//
//  EmojiCell.swift
//  Emoji Dictionary
//
//  Created by lab on 1/25/24.
//

import UIKit

class EmojiCell: UITableViewCell {


    @IBOutlet weak var emojiSymbol: UILabel!
    @IBOutlet weak var emojiName: UILabel!
    @IBOutlet weak var emojiDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with emoji: Emoji)
    {
        emojiSymbol.text = emoji.symbol
        emojiName.text = emoji.name
        emojiDescription.text = emoji.description
    }
    
}
