//
//  Ticket+CoreDataClass.swift
//  OnTheRoad
//
//  Created by Evandro Harrison Hoffmann on 21/10/2016.
//  Copyright © 2016 Evandro Harrison Hoffmann. All rights reserved.
//

import Foundation
import CoreData

extension Ticket {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ticket> {
        return NSFetchRequest<Ticket>(entityName: "Ticket");
    }
    
    @NSManaged public var ticketId: NSNumber
    @NSManaged public var providerLogo: String?
    @NSManaged public var type: NSNumber?
    @NSManaged public var priceInEuros: NSNumber
    @NSManaged public var departureTime: Date?
    @NSManaged public var arrivalTime: Date?
    @NSManaged public var numberOfStops: NSNumber
    
}

@objc(Ticket)
public class Ticket: NSManagedObject {
    
    static func tickets(withType type: Int) -> [Ticket]?{
        return list(predicate: NSPredicate(format: "type == %d", type)) as? [Ticket]
    }
    
    //MARK: - JSON PARSING
    
    static func parseJSONArray(_ jsonArray: AnyObject?, type: Int) -> [Ticket]{
        var objects = [Ticket]()
        
        if let jsonArray = jsonArray as? [[String: AnyObject]] {
            for object in jsonArray {
                if let parsedObject = parseJSONObject(object, type: type){
                    objects.append(parsedObject)
                }
            }
        }
        
        return objects
    }
    
    static func parseJSONObject(_ jsonObject: [String: AnyObject], type: Int) -> Ticket?{
        let ticketId = parseInt(jsonObject, key: "id")
        if let ticket = getObject(predicate: NSPredicate(format: "ticketId == %d", ticketId.intValue), createIfNil: true) as? Ticket {
            ticket.ticketId = ticketId
            ticket.providerLogo = parseString(jsonObject, key: "provider_logo")
            ticket.priceInEuros = parseDouble(jsonObject, key: "price_in_euros")
            ticket.departureTime = parseDate(jsonObject, key: "departure_time", format: "HH:mm")
            ticket.arrivalTime = parseDate(jsonObject, key: "arrival_time", format: "HH:mm")
            ticket.numberOfStops = parseInt(jsonObject, key: "number_of_stops")
            ticket.type = NSNumber(value: type)
            
            return ticket
        }
        
        return nil
    }
}
