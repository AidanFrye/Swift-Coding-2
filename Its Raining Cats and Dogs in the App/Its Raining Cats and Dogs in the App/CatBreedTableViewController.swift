//
//  CatBreedTableViewController.swift
//  Its Raining Cats and Dogs in the App
//
//  Created by lab on 3/12/24.
//

import UIKit

class CatBreedTableViewController: UITableViewController {
    
    
    @IBSegueAction func viewCatDetails(_ coder: NSCoder, sender: Any?) -> CatDetailViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell)
        {
            let catToView = cats[indexPath.row]
            let imageToView = catImages[indexPath.row]
            return CatDetailViewController(coder: coder, catInfo: catToView, catImage: imageToView)
        }
        else {
            return CatDetailViewController(coder: coder, catInfo: nil, catImage: nil)
        }
    }
    
    var cats: [CatInfo] = []
    var catImages: [CatImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        title = "Cat Breeds"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func fetchData(){
        Task {
            do{
                cats = try await CatDataController().fetchCatData()
                for cat in 0...(cats.count-1)
                {
                    let cat = cats[cat]
                    let newID = try await CatImageInfoController().fetchPhotoData(id: cat.id)
                    catImages.append(contentsOf: newID)
                    print(catImages.count)
                }
                 
                tableView.reloadData()
                //reload data here because otherwise program runs without giving the task time to pull down
                //the cat data off the web. This reloads the tableViewData after the task has pulled it off
                //of the API, no matter how long that takes
            }
            catch {
                print("fetch failed with error \(error)")
                catImages = []
                fetchData()
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(cats.count)
        return cats.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("troubleshooting")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatBreedCell", for: indexPath) as! CatBreedTableViewCell
        
        let cat = cats[indexPath.row]
        print(catImages.count)
        let catImage = catImages[indexPath.row]
        
        cell.update(with: cat, catImages: catImage)
        cell.showsReorderControl = true
        
        return cell
    }
}

