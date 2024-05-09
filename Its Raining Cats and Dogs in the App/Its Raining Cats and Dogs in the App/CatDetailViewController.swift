//
//  CatDetailViewController.swift
//  Its Raining Cats and Dogs in the App
//
//  Created by lab on 3/22/24.
//

import UIKit

class CatDetailViewController: UIViewController {

    
    @IBOutlet weak var catDetaiImage: UIImageView!
    @IBOutlet weak var catDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = catInfo?.id
        catDetailLabel.text = catInfo?.desc
        Task{
            catDetaiImage.image = try await CatImageInfoController().fetchImage(from: catImage!.url)
        }
    }
    
    var catInfo: CatInfo?
    var catImage: CatImage?
    
    
    
    init?(coder: NSCoder, catInfo:CatInfo?, catImage: CatImage?)
    {
        self.catInfo = catInfo
        self.catImage = catImage
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
