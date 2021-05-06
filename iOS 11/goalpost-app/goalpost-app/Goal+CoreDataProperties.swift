//
//  Goal+CoreDataProperties.swift
//  goalpost-app
//
//  Created by robot on 5/6/21.
//  Copyright © 2021 robot. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var goalCompletionValue: Int32
    @NSManaged public var goalDescription: String?
    @NSManaged public var goalProgress: Int32
    @NSManaged public var goalType: String?

}
