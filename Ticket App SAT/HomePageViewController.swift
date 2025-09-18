//
//  HomePageViewController.swift
//  Ticket App SAT
//
//  Created by Monique Vilardo on 20/6/2024.
//

import UIKit

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //OUTLETS:
    
    //Inputs:
    @IBOutlet var btnGenreButtons: [UIButton]!
    @IBOutlet var btnPriceButtons: [UIButton]!
    @IBOutlet var btnTheatreButtons: [UIButton]!
    @IBOutlet var btnDatesButtons: [UIButton]!
    
    
    //Stackview:
    @IBOutlet weak var stackViewGenres: UIStackView!
    @IBOutlet weak var stackViewPrice: UIStackView!
    @IBOutlet weak var stackViewTheatre: UIStackView!
    @IBOutlet weak var stackViewDates: UIStackView!
    @IBOutlet var allStackViewsInHomepage: [UIStackView]!
    
    
    //Buttons Outlets:
    @IBOutlet weak var btnComedy: UIButton!
    @IBOutlet weak var btnDrama: UIButton!
    @IBOutlet weak var btnRomance: UIButton!
    @IBOutlet weak var btnJukeBox: UIButton!
    @IBOutlet weak var btnFantasy: UIButton!
    @IBOutlet weak var btnDisney: UIButton!
    @IBOutlet weak var btnHistorical: UIButton!
    @IBOutlet weak var btnRockPop: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    
    @IBOutlet weak var btnMinToMax: UIButton!
    @IBOutlet weak var btnMaxToMin: UIButton!
    
    @IBOutlet weak var btnRegentTheatre: UIButton!
    @IBOutlet weak var btnHerMajesty: UIButton!
    @IBOutlet weak var btnArtsCentre: UIButton!
    @IBOutlet weak var btnPrincessTheatre: UIButton!
    @IBOutlet weak var btnTheatreOther: UIButton!
    
    
    @IBOutlet weak var btnEarlyToLateOpen: UIButton!
    @IBOutlet weak var btnLateToEarlyOpen: UIButton!
    @IBOutlet weak var btnEarlyToLateClose: UIButton!
    @IBOutlet weak var btnLateToEarlyClose: UIButton!
    
    
    //Inputs:
    @IBOutlet weak var tblTickets: UITableView!
    @IBOutlet weak var txtShowSearch: UITextField!
    @IBOutlet weak var btnAddTicketButton: UIButton!
    @IBOutlet weak var btnSearchButton: UIButton!
    
    
    
    //BUTTONS:
    
    //This button will send the user to the profile/logout page, and it also sets the segue used to 1 so that if the user tries to go back they will be able to go back to this page.
    @IBAction func btnSendToProfileHomePage(_ sender: Any) {
        segueUsed = 1
        self.performSegue(withIdentifier: "homepageToProfile", sender: self)
    }
    
    //This button will send the user to the add tickets page.
    @IBAction func btnSendToAddTickets(_ sender: Any) {
        self.performSegue(withIdentifier: "homepageToAddTickets", sender: self)
    }
    
    //This button will send the user to the ticket budgeting page.
    @IBAction func btnSendToTicketBudgeting(_ sender: Any) {
        self.performSegue(withIdentifier: "homepageToTicketBudgeting", sender: self)
    }
    
    
    //This button shows the user an alert that asks if they want to reset the table, if they press yes it resets the table view and clears all textfields/stackViews so that the page goes back to its original state.
    @IBAction func btnReset(_ sender: Any) {
        let alert = UIAlertController(title: "Reset?", message: "Are you sure you want to reset the table?", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Yes", style: .default) { action in
            newSearchedTicketData.removeAll()
            newExpandedIndexSet.removeAll()
            self.tblTickets.reloadData()
            self.txtShowSearch.text = ""
            self.stackViewDisapear()
        }
        let noButton = UIAlertAction(title: "No", style: .default)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //This button searches and displayes any tickets that the user searches up.
    @IBAction func btnSearch(_ sender: Any) {
        
        //This an exsistance check, this checks if the user has typed in an item when searching for a show, if they haven't  it will send an alert to the user to type something into the textbox to search.
        if txtShowSearch.text != "" {
            let showSearch: String = txtShowSearch.text!
            
            //This removes all the data from the searched ticket data array so that a search can be performed.
            newSearchedTicketData.removeAll()
            
            //This searches the ticket data for the showTitle typed in the textbox.
            newSearchedTicketData = linearSearch(array: tickets, searchType: "showTitle", searchFor: showSearch)
            
            print(newExpandedIndexSet.count)
            
            
            //If there is no data that can be found with the search than this alert is displayed.
            if newSearchedTicketData.isEmpty {
                emptySearchAlert()
            }
            
            //This realoads the table data to display only the searched tickets.
            tblTickets.reloadData()
            
            //This makes the stackview of buttons disapear
            stackViewDisapear()
            
            txtShowSearch.text = ""
        } else {
            //This is the exsistance check alert.
            checkAlert()
        }
    }
     
    
    //This is the genre button that when pressed will display the types of genres the user can search by, but if it is pressed again then it will hide all of the sort/search types.
    @IBAction func btnGenreSelect(_ sender: Any) {
        if stackViewGenres.isHidden == false {
            disapearButtonVisibilityGenre()
        } else {
            showButtonVisibilityGenre()
        }
    }
    
    //This is the price button that when pressed will display the types of prices the user can search by, but if it is pressed again then it will hide all of the sort/search types.
    @IBAction func btnPriceSelect(_ sender: Any) {
        if stackViewPrice.isHidden == false {
            disapearButtonVisibilityPrice()
        } else {
            showButtonVisibilityPrice()
        }
    }
    
    //This is the theatre button that when pressed will display the types of theatres the user can search by, but if it is pressed again then it will hide all of the sort/search types.
    @IBAction func btnTheatreSelect(_ sender: Any) {
        if stackViewTheatre.isHidden == false {
            disapearButtonVisibilityTheatre()
        } else {
            showButtonVisibilityTheatre()
        }
    }
    
    
    //This is the dates button that when pressed will display the types of dates the user can search by, but if it is pressed again then it will hide all of the sort/search types.
    @IBAction func btnDatesSelect(_ sender: Any) {
        if stackViewDates.isHidden == false {
            disapearButtonVisibilityDates()
        } else {
            showButtonVisibilityDates()
        }
    }
    
    
    // This is the comedy button when pressed it will sort the array to only display tickets with comedy as their genre.
    @IBAction func btnComedyAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for the genre comedy.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "genre", searchFor: "Comedy")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    
    // This is the drama button when pressed it will sort the array to only display tickets with drama as their genre.
    @IBAction func btnDramaAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for the genre drama.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "genre", searchFor: "Drama")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    
    // This is the romance button when pressed it will sort the array to only display tickets with romance as their genre.
    @IBAction func btnRomanceAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for the genre romance.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "genre", searchFor: "Romance")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    
    // This is the Jukebox button when pressed it will sort the array to only display tickets with jukebox as their genre.
    @IBAction func btnJukeBoxAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for the genre jukebox.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "genre", searchFor: "Jukebox")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    
    // This is the rock/pop button when pressed it will sort the array to only display tickets with rock/pop as their genre.
    @IBAction func btnRockPopAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for the genre rock/pop.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "genre", searchFor: "Rock/Pop")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    
    // This is the fantasy button when pressed it will sort the array to only display tickets with fantasy as their genre.
    @IBAction func btnFantasyAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for the genre fantasy.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "genre", searchFor: "Fantasy")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    // This is the disney button when pressed it will sort the array to only display tickets with disney as their genre.
    @IBAction func btnDisneyAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for the genre disney.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "genre", searchFor: "Disney")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    // This is the historical button when pressed it will sort the array to only display tickets with historical as their genre.
    @IBAction func btnHistoricalAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for the genre historical.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "genre", searchFor: "Historical")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    // This is the other button when pressed it will sort the array to only display tickets with other as their genre.
    @IBAction func btnOtherAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for the genre other.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "genre", searchFor: "Other")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    
    // This is the minToMax button when pressed it will sort the array from lowest to highest price.
    @IBAction func btnMinToMaxAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that previous search data isn't displayed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This states that if the amount of tickets is less than or equal to 10 a selection sort for minToMax would be performed if not then a quicksort would be performed.
        if tickets.count < 10 {
            tickets = selectionSort(array: tickets, sortType: "minToMax")
        } else {
            tickets = quickSort(array: tickets, sortType: "minToMax")
        }
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    // This is the maxToMin button when pressed it will sort the array from highest to lowest price.
    @IBAction func btnMaxToMinAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that previous search data isn't displayed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This states that if the amount of tickets is less than or equal to 10 a selection sort for maxToMin would be performed if not then a quicksort would be performed.
        if tickets.count < 10 {
            tickets = selectionSort(array: tickets, sortType: "maxToMin")
        } else {
            tickets = quickSort(array: tickets, sortType: "maxToMin")
        }
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    
    // This is the regent theatre button when pressed it will sort the array to only display tickets with regent theatre as their theatre.
    @IBAction func btnRegentTheatreAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for the theatre the regent theatre.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "theatreType", searchFor: "Regent Theatre")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    // This is the her majesty's theatre button when pressed it will sort the array to only display tickets with her majesty's theatre as their theatre.
    @IBAction func btnHerMajestyAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for the theatre the her majesty's theatre.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "theatreType", searchFor: "Her Majesty's Theatre")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    // This is the arts centre melbourne button when pressed it will sort the array to only display tickets with arts centre melbourne theatre as their theatre.
    @IBAction func btnArtsCentreAction(_ sender: Any) {
        
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for the theatre the arts centre melbourne.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "theatreType", searchFor: "Arts Centre Melbourne")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    // This is the princess theatre button when pressed it will sort the array to only display tickets with princess theatre as their theatre.
    @IBAction func btnPrincessTheatreAction(_ sender: Any) {
        
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for the theatre the princess theatre.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "theatreType", searchFor: "Princess Theatre")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    // This is the other theatre button when pressed it will sort the array to only display tickets with other as their theatre.
    @IBAction func btnTheatreOtherAction(_ sender: Any) {
        
        //This removes all the data from the searched ticket data array so that a search can be performed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This searches the ticket data for any other theatre.
        newSearchedTicketData = linearSearch(array: tickets, searchType: "theatreType", searchFor: "Other")
        
        //If there is no data that can be found with the search than this alert is displayed.
        if newSearchedTicketData.isEmpty {
            emptySearchAlert()
        }
        
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    
    // This is the early to late button by opening night when pressed it will sort the array to only display tickets from earliest to latest by opening night.
    @IBAction func btnEarlyToLateOpenAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that previous search data isn't displayed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This states that if the amount of tickets is less than or equal to 10 a selection sort for earlyToLatestByOpeningNight would be performed if not then a quicksort would be performed.
        if tickets.count < 10 {
            tickets = selectionSort(array: tickets, sortType: "earlyToLatestByOpeningNight")
        } else {
            tickets = quickSort(array: tickets, sortType: "earlyToLatestByOpeningNight")
        }
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    // This is the late to early button by opening night when pressed it will sort the array to only display tickets from latestest to earliest by opening night.
    @IBAction func btnLateToEarlyOpenAction(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that previous search data isn't displayed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This states that if the amount of tickets is less than or equal to 10 a selection sort for latestToEarlyByOpeningNight would be performed if not then a quicksort would be performed.
        if tickets.count < 10 {
            tickets = selectionSort(array: tickets, sortType: "latestToEarlyByOpeningNight")
        } else {
            tickets = quickSort(array: tickets, sortType: "latestToEarlyByOpeningNight")
        }
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    // This is the early to late button by closing night when pressed it will sort the array to only display tickets from earliest to latest by closing night.
    @IBAction func btnEarlyToLateClose(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that previous search data isn't displayed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This states that if the amount of tickets is less than or equal to 10 a selection sort for earlyToLatestByClosingNight would be performed if not then a quicksort would be performed.
        if tickets.count < 10 {
            tickets = selectionSort(array: tickets, sortType: "earlyToLatestByClosingNight")
        } else {
            tickets = quickSort(array: tickets, sortType: "earlyToLatestByClosingNight")
        }
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    // This is the late to early button by closing night when pressed it will sort the array to only display tickets from latestest to earliest by closing night.
    @IBAction func btnLateToEarlyClose(_ sender: Any) {
        //This removes all the data from the searched ticket data array so that previous search data isn't displayed.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        
        //This states that if the amount of tickets is less than or equal to 10 a selection sort for latestToEarlyByClosingNight would be performed if not then a quicksort would be performed.
        if tickets.count < 10 {
            tickets = selectionSort(array: tickets, sortType: "latestToEarlyByClosingNight")
        } else {
            tickets = quickSort(array: tickets, sortType: "latestToEarlyByClosingNight")
        }
        tblTickets.reloadData()
        
        //This makes the stackview of buttons disapear.
        stackViewDisapear()
    }
    
    
    
    
    
    //FUNCTIONS:
    
    //This function is the alert that is displayed when the textboxes don't pass all of the checks (exsistance, type or range checks), to alert the user to edit their input to continue.
    func checkAlert() {
        let alert = UIAlertController(title: "Error", message: "Please enter valid values into the textboxes.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { action in
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    //This fucntion will make the buttons in the gernre stackview visible to the user and will make all other stackviews and their associated buttons disapear.
    func showButtonVisibilityGenre() {
        //The other stacks views disapear.
        disapearButtonVisibilityDates()
        disapearButtonVisibilityPrice()
        disapearButtonVisibilityTheatre()
        
        //Displays the stackview.
        stackViewGenres.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.btnGenreButtons.forEach { button in
                UIView.modifyAnimations(withRepeatCount: 1, autoreverses: false) {
                    button.isHidden = false
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    //This function makes the genre stackview disapear and all its associated buttons that sort/search by genre.
    func disapearButtonVisibilityGenre() {
        for eachButton in btnGenreButtons {
            eachButton.isHidden = true
        }
        stackViewGenres.isHidden = true
    }
    
    //This fucntion will make the buttons in the price stackview visible to the user and will make all other stackviews and their associated buttons disapear.
    func showButtonVisibilityPrice() {
        //The other stacks views disapear.
        disapearButtonVisibilityDates()
        disapearButtonVisibilityGenre()
        disapearButtonVisibilityTheatre()
        
        //Displays the stackview.
        stackViewPrice.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.btnPriceButtons.forEach { button in
                UIView.modifyAnimations(withRepeatCount: 1, autoreverses: false) {
                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    //This function makes the price stackview disapear and all its associated buttons that sort/search by price.
    func disapearButtonVisibilityPrice() {
        for eachButton in btnPriceButtons {
            eachButton.isHidden = true
        }
        stackViewPrice.isHidden = true
    }
    
    //This fucntion will make the buttons in the theatre stackview visible to the user and will make all other stackviews and their associated buttons disapear.
    func showButtonVisibilityTheatre() {
        //The other stacks views disapear.
        disapearButtonVisibilityDates()
        disapearButtonVisibilityGenre()
        disapearButtonVisibilityPrice()
        
        //Displays the stackview.
        stackViewTheatre.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.btnTheatreButtons.forEach { button in
                UIView.modifyAnimations(withRepeatCount: 1, autoreverses: false) {
                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    //This function makes the theatre stackview disapear and all its associated buttons that sort/search by theatre.
    func disapearButtonVisibilityTheatre() {
        for eachButton in btnTheatreButtons {
            eachButton.isHidden = true
        }
        stackViewTheatre.isHidden = true
    }
    
    //This fucntion will make the buttons in the dates stackview visible to the user and will make all other stackviews and their associated buttons disapear.
    func showButtonVisibilityDates() {
        //The other stacks views disapear.
        disapearButtonVisibilityTheatre()
        disapearButtonVisibilityGenre()
        disapearButtonVisibilityPrice()
        
        //Displays the stackview.
        stackViewDates.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.btnDatesButtons.forEach { button in
                UIView.modifyAnimations(withRepeatCount: 1, autoreverses: false) {
                    button.isHidden = !button.isHidden
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    //This function makes the dates stackview disapear and all its associated buttons that sort/search by dates.
    func disapearButtonVisibilityDates() {
        for eachButton in btnDatesButtons {
            eachButton.isHidden = true
        }
        stackViewDates.isHidden = true
    }
    
    
    //The following function adds the correct amount of cells to the tableview.
    //This function allows the table to display the data.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //This states that if the array that holds searched ticket data is empty, then count the amount of tickets in the general ticket array, if not then count how many tickets are searched in the searched array.
        if newSearchedTicketData.isEmpty {
            return tickets.count
        } else {
            return newSearchedTicketData.count
        }
    }
    
    //The following function populates each of the cells in the tableview.
    //This function allows the table to display the data.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //This states that if the array that holds searched ticket data is empty, then display all of the ticket data from the ticket array, if not then it will dispplay the ticket data from the searched ticket data array.
        if newSearchedTicketData.isEmpty {
            
            let ticket = tickets[indexPath.row]
            cell.textLabel?.numberOfLines = expandedIndexSet.contains(indexPath.row) ? 0 : 1
            
            if expandedIndexSet.contains(indexPath.row) {
                cell.textLabel?.text = "\(ticket.toString())\n\n\(ticket.detailString())"
                cell.accessoryType = .none
            } else {
                cell.textLabel?.text = ticket.toString()
                cell.accessoryType = .detailDisclosureButton
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let ticket = newSearchedTicketData[indexPath.row]
            cell.textLabel?.numberOfLines = newExpandedIndexSet.contains(indexPath.row) ? 0 : 1
            
            if newExpandedIndexSet.contains(indexPath.row) {
                cell.textLabel?.text = "\(ticket.toString())\n\n\(ticket.detailString())"
                cell.accessoryType = .none
            } else {
                cell.textLabel?.text = ticket.toString()
                cell.accessoryType = .detailDisclosureButton
            }
            
            return cell
        }
    }
    
    //This function allows the table to display the expaneded extra information for the ticket data in the table.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //This states that if the array that holds searched ticket data is empty, then allow the user to toggle and view the expanded information of all ticket data, if not then all the user to toggle and view the expanded information for the searched data's information.
        if newSearchedTicketData.isEmpty {
            // Toggle the expanded state.
            if expandedIndexSet.contains(indexPath.row) {
                expandedIndexSet.remove(indexPath.row)
            } else {
                expandedIndexSet.insert(indexPath.row)
            }
            
            //Displayes the expanded extra information.
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
        } else {
            // Toggle the expanded state
            if newExpandedIndexSet.contains(indexPath.row) {
                newExpandedIndexSet.remove(indexPath.row)
            } else {
                newExpandedIndexSet.insert(indexPath.row)
            }
            
            //Displayes the expanded extra information.
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    // This function allows the user to edit the data that is shown in the array.
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        //This states if the current user cerdentials is equivalent to the admin's user credentials then allow them to edit the data if not then an alert is displayed detailing that only an admin an edit the data.
        if currentUserCredentials.username == "Admin123" && currentUserCredentials.password == "BuTtOn30R!V3M7Cr4Zy" {
            
            //This states that if the array that holds searched ticket data is empty, then use the ticket data array to find the specific data that the user wants to edit, whereas if not then it will use the searched ticket data array to find the specific data the user wants to edit.
            if newSearchedTicketData.isEmpty {
                //This creates an alert that displayes textboxes with the ticket data.
                let ticket = tickets[indexPath.row]
                let alertController = UIAlertController(title: "Edit Ticket Data", message: nil, preferredStyle: .alert)
                
                //This creates different textfields in the alert that allows the user to edit different types of ticket information in the array, and will display a place holder for what specifc type of ticket data is being displayed.
                alertController.addTextField { textField in
                    textField.text = ticket.showTitle
                    textField.placeholder = "Show Title:"
                }
                alertController.addTextField { textField in
                    textField.text = String(ticket.price)
                    textField.placeholder = "Price:"
                    textField.keyboardType = .numberPad
                }
                alertController.addTextField { textField in
                    textField.text = ticket.openingNight
                    textField.placeholder = "Opening Night:"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.closingNight
                    textField.placeholder = "Closing Night:"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.genre
                    textField.placeholder = "Genre"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.typeOfSeat
                    textField.placeholder = "Type of Seat:"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.theatreName
                    textField.placeholder = "Theatre Name:"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.theatreType
                    textField.placeholder = "Theatre Type:"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.location
                    textField.placeholder = "Location:"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.description
                    textField.placeholder = "Description:"
                }
                
                
                //This collects the data from the textfields and performs a check so if it is empty or doesn't fit the type it will send a check alert.
                let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                    
                    guard let showTitleField = alertController.textFields?[0],
                          let priceField = alertController.textFields?[1],
                          let openingNightField = alertController.textFields?[2],
                          let closingNightField = alertController.textFields?[3],
                          let genreField = alertController.textFields?[4],
                          let typeOfSeatField = alertController.textFields?[5],
                          let theatreNameField = alertController.textFields?[6],
                          let theatreTypeField = alertController.textFields?[7],
                          let locationField = alertController.textFields?[8],
                          let descriptionField = alertController.textFields?[9],
                          
                            
                            
                            let showTitle = showTitleField.text, !showTitle.isEmpty,
                          let closingNight = closingNightField.text, !closingNight.isEmpty,
                          let genre = genreField.text, !genre.isEmpty,
                          let typeOfSeat = typeOfSeatField.text, !typeOfSeat.isEmpty,
                          let theatreName = theatreNameField.text, !theatreName.isEmpty,
                          let theatreType = theatreTypeField.text, !theatreType.isEmpty,
                          let location = locationField.text, !location.isEmpty,
                          let description = descriptionField.text, !description.isEmpty,
                          let priceString = priceField.text, !priceString.isEmpty,
                          let price = Float(priceString),
                          let openingNight = openingNightField.text, !openingNight.isEmpty
                            
                    else {
                        // Handle invalid input with a check alert.
                        self.checkAlert()
                        return
                    }
                    
                    // This updates the ticket details.
                    tickets[indexPath.row] = TicketDataStore(showTitle: showTitle, openingNight: openingNight, closingNight: closingNight, typeOfSeat: typeOfSeat, price: price, genre: genre, theatreType: theatreType, theatreName: theatreName, location: location, description: description)
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                    self.saveToFile()
                }
                
                //This is the cancel part of the edit alert.
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                alertController.addAction(saveAction)
                alertController.addAction(cancelAction)
                
                present(alertController, animated: true, completion: nil)
                
            } else {
                //This creates an alert that displayes textboxes with the ticket data.
                let ticket = newSearchedTicketData[indexPath.row]
                let alertController = UIAlertController(title: "Edit Ticket Data", message: nil, preferredStyle: .alert)
                
                //This creates different textfields in the alert that allows the user to edit different types of ticket information in the array, and will display a place holder for what specifc type of ticket data is being displayed.
                alertController.addTextField { textField in
                    textField.text = ticket.showTitle
                    textField.placeholder = "Show Title:"
                }
                alertController.addTextField { textField in
                    textField.text = String(ticket.price)
                    textField.placeholder = "Price:"
                    textField.keyboardType = .numberPad
                }
                alertController.addTextField { textField in
                    textField.text = ticket.openingNight
                    textField.placeholder = "Opening Night:"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.closingNight
                    textField.placeholder = "Closing Night:"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.genre
                    textField.placeholder = "Genre"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.typeOfSeat
                    textField.placeholder = "Type of Seat:"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.theatreName
                    textField.placeholder = "Theatre Name:"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.theatreType
                    textField.placeholder = "Theatre Type:"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.location
                    textField.placeholder = "Location:"
                }
                
                alertController.addTextField { textField in
                    textField.text = ticket.description
                    textField.placeholder = "Description:"
                }
                
                //This collects the data from the textfields and performs a check so if it is empty or doesn't fit the type it will send a check alert.
                let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                    
                    guard let showTitleField = alertController.textFields?[0],
                          let priceField = alertController.textFields?[1],
                          let openingNightField = alertController.textFields?[2],
                          let closingNightField = alertController.textFields?[3],
                          let genreField = alertController.textFields?[4],
                          let typeOfSeatField = alertController.textFields?[5],
                          let theatreNameField = alertController.textFields?[6],
                          let theatreTypeField = alertController.textFields?[7],
                          let locationField = alertController.textFields?[8],
                          let descriptionField = alertController.textFields?[9],
                          
                            
                            
                            let showTitle = showTitleField.text, !showTitle.isEmpty,
                          let closingNight = closingNightField.text, !closingNight.isEmpty,
                          let genre = genreField.text, !genre.isEmpty,
                          let typeOfSeat = typeOfSeatField.text, !typeOfSeat.isEmpty,
                          let theatreName = theatreNameField.text, !theatreName.isEmpty,
                          let theatreType = theatreTypeField.text, !theatreType.isEmpty,
                          let location = locationField.text, !location.isEmpty,
                          let description = descriptionField.text, !description.isEmpty,
                          let priceString = priceField.text, !priceString.isEmpty,
                          let price = Float(priceString),
                          let openingNight = openingNightField.text, !openingNight.isEmpty
                            
                    else {
                        // Handle invalid input with a check alert.
                        self.checkAlert()
                        return
                    }
                    
                    // This updates the ticket details.
                    newSearchedTicketData[indexPath.row] = TicketDataStore(showTitle: showTitle, openingNight: openingNight, closingNight: closingNight, typeOfSeat: typeOfSeat, price: price, genre: genre, theatreType: theatreType, theatreName: theatreName, location: location, description: description)
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                    self.saveToFile()
                }
                
                //This is the cancel part of the edit alert.
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                alertController.addAction(saveAction)
                alertController.addAction(cancelAction)
                
                present(alertController, animated: true, completion: nil)
            }
        } else {
            //This is the alert displayed if the user is not an admin and attempts to edit the data.
            nonAdminUserAlert()
        }
    }
    
    //The following tableview function can be added to a Swift project to add swipe functionality to a tableview control.  Delete is only one of the many choices available.
    //This allows the user to delete piece of ticket data.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //This states if the current user cerdentials is equivalent to the admin's user credentials then the user is allowed to delete ticket data, if they don't have to same user credentials then they will get an alert.
        if currentUserCredentials.username == "Admin123" && currentUserCredentials.password == "BuTtOn30R!V3M7Cr4Zy" {
            
            //This if statement states if nothing is being search then you can delete ticket data, but if the user is searching something they can't delete thhe data and an alert is sent out.
            if newSearchedTicketData.isEmpty {
                if editingStyle == .delete {
                    tickets.remove(at: indexPath.row)
                    tblTickets.reloadData()
                    saveToFile()
                }
            } else {
                //This is the alert that states you can't delete while searching.
                let alert = UIAlertController(title: "Error", message: "You can't delete data while searching.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .default) { action in
                }
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {
            nonAdminUserAlert()
        }
    }
    
    //This is the alert that alerts the average user that they can't do a specific function because they don't have the correct permissions.
    func nonAdminUserAlert() {
        let alert = UIAlertController(title: "Error", message: "Only admin can edit data.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { action in
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    //This function is a selection sort and sort values in an array from lowest to highest.
    func selectionSort(array: [TicketDataStore], sortType: String) -> [TicketDataStore] {
        
        //This is the sort specifically for min to max priced values.
        if sortType == "minToMax" {
            
            if array.count > 1 {
                var arr = array
                for x in 0 ..< arr.count - 1 {
                    var lowest = x
                    for y in x + 1 ..< arr.count {
                        if arr[y].price < arr[lowest].price {
                            lowest = y
                        }
                    }
                    if x != lowest {
                        arr.swapAt(x, lowest)
                    }
                }
                return arr
            } else {
                return array
            }
            
            //This is the sort specifically for max to min priced values.
        } else if sortType == "maxToMin" {
            
            if array.count > 1 {
                var arr = array
                for x in 0 ..< arr.count - 1 {
                    var highest = x
                    for y in x + 1 ..< arr.count {
                        if arr[y].price > arr[highest].price {
                            highest = y
                        }
                    }
                    if x != highest {
                        arr.swapAt(x, highest)
                    }
                }
                return arr
            } else {
                return array
            }
            
            //This is the sort specifically for earliest to latest dates by opening night.
        } else if sortType == "earlyToLatestByOpeningNight" {
            if array.count > 1 {
                var arr = array
                for x in 0 ..< arr.count - 1 {
                    var lowest = x
                    for y in x + 1 ..< arr.count {
                        if arr[y].openingNight < arr[lowest].openingNight {
                            lowest = y
                        }
                    }
                    if x != lowest {
                        arr.swapAt(x, lowest)
                    }
                }
                return arr
            } else {
                return array
            }
            
            //This is the sort specifically for latest to earliest dates by opening night.
        } else if sortType == "latestToEarlyByOpeningNight" {
            
            if array.count > 1 {
                var arr = array
                for x in 0 ..< arr.count - 1 {
                    var highest = x
                    for y in x + 1 ..< arr.count {
                        if arr[y].openingNight > arr[highest].openingNight {
                            highest = y
                        }
                    }
                    if x != highest {
                        arr.swapAt(x, highest)
                    }
                }
                return arr
            } else {
                return array
            }
            
            //This is the sort specifically for earliest to latest dates by closing night.
        } else if sortType == "earlyToLatestByClosingNight" {
            
            if array.count > 1 {
                var arr = array
                for x in 0 ..< arr.count - 1 {
                    var lowest = x
                    for y in x + 1 ..< arr.count {
                        if arr[y].closingNight < arr[lowest].closingNight {
                            lowest = y
                        }
                    }
                    if x != lowest {
                        arr.swapAt(x, lowest)
                    }
                }
                return arr
            } else {
                return array
            }
            
            //This is the sort specifically for latest to earliest dates by closing night.
        } else if sortType == "latestToEarlyByClosingNight" {
            
            if array.count > 1 {
                var arr = array
                for x in 0 ..< arr.count - 1 {
                    var highest = x
                    for y in x + 1 ..< arr.count {
                        if arr[y].closingNight > arr[highest].closingNight {
                            highest = y
                        }
                    }
                    if x != highest {
                        arr.swapAt(x, highest)
                    }
                }
                return arr
            } else {
                return array
            }
        }
        
        return array
        
    }
    
    //This function is the quick sort it sorts values in an array from lowest to highest.
    func quickSort(array: [TicketDataStore], sortType: String) -> [TicketDataStore] {
        
        //This is the sort specifically for min to max priced values.
        if sortType == "minToMax" {
            
            var less: [TicketDataStore] = []
            var equal: [TicketDataStore] = []
            var greater: [TicketDataStore] = []
            if array.count > 1 {
                let pivot = array[array.count - 1]
                for x in array {
                    if x.price < pivot.price {
                        less.append(x)
                    }
                    if x.price == pivot.price {
                        equal.append(x)
                    }
                    if x.price > pivot.price {
                        greater.append(x)
                    }
                }
                return (quickSort(array: less, sortType: "minToMax") + equal + quickSort(array: greater, sortType: "minToMax"))
            } else {
                return array
            }
            
            //This is the sort specifically for max to min priced values.
        } else if sortType == "maxToMin" {
            
            var less: [TicketDataStore] = []
            var equal: [TicketDataStore] = []
            var greater: [TicketDataStore] = []
            if array.count > 1 {
                let pivot = array[array.count - 1]
                for x in array {
                    if x.price > pivot.price {
                        greater.append(x)
                    }
                    if x.price == pivot.price {
                        equal.append(x)
                    }
                    if x.price < pivot.price {
                        less.append(x)
                    }
                }
                return (quickSort(array: greater, sortType: "maxToMin") + equal + quickSort(array: less, sortType: "maxToMin"))
            } else {
                return array
            }
            
            //This is the sort specifically for earliest to latest dates by opening night.
        } else if sortType == "earlyToLatestByOpeningNight" {
            
            var less: [TicketDataStore] = []
            var equal: [TicketDataStore] = []
            var greater: [TicketDataStore] = []
            if array.count > 1 {
                let pivot = array[array.count - 1]
                for x in array {
                    if x.openingNight < pivot.openingNight {
                        less.append(x)
                    }
                    if x.openingNight == pivot.openingNight {
                        equal.append(x)
                    }
                    if x.openingNight > pivot.openingNight {
                        greater.append(x)
                    }
                }
                return (quickSort(array: less, sortType: "earlyToLatestByOpeningNight") + equal + quickSort(array: greater, sortType: "earlyToLatestByOpeningNight"))
            } else {
                return array
            }
            
            //This is the sort specifically for latest to earliest dates by opening night.
        } else if sortType == "latestToEarlyByOpeningNight" {
            
            var less: [TicketDataStore] = []
            var equal: [TicketDataStore] = []
            var greater: [TicketDataStore] = []
            if array.count > 1 {
                let pivot = array[array.count - 1]
                for x in array {
                    if x.openingNight > pivot.openingNight {
                        greater.append(x)
                    }
                    if x.openingNight == pivot.openingNight {
                        equal.append(x)
                    }
                    if x.openingNight < pivot.openingNight {
                        less.append(x)
                    }
                }
                return (quickSort(array: greater, sortType: "latestToEarlyByOpeningNight") + equal + quickSort(array: less, sortType: "latestToEarlyByOpeningNight"))
            } else {
                return array
            }
            
            //This is the sort specifically for earliest to latest dates by closing night.
        } else if sortType == "earlyToLatestByClosingNight" {
            
            var less: [TicketDataStore] = []
            var equal: [TicketDataStore] = []
            var greater: [TicketDataStore] = []
            if array.count > 1 {
                let pivot = array[array.count - 1]
                for x in array {
                    if x.closingNight < pivot.closingNight {
                        less.append(x)
                    }
                    if x.closingNight == pivot.closingNight {
                        equal.append(x)
                    }
                    if x.closingNight > pivot.closingNight {
                        greater.append(x)
                    }
                }
                return (quickSort(array: less, sortType: "earlyToLatestByClosingNight") + equal + quickSort(array: greater, sortType: "earlyToLatestByClosingNight"))
            } else {
                return array
            }
            
            //This is the sort specifically for latest to earliest dates by closing night.
        } else if sortType == "latestToEarlyByClosingNight" {
            
            var less: [TicketDataStore] = []
            var equal: [TicketDataStore] = []
            var greater: [TicketDataStore] = []
            if array.count > 1 {
                let pivot = array[array.count - 1]
                for x in array {
                    if x.closingNight > pivot.closingNight {
                        greater.append(x)
                    }
                    if x.closingNight == pivot.closingNight {
                        equal.append(x)
                    }
                    if x.closingNight < pivot.closingNight {
                        less.append(x)
                    }
                }
                return (quickSort(array: greater, sortType: "latestToEarlyByClosingNight") + equal + quickSort(array: less, sortType: "latestToEarlyByClosingNight"))
            } else {
                return array
            }
            
        }
        
        return array
        
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
    
    
    //This is the linear search function, it finds specific value in the array.
    func linearSearch(array: [TicketDataStore], searchType: String, searchFor: String) -> [TicketDataStore] {
        
        var searchedItems: [TicketDataStore] = []
        
        //This finds the value in the genre part of the stuct.
        if searchType == "genre" {
            for eachSearchedItem in array {
                if eachSearchedItem.genre == searchFor {
                    searchedItems.append(eachSearchedItem)
                    print(eachSearchedItem)
                }
            }
            
            //This finds the value in the theatre part of the stuct.
        } else if searchType == "theatreType" {
            for eachSearchedItem in array {
                if eachSearchedItem.theatreType == searchFor {
                    searchedItems.append(eachSearchedItem)
                    print("W")
                    print(eachSearchedItem)
                    print("Z")
                }
            }
            
            //This finds the value in the show title part of the stuct.
        } else if searchType == "showTitle" {
            for eachSearchedItem in array {
                if eachSearchedItem.showTitle == searchFor {
                    searchedItems.append(eachSearchedItem)
                    print("W")
                    print(eachSearchedItem)
                    print("Z")
                }
            }
            
        }
        
        return searchedItems
    }
    
    //This function is the alert that is used to tell the user there is no results found for a search.
    func emptySearchAlert() {
        let alert = UIAlertController(title: "Error", message: "No results were found.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { action in
            newSearchedTicketData.removeAll()
            newExpandedIndexSet.removeAll()
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    //This function makes all the stackviews disapear.
    func stackViewDisapear() {
        for eachStackView in allStackViewsInHomepage {
            if eachStackView.isHidden == true {
                disapearButtonVisibilityGenre()
                disapearButtonVisibilityPrice()
                disapearButtonVisibilityDates()
                disapearButtonVisibilityTheatre()
            }
        }
    }
    
    
    //This is all the stuff that is loaded when the page first loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        //The following two lines of code to the viewDidLoad() function to initiate the tableview.
        tblTickets.delegate = self
        tblTickets.dataSource = self
        //This loads all the data when the screen is loaded.
        loadFile()
        //This clears all searched data.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        //This states that if the user is login as an admin then it will displaye the add ticket button.
        if currentUserCredentials.username == "Admin123" && currentUserCredentials.password == "BuTtOn30R!V3M7Cr4Zy" {
            btnAddTicketButton.isHidden = false
        } else {
            btnAddTicketButton.isHidden = true
        }
        //This changes the segue used so that if the profile button is pressed and then the back button is pressed it will go back to this page.
        segueUsed = 1
    }
    
}
