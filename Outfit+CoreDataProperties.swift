//
//  Outfit+CoreDataProperties.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-05.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import CoreData


extension Outfit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Outfit> {
        return NSFetchRequest<Outfit>(entityName: "Outfit")
    }

    @NSManaged public var name: String?
    @NSManaged public var itemID: NSObject?

}
