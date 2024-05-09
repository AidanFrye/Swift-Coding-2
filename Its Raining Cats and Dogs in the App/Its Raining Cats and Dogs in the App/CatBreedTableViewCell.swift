//
//  CatBreedTableViewCell.swift
//  Its Raining Cats and Dogs in the App
//
//  Created by lab on 3/12/24.
//

import UIKit

class CatBreedTableViewCell: UITableViewCell {

    @IBOutlet weak var CatBreedImageView: UIImageView!
    @IBOutlet weak var CatBreedNameLabel: UILabel!
    @IBOutlet weak var CatBreedDescriptionLabel: UILabel!
    
    var catImages: [CatImage] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with cat: CatInfo, catImages: CatImage)
    {
        CatBreedNameLabel.text = cat.id
        CatBreedDescriptionLabel.text = cat.desc
        Task {
            let picture = try await CatImageInfoController().fetchImage(from: catImages.url)
            CatBreedImageView.image = picture
        }
    }
}
