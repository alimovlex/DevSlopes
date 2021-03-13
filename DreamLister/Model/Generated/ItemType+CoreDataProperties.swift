//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by robot on 3/13/21.
//  Copyright © 2021 robot. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
