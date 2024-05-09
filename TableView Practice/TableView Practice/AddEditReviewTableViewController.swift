//
//  AddEditReviewTableViewController.swift
//  TableView Practice
//
//  Created by lab on 2/8/24.
//

import UIKit

class AddEditReviewTableViewController: UITableViewController {

    var review: BookReview?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func textEditingChanged(_ sender: UITextField)
    {
        updateSaveButtonState()
    }
    
    init?(coder: NSCoder, review: BookReview?)
    {
        self.review = review
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let review = review {
            titleTextField.text = review.title
            authorTextField.text = review.author
            genreTextField.text = review.genre
            ratingTextField.text = String(review.rating)
            title = "Edit Review"
        }
        else
        {
            title = "Add Review"
        }
        updateSaveButtonState()
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveReviewUnwind" else {
            print("we sad")
            return }
        
        let title = titleTextField.text!
        let author = authorTextField.text ?? ""
        let genre = genreTextField.text ?? ""
        let rating = ratingTextField.text ?? ""
        print("we make it here yay")
        review = BookReview(title: title, author: author, genre: genre, rating: rating)
    }
    func updateSaveButtonState()
    {
        let titleText = titleTextField.text ?? ""
        let authorText = authorTextField.text ?? ""
        let genreText = genreTextField.text ?? ""
        let ratingText = ratingTextField.text ?? ""
        saveButton.isEnabled = !titleText.isEmpty && !authorText.isEmpty && !genreText.isEmpty && !ratingText.isEmpty
    }

}
