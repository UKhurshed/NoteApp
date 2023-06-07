//
//  NoteEntity+CoreDataProperties.swift
//  NoteApp
//
//  Created by Khurshed Umarov on 07.06.2023.
//
//

import Foundation
import CoreData


extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var note: String?
    @NSManaged public var priority: Int16

}

extension NoteEntity : Identifiable {

}
