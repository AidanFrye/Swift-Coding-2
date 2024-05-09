//
//  ViewController.swift
//  Space APOD App
//
//  Created by lab on 2/20/24.
//

import UIKit

//DO CONSTRAINTS AGAIN, SCROLL VIEW -> STACK VIEW -> IMAGE VIEW

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var button: UIButton!
    
    let photoInfoController = PhotoInfoController()
    
    var spaceFormatter = DateFormatter()
    
    var dateToUse = ""
    
    
    @IBAction func updateDate(_ sender: Any)
    {
        Task {
            spaceFormatter.dateFormat = "y-M-dd"
            dateToUse = spaceFormatter.string(from: datePicker.date)
            print("\(dateToUse) the first time")
            let photoInfo = try await photoInfoController.fetchPhotoData(date: dateToUse)
            updateUI(with: photoInfo)
            print("\(dateToUse) the second time")
            //the api was acting up, but I'm pretty sure the date picker functions
        }
        print("\(dateToUse) the third time")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        imageView.image = UIImage(systemName: "photo.on.rectangle")
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        
        Task{
            do {
                let photoInfo = try await photoInfoController.fetchPhotoData()
                updateUI(with: photoInfo)
            }
            catch {
                updateUI(with: error)
            }
        }
    }
        
        
        
        func updateUI(with photoInfo: PhotoInfo) {
            
            Task {
                do {
                    let image = try await photoInfoController.fetchImage(from: photoInfo.url)
                    imageView.image = image
                    title = photoInfo.title
                    descriptionLabel.text = photoInfo.description
                    copyrightLabel.text = photoInfo.copyright
                } catch {
                    updateUI(with: error)
                }
            }
        }
        
        func updateUI(with error: Error) {
            title = "Error Fetching Photo"
            imageView.image = UIImage(systemName:"exclamationmark.octagon")
            descriptionLabel.text = error.localizedDescription
            copyrightLabel.text = ""
        }
    }


