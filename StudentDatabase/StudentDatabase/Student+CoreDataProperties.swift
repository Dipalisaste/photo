//
//  Student+CoreDataProperties.swift
//  StudentDatabase
//
//  Created by Felix-ITS015 on 27/08/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var rollno: Int64
    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var marks: Float
    @NSManaged public var dob: NSDate?
    @NSManaged public var mobileno: Int64

}
