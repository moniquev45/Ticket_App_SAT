//
//  LoginViewController.swift
//  Ticket App SAT
//
//  Created by Monique Vilardo on 20/6/2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    //OUTLETS:
    //Inputs:
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    //BUTTONS:
    
    //This button sends the user to the create and account page.
    @IBAction func btnCreateAcccountDirect(_ sender: Any) {
        self.performSegue(withIdentifier: "createAccountDirectChange", sender: self)
    }
    
    //This button logins the user into their account and sends the user to the homepage.
    @IBAction func btnLogin(_ sender: Any) {
        
        //This is the exsistance check, if the user hasn't input a value it will send an alert.
        if txtUsername.text != "" && txtPassword.text  != "" {
            
            currentUserCredentials.username = txtUsername.text!
            currentUserCredentials.password = txtPassword.text!
            
            print(currentUserCredentials.username)
            print(currentUserCredentials.password)
            
            //This encrypts the username and password.
            currentUserCredentials.username = cipherText(message: txtUsername.text!, shift: 8)
            currentUserCredentials.password = cipherText(message: txtPassword.text!, shift: 8)
            
            print(currentUserCredentials.username)
            print(currentUserCredentials.password)
            
            //This is searches if the username and password exsit if they don't an alert will be displayed.
            if linearSearch(array: userCredentials, searchUser: currentUserCredentials) == true {
                
                currentUserCredentials.username = cipherText(message: currentUserCredentials.username, shift: -8)
                currentUserCredentials.password = cipherText(message: currentUserCredentials.password, shift: -8)
                
                
                //This sends the user back to the homepage.
                    self.performSegue(withIdentifier: "loginToHomePageChange", sender: self)
                
            } else {
                //This is the alert that is displayed if the user doesn't input the a username or password the exsits.
                let alert = UIAlertController(title: "Error", message: "Incorrect username/password supplied. Please try again.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .default) { action in
                    currentUserCredentials.username = ""
                    currentUserCredentials.password = ""
                    self.txtUsername.text = ""
                    self.txtPassword.text = ""
                }
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {
            //This is the exsistance check alert that is displayed if the users don't pass the exsistance check.
            let alert = UIAlertController(title: "Error", message: "Please fill all text boxes.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default) { action in
            }
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //FUNCTION:
    
    //This is the linear search function, it finds specific value in the array.
    func linearSearch(array: [UserCredentials], searchUser: UserCredentials) -> Bool {
         
            for currentValue in array {
                if searchUser.password == currentValue.password && searchUser.username == currentValue.username {
                    return true
                }
            }
            return false
            
    }
    
    //This function encrypts/decrypts the inputed value by a specific amount.
    func cipherText(message: String, shift: Int) -> String {
       let encrypt = message.unicodeScalars.map {
          //loop through each character in message
          //identify number representation
          //add shift to number
          UnicodeScalar(Int($0.value) + shift)!
       }

       //return shifted message
       return String(String.UnicodeScalarView(encrypt))
    }
    
    //This function saves all edited ticket data to the user credential json file.
    func saveToFileCredentials() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(userCredentials)
            let jsonURL = URL(fileURLWithPath: "userCredentials.json", relativeTo: directoryURL)
            
            try jsonData.write(to: jsonURL, options: .atomic)
            print("File was successfully exported")
        } catch {
            print("File could not be exported: \(error.localizedDescription)")
        }
    }
    
    //This function is used to load data from the user credential json file into your application.
    func loadFileCredentials() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        print(directoryURL)
        do {
            let jsonURL = URL(fileURLWithPath: "userCredentials.json", relativeTo: directoryURL)
            let jsonData = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            userCredentials = try decoder.decode([UserCredentials].self, from: jsonData)
            print("JSON file was successfully imported")
            print(directoryURL)
        } catch {
            print("File could not be imported: \(error.localizedDescription)")
        }
    }
    
    //This is all the stuff that is loaded when the page first loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        //This loads all the data when the screen is loaded.
        loadFileCredentials()
    }
    
}
