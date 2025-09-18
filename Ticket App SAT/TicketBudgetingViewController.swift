//
//  TicketBudgetingViewController.swift
//  Ticket App SAT
//
//  Created by Monique Vilardo on 20/6/2024.
//

import UIKit

class TicketBudgetingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //OUTLETS:
    @IBOutlet weak var tblBudgetTickets: UITableView!
    @IBOutlet weak var txtMinAmount: UITextField!
    @IBOutlet weak var txtMaxAmount: UITextField!
    @IBOutlet weak var lblTotalShowsInBudget: UILabel!
    @IBOutlet weak var lblAveragePrice: UILabel!
    
    //BUTTONS:
    
    //This searches and finds the values in the search ticket array that fit inside the min and max values.
    @IBAction func btnSearchBudget(_ sender: Any) {
        
        //This is a exsistence check, it checks if the user hasn't typed a value into the textbox, it sends an alert.
        if txtMinAmount.text != "" && txtMaxAmount.text != "" {
            
            //This is a type check, it checks if the user hasn't typed a valid value (this case a number) into the textbox, it sends an alert.
            if Float(txtMinAmount.text!) != nil && Float(txtMaxAmount.text!) != nil {
                
                //This is a range check, it checks if the user typed min number greater than the 0 and the max number is greater than the min number if not it sends an alert.
                if Float(txtMinAmount.text!)! >= 0 && Float(txtMaxAmount.text!)! >= Float(txtMinAmount.text!)! {
                    //This clears the searched ticket data array so that it can be used to find other search data later.
                    newSearchedTicketData.removeAll()
                    newExpandedIndexSet.removeAll()
                    
                    let minAmount: Float = Float(txtMinAmount.text!)!
                    let maxAmount: Float = Float(txtMaxAmount.text!)!
                    var total: Float = 0
                    var average: Float = 0
                    
                    //This searches the ticket array for the min and max amount ant produces an array of values that fit inbetween them.
                    newSearchedTicketData = linearSearchBudget(array: tickets, minAmount: minAmount, maxAmount: maxAmount)
                    
                    //If the searched ticket data is empty then it sends an alert.
                    if newSearchedTicketData.isEmpty {
                        emptySearchAlertBudget()
                    }
                    
                    tblBudgetTickets.reloadData()
                    
                    //For each ticket in the new searched ticket data the price of that ticket is added to the total.
                    for eachTicketPrice in newSearchedTicketData {
                        total = eachTicketPrice.price + total
                    }
                    
                    //This finds the average of the price that fits inbetween max and min.
                    average = total / Float(newSearchedTicketData.count)
                    
                    //This displayes all calculated data and clears the textboxes.
                    lblTotalShowsInBudget.text = String(newSearchedTicketData.count)
                    lblAveragePrice.text = String(format: "$%.02f", average)
                    txtMinAmount.text = ""
                    txtMaxAmount.text = ""
                    
                } else {
                    //This is the alert that is displayed.
                    checkAlertBudget()
                }
                
            } else {
                //This is the alert that is displayed.
                checkAlertBudget()
            }
            
        } else {
            //This is the alert that is displayed.
            checkAlertBudget()
        }
        
    }
    
    //This is the clear all button that sends an alert checking if the user wants to clear everything if they click yess it clears everything.
    @IBAction func btnClearAllBudget(_ sender: Any) {
        let alert = UIAlertController(title: "Clear?", message: "Are you sure you want to clear all variables?", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Yes", style: .default) { action in
            self.clearAllBudget()
        }
        let noButton = UIAlertAction(title: "No", style: .default)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    //This is button that uses a seuge that sends the user to the profile page.
    @IBAction func btnBudgetingTicketsToProfilePage(_ sender: Any) {
        self.performSegue(withIdentifier: "ticketBudgetingToProfilePage", sender: self)
    }
    
    //This is button that uses a seuge that sends the user to the profile page.
    @IBAction func btnBackTicketBudgeting(_ sender: Any) {
        self.performSegue(withIdentifier: "ticketBudgetingToHomePage", sender: self)
    }
     
    
    //FUNCTIONS:
     
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
        
        //This states that if the array that holds searched ticket data is empty, then display all of the ticket data from the ticket array, if not then it will dispplay the ticket data from the searched ticket data array.
        if newSearchedTicketData.isEmpty {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
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
            // Toggle the expanded state
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
                          let priceString = priceField.text,
                          let price = Float(priceString),
                          let openingNight = openingNightField.text, !openingNight.isEmpty
                            
                    else {
                        // Handle invalid input with a check alert.
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
                          let priceString = priceField.text,
                          let price = Float(priceString),
                          let openingNight = openingNightField.text, !openingNight.isEmpty
                            
                    else {
                        // Handle invalid input with a check alert.
                        let alert = UIAlertController(title: "Error", message: "Invalid data was input. Please fill all textfield with valid data.", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "Ok", style: .default) { action in
                            newSearchedTicketData.removeAll()
                            newExpandedIndexSet.removeAll()
                        }
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
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
                    tblBudgetTickets.reloadData()
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
            nonAdminUserAlertBudget()
        }
    }
    
    //This is the alert that alerts the average user that they can't do a specific function because they don't have the correct permissions.
    func nonAdminUserAlertBudget() {
        let alert = UIAlertController(title: "Error", message: "Only admin can edit data.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { action in
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    //This is the linear search this finds the prices that fit inbetween the min and max prices and adds them to a seperate array to be used later.
    func linearSearchBudget(array: [TicketDataStore], minAmount: Float, maxAmount: Float) -> [TicketDataStore] {
        
        var searchedItems: [TicketDataStore] = []
        
            for eachSearchedItem in array {
                if eachSearchedItem.price >= minAmount && eachSearchedItem.price <= maxAmount {
                    searchedItems.append(eachSearchedItem)
                    print(eachSearchedItem)
                }
            }
        
        return searchedItems
    }
    
    //This function is the alert that is used to tell the user there is no results found for a search.
    func emptySearchAlertBudget() {
        let alert = UIAlertController(title: "Error", message: "No results were found in the budget range please adjust the budget.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { action in
            self.clearAllBudget()
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //This function is the alert that is used to tell the user they haven't passed the checks.
    func checkAlertBudget() {
            let alert = UIAlertController(title: "Error", message: "Please fill the text boxes with valid values.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default) { action in
                self.clearAllBudget()
            }
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
    }
    
    //This function clears all values.
    func clearAllBudget() {
        txtMaxAmount.text = ""
        txtMinAmount.text = ""
        lblAveragePrice.text = ""
        lblTotalShowsInBudget.text = ""
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        tblBudgetTickets.reloadData()
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
    
    //This is the alert that alerts the average user that they can't do a specific function because they don't have the correct permissions.
    func nonAdminUserAlert() {
        let alert = UIAlertController(title: "Error", message: "Only admin can edit data.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { action in
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    //This is all the stuff that is loaded when the page first loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        //The following two lines of code to the viewDidLoad() function to initiate the tableview.
        tblBudgetTickets.delegate = self
        tblBudgetTickets.dataSource = self
        //This clears all searched data.
        newSearchedTicketData.removeAll()
        newExpandedIndexSet.removeAll()
        //This loads all the data when the screen is loaded.
        loadFile()
        //This changes the segue used so that if the profile button is pressed and then the back button is pressed it will go back to this page.
        segueUsed = 2
        // Do any additional setup after loading the view.
    }

}
