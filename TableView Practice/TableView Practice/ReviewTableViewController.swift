//
//  ReviewTableViewController.swift
//  TableView Practice
//
//  Created by lab on 2/6/24.
//

import UIKit

class ReviewTableViewController: UITableViewController {

    var reviews: [BookReview] = []
    {
        didSet {
            BookReview.saveToFile(reviews: reviews)
        }
    }
    
    
    @IBSegueAction func addEditReview(_ coder: NSCoder, sender: Any?) -> AddEditReviewTableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let reviewToEdit = reviews[indexPath.row]
            return AddEditReviewTableViewController(coder: coder, review: reviewToEdit)
        } else {
            return AddEditReviewTableViewController(coder: coder, review: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        if let savedReviews = BookReview.loadFromFile() {
            reviews = savedReviews
        } else {
            reviews = BookReview.sampleReviews
        }
        title = "Book Reviews"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reviews.count
    }

    @IBAction func unwindToReviewTableView(segue:UIStoryboardSegue)
    {
        guard segue.identifier == "saveReviewUnwind", let sourceViewController = segue.source as? AddEditReviewTableViewController,
              let review = sourceViewController.review else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            reviews[selectedIndexPath.row] = review
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: reviews.count, section: 0)
            reviews.append(review)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath)

        // Configure the cell...
        let  review = reviews[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = "\(review.title) by \(review.author)"
        
        content.text?.append(" - \(review.rating) / 10")
        content.secondaryText = "\(review.genre)"
        cell.contentConfiguration = content

        return cell
    }
    
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            reviews.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedReview = reviews.remove(at: fromIndexPath.row)
        reviews.insert(movedReview, at: to.row)
    }


}
