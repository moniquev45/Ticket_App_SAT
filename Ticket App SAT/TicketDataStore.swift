//
//  TicketDataStore.swift
//  Ticket App SAT
//
//  Created by Monique Vilardo on 28/6/2024.
//

import Foundation

//This is the struct that stores all ticket data.
struct TicketDataStore: Codable {
    var showTitle: String
    var openingNight: String
    var closingNight: String
    var typeOfSeat: String
    var price: Float
    var genre: String
    var theatreType: String
    var theatreName: String
    var location: String
    var description: String
    
    //This formats the price input into a currancy format.
    func priceFormat() -> String {
        var priceFormating: String = String(format: "$%.02f", price)
        return priceFormating
    }
    
    //This is the string that you see initially see in a table.
    func toString() -> String {
        return "\(showTitle) | From: \(openingNight) to \(closingNight)"
    }
    
    //This is the extra details that is displayed once you press on a ticket in the tableview.
    func detailString() -> String {
        return "Type of Seat: \(typeOfSeat)\nLocation: \(location)\nPrice: \(priceFormat())\n\nGenre: \(genre)\nTheatre: \(theatreName)\n\nDescription: \(description)"
    }
}

//This is the ticket array.
var tickets: [TicketDataStore] = []
//This is the expanded ticket data index set variable.
var expandedIndexSet: IndexSet = []

//This is the searched ticket array.
var newSearchedTicketData: [TicketDataStore] = []
//This is the expanded searched ticket data index set variable.
var newExpandedIndexSet: IndexSet = []
