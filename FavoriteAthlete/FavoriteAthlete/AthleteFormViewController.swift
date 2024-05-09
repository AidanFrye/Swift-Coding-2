//
//  AthleteFormViewController.swift
//  FavoriteAthlete
//
//  Created by lab on 1/18/24.
//

import UIKit

class AthleteFormViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var leagueTextField: UITextField!
    @IBOutlet weak var teamTextField: UITextField!
    
    
    
    var athlete: Athlete?
    init?(coder: NSCoder, athlete: Athlete?)
    {
        self.athlete = athlete
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
    }
    
    func updateView()
    {
        if let athlete = athlete {
            nameTextField.text = "\(athlete.name)"
            ageTextField.text = "\(athlete.age)"
            leagueTextField.text = "\(athlete.league)"
            teamTextField.text = "\(athlete.team)"
        }
    }

    @IBAction func saveButtonPressed(_ sender: Any)
    {
        guard let name = nameTextField.text,
              let ageString = ageTextField.text,
              let age = Int(ageString),
              let league = leagueTextField.text,
              let team = teamTextField.text
        else {return}
        
        athlete = Athlete(name: name, age: age, league: league, team: team)
        
        performSegue(withIdentifier: "unwindSegue", sender: self)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
