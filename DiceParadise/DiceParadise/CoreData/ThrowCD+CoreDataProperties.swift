//
//  ThrowCD+CoreDataProperties.swift
//  DiceParadise
//
//  Created by Niklas Lieven on 30.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//
//

import Foundation
import CoreData


extension ThrowCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThrowCD> {
        return NSFetchRequest<ThrowCD>(entityName: "ThrowCD")
    }

    @NSManaged public var date: Date?
    @NSManaged public var total: Int16
    @NSManaged public var dices: NSSet?
    
    public var diceArray: [DiceCD] { // array sorted by maxNumber and numberRolled
        let set = dices as? Set<DiceCD> ?? []
        return set.sorted {
            if $0.maxNumber == $1.maxNumber {
                return $0.rolledNumber < $1.rolledNumber
            } else {
                return $0.maxNumber < $1.maxNumber
            }
        }
    }

}

// MARK: Generated accessors for dices
extension ThrowCD {

    @objc(addDicesObject:)
    @NSManaged public func addToDices(_ value: DiceCD)

    @objc(removeDicesObject:)
    @NSManaged public func removeFromDices(_ value: DiceCD)

    @objc(addDices:)
    @NSManaged public func addToDices(_ values: NSSet)

    @objc(removeDices:)
    @NSManaged public func removeFromDices(_ values: NSSet)

}
