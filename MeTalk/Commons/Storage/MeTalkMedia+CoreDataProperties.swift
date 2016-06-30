//
//  MeTalkMedia+CoreDataProperties.swift
//  MeTalk
//
//  Created by yu chung hyun on 2016. 5. 1..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MeTalkMedia {

    @NSManaged var audioPeeks: NSData?
    @NSManaged var createDate: NSDate?
    @NSManaged var duration: NSNumber?
    @NSManaged var filePath: String?
    @NSManaged var mediaId: String?
    @NSManaged var title:String?
    @NSManaged var desc:String?
    @NSManaged var location:NSData?
}
