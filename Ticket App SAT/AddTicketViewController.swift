//
//  AddTicketViewController.swift
//  Ticket App SAT
//
//  Created by Monique Vilardo on 20/6/2024.
//

import UIKit

class AddTicketViewController: UIViewController {

    //OUTLETS:
    
    //Inputs:
    @IBOutlet weak var txtShowTitleAdd: UITextField!
    @IBOutlet weak var txtOpeningNightAdd: UITextField!
    @IBOutlet weak var txtClosingNightAdd: UITextField!
    @IBOutlet weak var txtSeatTypeAdd: UITextField!
    @IBOutlet weak var txtPriceAdd: UITextField!
    @IBOutlet weak var txtLocationAdd: UITextField!
    @IBOutlet weak var segTheatreAdd: UISegmentedControl!
    @IBOutlet weak var txtTheatreOtherAdd: UITextField!
    @IBOutlet weak var txtDescriptionAdd: UITextView!
    @IBOutlet weak var btnGenreLable: UIButton!
    
    //Stackview:
    @IBOutlet weak var stackViewGenreAdd: UIStackView!
    @IBOutlet weak var btnComedyAddStackView: UIButton!
    @IBOutlet var btnGenreAddButtons: [UIButton]!
    @IBOutlet weak var btnDramaAddStackView: UIButton!
    @IBOutlet weak var btnRomanceAddStackView: UIButton!
    @IBOutlet weak var btnJukeBoxAddStackView: UIButton!
    @IBOutlet weak var btnFantasyAddStackView: UIButton!
    @IBOutlet weak var btnRockPopAddStackView: UIButton!
    @IBOutlet weak var btnDisneyAddStackView: UIButton!
    @IBOutlet weak var btnHistoricalAddStackView: UIButton!
    @IBOutlet weak var btnOtherAddStackView: UIButton!
    
    //This varible sets the genre.
    var genre: String = ""
    
    //BUTTONS:
    
    //This button uses a seuge to send the user back to the homepage when pressed.
    @IBAction func btnAddTicketBackToHomepage(_ sender: Any) {
        self.performSegue(withIdentifier: "addTicketToHomepage", sender: self)
    }
    
    //THis button uses a seuge to send the user back to the profile page when pressed.
    @IBAction func btnAddTicketToProfile(_ sender: Any) {
        segueUsed = 3
        self.performSegue(withIdentifier: "addTicketDataToProfilePage", sender: self)
    }
    
    
    //This is the genre button that when pressed will display the types of genres the user can search by, but if it is pressed again then it will hide all of the search types.
    @IBAction func btnGenreAdd(_ sender: Any) {
        stackViewGenreAdd.isHidden = !stackViewGenreAdd.isHidden
        if btnComedyAddStackView.isHidden == true {
            showButtonVisibilityGenreAdd()
        } else {
                disapearButtonVisibilityGenreAdd()
            }
    }
    
    //This button clears all other buttons and sets the genre variable to comedy.
    @IBAction func btnComedyAdd(_ sender: Any) {
        stackViewGenreAdd.isHidden = !stackViewGenreAdd.isHidden
        if btnComedyAddStackView.isHidden == true {
            showButtonVisibilityGenreAdd()
        } else {
                disapearButtonVisibilityGenreAdd()
            }
        genre = "Comedy"
        btnGenreLable.titleLabel?.text = String(genre)
    }
    
    //This button clears all other buttons and sets the genre variable to drama.
    @IBAction func btnDramaAdd(_ sender: Any) {
        stackViewGenreAdd.isHidden = !stackViewGenreAdd.isHidden
        if btnDramaAddStackView.isHidden == true {
            showButtonVisibilityGenreAdd()
        } else {
                disapearButtonVisibilityGenreAdd()
            }
        genre = "Drama"
        btnGenreLable.titleLabel?.text = String(genre)
    }
    
    //This button clears all other buttons and sets the genre variable to romance.
    @IBAction func btnRomanceAdd(_ sender: Any) {
        stackViewGenreAdd.isHidden = !stackViewGenreAdd.isHidden
        if btnRomanceAddStackView.isHidden == true {
            showButtonVisibilityGenreAdd()
        } else {
                disapearButtonVisibilityGenreAdd()
            }
        genre = "Romance"
        btnGenreLable.titleLabel?.text = String(genre)
    }
    
    //This button clears all other buttons and sets the genre variable to jukebox.
    @IBAction func btnJukeboxAdd(_ sender: Any) {
        stackViewGenreAdd.isHidden = !stackViewGenreAdd.isHidden
        if btnJukeBoxAddStackView.isHidden == true {
            showButtonVisibilityGenreAdd()
        } else {
                disapearButtonVisibilityGenreAdd()
            }
        genre = "Jukebox"
        btnGenreLable.titleLabel?.text = String(genre)
    }
    
    //This button clears all other buttons and sets the genre variable to rock/pop.
    @IBAction func btnRockPopAdd(_ sender: Any) {
        stackViewGenreAdd.isHidden = !stackViewGenreAdd.isHidden
        if btnRockPopAddStackView.isHidden == true {
            showButtonVisibilityGenreAdd()
        } else {
                disapearButtonVisibilityGenreAdd()
            }
        genre = "Rock/Pop"
        btnGenreLable.titleLabel?.text = String(genre)
    }
    
    //This button clears all other buttons and sets the genre variable to fantasy.
    @IBAction func btnFantasyAddButton(_ sender: Any) {
        stackViewGenreAdd.isHidden = !stackViewGenreAdd.isHidden
        if btnFantasyAddStackView.isHidden == true {
            showButtonVisibilityGenreAdd()
        } else {
                disapearButtonVisibilityGenreAdd()
            }
        genre = "Fantasy"
        btnGenreLable.titleLabel?.text = String(genre)
    }
    
    //This button clears all other buttons and sets the genre variable to disney.
    @IBAction func btnDisneyAdd(_ sender: Any) {
        stackViewGenreAdd.isHidden = !stackViewGenreAdd.isHidden
        if btnDisneyAddStackView.isHidden == true {
            showButtonVisibilityGenreAdd()
        } else {
                disapearButtonVisibilityGenreAdd()
            }
        genre = "Disney"
        btnGenreLable.titleLabel?.text = String(genre)
    }
    
    //This button clears all other buttons and sets the genre variable to historical.
    @IBAction func btnHistoricalAdd(_ sender: Any) {
        stackViewGenreAdd.isHidden = !stackViewGenreAdd.isHidden
        if btnHistoricalAddStackView.isHidden == true {
            showButtonVisibilityGenreAdd()
        } else {
                disapearButtonVisibilityGenreAdd()
            }
        genre = "Historical"
        btnGenreLable.titleLabel?.text = String(genre)
    }
    
    //This button clears all other buttons and sets the genre variable to other.
    @IBAction func btnOtherAdd(_ sender: Any) {
        stackViewGenreAdd.isHidden = !stackViewGenreAdd.isHidden
        if btnOtherAddStackView.isHidden == true {
            showButtonVisibilityGenreAdd()
        } else {
                disapearButtonVisibilityGenreAdd()
            }
        genre = "Other"
        btnGenreLable.titleLabel?.text = String(genre)
    }
    
    
    //This is the add button and adds new ticket data to the array.
    @IBAction func btnAdd(_ sender: Any) {
        
        var theatreType: String = ""
        var theatreName: String = ""
        
        //This checks if the theetre type is equal to other then it does everything besides from checking if the other theatre text box has been filled.
        if segTheatreAdd.selectedSegmentIndex == 4 {
            
            //This is the exsistance check, and checks if the user typed in a value, if not then it sends an alert to the user.
            if txtTheatreOtherAdd.text != "" && txtShowTitleAdd.text != "" && txtOpeningNightAdd.text != "" && txtClosingNightAdd.text != "" && txtSeatTypeAdd.text != "" && txtPriceAdd.text != "" && txtLocationAdd.text != "" && genre != "" && txtDescriptionAdd.text != ""{
                
                //This checks if the type of data being input is correct if not it sends an alert.
                if Float(txtPriceAdd.text!) != nil {
                    
                    //This checks if the range of data being input is correct if not it sends an alert.
                    if Float(txtPriceAdd.text!)! > 0 {
                        
                        //This switch statments changes the theatre type depending on what was seleceted by the user.
                        switch segTheatreAdd.selectedSegmentIndex {
                        case 1: theatreType = "Her Majesty's Theatre"
                            theatreName = "Her Majesty's Theatre"
                        case 2: theatreType = "Arts Centre Melbourne"
                            theatreName = "Arts Centre Melbourne"
                        case 3: theatreType = "Princess Theatre"
                            theatreName = "Princess Theatre"
                        case 4: theatreName = String(txtTheatreOtherAdd.text!)
                            theatreType = "Other"
                        default: theatreType = "Regent Theatre"
                            theatreName = "Regent Theatre"
                        }
                        
                        //This creates new ticket data in the correct formatt for the array.
                        var newTicket: TicketDataStore = TicketDataStore.init(showTitle: txtShowTitleAdd.text!, openingNight: txtOpeningNightAdd.text!, closingNight: txtClosingNightAdd.text!, typeOfSeat: txtSeatTypeAdd.text!, price: Float(txtPriceAdd.text!)!, genre: genre, theatreType: theatreType, theatreName: theatreName, location: txtLocationAdd.text!, description: txtDescriptionAdd.text!)
                        
                        //This adds the ticket data to the array.
                        tickets.append(newTicket)
                        
                        //This saves the data to the ticket json file.
                        saveToFile()
                        
                        //This clears all variables.
                        clearAll()
                        
                        
                    } else {
                        //This is a check alert.
                        addCheckAlert()
                    }
                    
                } else {
                    //This is a check alert.
                    addCheckAlert()
                }
                
            } else {
                //This is a check alert.
                addCheckAlert()
            }
        } else {
            
            //This is the exsistance check, and checks if the user typed in a value, if not then it sends an alert to the user.
            if txtShowTitleAdd.text != "" && txtOpeningNightAdd.text != "" && txtClosingNightAdd.text != "" && txtSeatTypeAdd.text != "" && txtPriceAdd.text != "" && txtLocationAdd.text != "" && genre != "" && txtDescriptionAdd.text != "" {
                
                //This checks if the type of data being input is correct if not it sends an alert.
                if Float(txtPriceAdd.text!) != nil {
                    
                    //This checks if the range of data being input is correct if not it sends an alert.
                    if Float(txtPriceAdd.text!)! > 0 {
                        
                        //This switch statments changes the theatre type depending on what was seleceted by the user.
                        switch segTheatreAdd.selectedSegmentIndex {
                        case 1: theatreType = "Her Majesty's Theatre"
                            theatreName = "Her Majesty's Theatre"
                        case 2: theatreType = "Arts Centre Melbourne"
                            theatreName = "Arts Centre Melbourne"
                        case 3: theatreType = "Princess Theatre"
                            theatreName = "Princess Theatre"
                        case 4: theatreName = String(txtTheatreOtherAdd.text!)
                            theatreType = "Other"
                        default: theatreType = "Regent Theatre"
                            theatreName = "Regent Theatre"
                        }
                        
                        //This creates new ticket data in the correct formatt for the array.
                        var newTicket: TicketDataStore = TicketDataStore.init(showTitle: txtShowTitleAdd.text!, openingNight: txtOpeningNightAdd.text!, closingNight: txtClosingNightAdd.text!, typeOfSeat: txtSeatTypeAdd.text!, price: Float(txtPriceAdd.text!)!, genre: genre, theatreType: theatreType, theatreName: theatreName, location: txtLocationAdd.text!, description: txtDescriptionAdd.text!)
                        
                        //This adds the ticket data to the array.
                        tickets.append(newTicket)
                        
                        //This saves the data to the ticket json file.
                        saveToFile()
                        
                        //This clears all varaibles.
                        clearAll()
                        
                    } else {
                        //This is a check alert.
                        addCheckAlert()
                    }
                    
                } else {
                    //This is a check alert.
                    addCheckAlert()
                }
                
            } else {
                //This is a check alert.
                addCheckAlert()
            }
        }
    }
    
    //This button sends an alert and if the user presses yes it clears all varaibles.
    @IBAction func btnClearAdd(_ sender: Any) {
        let alert = UIAlertController(title: "Clear?", message: "Are you sure you want to clear all variables?", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Yes", style: .default) { action in
            self.clearAll()
        }
        let noButton = UIAlertAction(title: "No", style: .default)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    //FUNCTIONS:
    
    //This function alerts the user that they haven't passed the checks.
    func addCheckAlert() {
        let alert = UIAlertController(title: "Error", message: "Please fill the text boxes with valid values.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { action in
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    //This function saves all edited ticket data to the ticket json file.
    func saveToFile() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(tickets)
            let jsonURL = URL(fileURLWithPath: "tickets.json", relativeTo: directoryURL)
            
            try jsonData.write(to: jsonURL, options: .atomic)
            print("File was successfully exported")
            print(directoryURL)
        } catch {
            print("File could not be exported: \(error.localizedDescription)")
        }
    }
    
    //This function is used to load data from the ticket json file into your application.
    func loadFile() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let jsonURL = URL(fileURLWithPath: "tickets.json", relativeTo: directoryURL)
            let jsonData = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            tickets = try decoder.decode([TicketDataStore].self, from: jsonData)
            print("JSON file was successfully imported")
            print(directoryURL)
        } catch {
            print("File could not be imported: \(error.localizedDescription)")
        }
    }
    
    //This function clears all varaibles.
    func clearAll() {
        txtShowTitleAdd.text = ""
        txtOpeningNightAdd.text = ""
        txtClosingNightAdd.text = ""
        txtSeatTypeAdd.text = ""
        txtPriceAdd.text = ""
        genre = ""
        btnGenreLable.titleLabel?.text = String("Genre")
        txtLocationAdd.text = ""
        segTheatreAdd.selectedSegmentIndex = 0
        txtTheatreOtherAdd.text = ""
        txtDescriptionAdd.text = ""
    }
    
    //This fucntion will make the buttons in the genre stackview visible to the user and will make all other stackviews and their associated buttons disapear.
    func showButtonVisibilityGenreAdd() {
            UIView.animate(withDuration: 0.3) {
                self.btnGenreAddButtons.forEach { button in
                    UIView.modifyAnimations(withRepeatCount: 1, autoreverses: false) {
                        button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                    }
            }
        }
    }
    
    //This function makes the genre stackview disapear and all its associated buttons that sort/search by genre.
    func disapearButtonVisibilityGenreAdd() {
        self.btnGenreAddButtons.forEach { button in
            button.isHidden = !button.isHidden
            self.view.layoutIfNeeded()
        }
        stackViewGenreAdd.isHidden = true
    }
    
    //This is all the stuff that is loaded when the page first loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        //This loads all the data when the screen is loaded.
        loadFile()
        //This changes the segue used so that if the profile button is pressed and then the back button is pressed it will go back to this page.
        segueUsed = 3
    }
}
