//
//  DiceCD+CoreDataProperties.swift
//  DiceParadise
//
//  Created by Niklas Lieven on 30.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//
//

import Foundation
import CoreData


extension DiceCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiceCD> {
        return NSFetchRequest<DiceCD>(entityName: "DiceCD")
    }

    @NSManaged public var maxNumber: Int16
    @NSManaged public var rolledNumber: Int16
    @NSManaged public var thrown: DiceCD?

}
