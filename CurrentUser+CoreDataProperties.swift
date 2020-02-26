//
//  CurrentUser+CoreDataProperties.swift
//  huduma
//
//  Created by macbook on 07/03/2020.
//  Copyright © 2020 Arusey. All rights reserved.
//
//

import Foundation
import CoreData


extension CurrentUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentUser> {
        return NSFetchRequest<CurrentUser>(entityName: "CurrentUser")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?

}
