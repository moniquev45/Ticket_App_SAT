//
//  AccountDetailsViewController.swift
//  Ticket App SAT
//
//  Created by Monique Vilardo on 20/6/2024.
//

import UIKit

class AccountDetailsViewController: UIViewController {

    //OUTLETS:
    @IBOutlet weak var lblUsernameDisplay: UILabel!
    @IBOutlet weak var lblPasswordDisplay: UILabel!
    
    //BUTTONS:
    
    //This button checks depending on what segue was used (so the segue count, as it changes depending on what page it was last on) it will send the user back to the page.
    @IBAction func btnAccountDetailsBack(_ sender: Any) {
        print(segueUsed)
        if segueUsed == 1 {
            self.performSegue(withIdentifier: "profilePageToHomepage", sender: self)
        } else if segueUsed == 2 {
            self.performSegue(withIdentifier: "profilePageToTicketBudgetingPage", sender: self)
        } else if segueUsed == 3 {
            self.performSegue(withIdentifier: "profilePageToAddTicketPage", sender: self)
        }
        
    }
    
    //This button alerts the user that they pressed the logout button and if they press yes it logs them out.
    @IBAction func btnLogout(_ sender: Any) {
        logoutAlert()
    }
    
    //FUNCTION:
    
    //This function is an alert that asks the user if they want to logout, if they press yes it will send them to the login page, clear the current user credentials and clears the labels.
    func logoutAlert() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Yes", style: .default) { action in
            currentUserCredentials.username = ""
            currentUserCredentials.password = ""
            self.lblUsernameDisplay.text = ""
            self.lblPasswordDisplay.text = ""
            self.performSegue(withIdentifier: "accountDetailsToLogin", sender: self)
        }
        let noButton = UIAlertAction(title: "No", style: .default)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    //This is all the stuff that is loaded when the page first loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        //This automatically sets the display to the current user credentials.
        lblUsernameDisplay.text = currentUserCredentials.username
        lblPasswordDisplay.text = currentUserCredentials.password
        // Do any additional setup after loading the view.
    }
}
