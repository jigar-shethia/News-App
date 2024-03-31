//
//  Persistence.swift
//  News App
//
//  Created by Jigar Shethia on 30/03/24.
//

import CoreData

final class PersistenceController {
    static let shared = PersistenceController()

    private let container: NSPersistentContainer
    let viewContext: NSManagedObjectContext

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "News_App")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
              
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        viewContext = container.viewContext
        print(self.container.persistentStoreCoordinator.persistentStores.first?.url!)
    }
}
