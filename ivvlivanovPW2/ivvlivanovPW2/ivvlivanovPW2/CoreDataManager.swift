//
//  CoreDataManager.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 07.11.2025.
//


import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()

    private let containerName = "WishModel" 
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: containerName)
        persistentContainer.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("CoreData load error: \(error)")
            } else {
                
            }
        }
    }

    // MARK: - Save event
    func saveEvent(title: String, descriptionText: String, startDate: String, endDate: String) throws {
        let ctx = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "WishEvent", in: ctx)!
        let obj = NSManagedObject(entity: entity, insertInto: ctx)
        obj.setValue(title, forKey: "title")
        obj.setValue(descriptionText, forKey: "descriptionText")
        obj.setValue(startDate, forKey: "startDate")
        obj.setValue(endDate, forKey: "endDate")

        try ctx.save()
    }

    // MARK: - Fetch events
    func fetchEvents() throws -> [WishEventModel] {
        let ctx = persistentContainer.viewContext
        let req = NSFetchRequest<NSManagedObject>(entityName: "WishEvent")
        req.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
        let results = try ctx.fetch(req)
        return results.map { obj in
            let title = obj.value(forKey: "title") as? String ?? ""
            let descriptionText = obj.value(forKey: "descriptionText") as? String ?? ""
            let startDate = obj.value(forKey: "startDate") as? String ?? ""
            let endDate = obj.value(forKey: "endDate") as? String ?? ""
            return WishEventModel(title: title, description: descriptionText, startDate: startDate, endDate: endDate)
        }
    }
}
