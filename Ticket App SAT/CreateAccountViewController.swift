//
//  CreateAccountViewController.swift
//  Ticket App SAT
//
//  Created by Monique Vilardo on 20/6/2024.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    //OUTLETS:
    //Inputs:
    @IBOutlet weak var txtUsernameCreate: UITextField!
    @IBOutlet weak var txtPasswordCreate: UITextField!
    @IBOutlet weak var txtPasswordConfirmCreate: UITextField!
    
    
    //BUTTONS:
    
    //This buttons will send the user to the login page when pressed.
    @IBAction func btnBackToLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "createAccountChange", sender: self)
    }
    
    //This button creates a new user account/
    @IBAction func btnCreateAccount(_ sender: Any) {
        
        //This is the exsistance check, if the user hasn't input a value it will send an alert.
        if txtUsernameCreate.text != "" && txtPasswordCreate.text != "" && txtPasswordConfirmCreate.text != "" {
            var username: String = txtUsernameCreate.text!
            let password: String = txtPasswordCreate.text!
            let confirmPassword: String = txtPasswordConfirmCreate.text!
        
            //This checks if the password is equal to the password confirm.
            if password == confirmPassword {
                
                print(username)
                print(password)
                
                //This encrypts the username and password.
                currentUserCredentials.username = cipherText(message: username, shift: 8)
                currentUserCredentials.password = cipherText(message: password, shift: 8)
                
                print(currentUserCredentials.username)
                print(currentUserCredentials.password)
                
                username = cipherText(message: username, shift: 8)
                
                //If the username doesn't already exsit then the user can create an account if not an alert is displayed.
                if linearSearch(array: userCredentials, searchFor: username, searchType: "username") == false {
                    
                    //This creates a new user credential and appends it to the array.
                    var newUserCredentials: UserCredentials = UserCredentials.init(username: currentUserCredentials.username, password: currentUserCredentials.password)
                    
                    userCredentials.append(newUserCredentials)
                    
                    //This saves the data to the user credential json file.
                    saveToFileCredentials()
                    
                    //This sends the user back to the login page.
                    self.performSegue(withIdentifier: "createAccountChange", sender: self)
                    
                } else if linearSearch(array: userCredentials, searchFor: username, searchType: "username") == true {
                    
                    //This is the alert that tells the user the account alread exsts and it clears all displayed values when the user presses ok.
                    let alert = UIAlertController(title: "Error", message: "This account already exsists, please create a new username.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "Ok", style: .default) { action in
                        self.txtUsernameCreate.text = ""
                        self.txtPasswordCreate.text = ""
                        self.txtPasswordConfirmCreate.text = ""
                    }
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            } else {
                //This is the alert that is displayed if the user doesn't input the same two passwords.
                let alert = UIAlertController(title: "Error", message: "Please enter the correct user details.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .default) { action in
                    self.txtUsernameCreate.text = ""
                    self.txtPasswordCreate.text = ""
                    self.txtPasswordConfirmCreate.text = ""
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
    
    //This is the linear search function, it finds specific value in the array.
    func linearSearch(array: [UserCredentials], searchFor: String, searchType: String) -> Bool {
        
        //This finds the value in the password part of the stuct.
        if searchType == "password" {
            
            for currentValue in array {
                if searchFor == currentValue.password {
                    return true
                }
            }
            return false
            
            //This finds the value in the username part of the stuct.
        } else if searchType == "username" {
            
            for currentValue in array {
                if searchFor == currentValue.username {
                    return true
                }
            }
            return false
            
        }
        
        return false
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
