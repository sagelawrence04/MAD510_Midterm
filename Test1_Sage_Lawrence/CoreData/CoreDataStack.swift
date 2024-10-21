//
//  CoreDataStack.swift
//  Test1_Sage_Lawrence
//
//  Created by Sage Lawrence on 2024-10-21.
//

import Foundation
import CoreData

class CoreDataStack {
    private let dataModelName: String
    
    init(dataModelName: String) {
        self.dataModelName = dataModelName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.dataModelName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error occured: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    func saveContext(){
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch {
            if let nsError = error as NSError? {
                fatalError("Unresolved error when saving: \(nsError) = \(nsError.userInfo)")
            }
        }
    }
}
