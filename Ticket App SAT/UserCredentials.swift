//
//  UserCredentials.swift
//  Ticket App SAT
//
//  Created by Monique Vilardo on 28/6/2024.
//

import Foundation

//This is the struct that stores all user credentials data.
struct UserCredentials: Codable {
    var username: String
    var password: String
    
    func toString() -> String {
        return ("\(username), \(password)")
    }
}

//This is the user credentials array.
var userCredentials: [UserCredentials] = []

//This is the current user credentials variable that holds the current user's credentials.
var currentUserCredentials: UserCredentials = UserCredentials.init(username: "", password: "")

//This is the segue variable that changes depending on the page it is on so that the user can go back to the page they chose when they press the back button on the profile page.
var segueUsed: Int = 0
