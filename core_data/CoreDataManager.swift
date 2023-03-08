//
//  CoreDataManager.swift
//  core_data
//
//  Created by Asad Ullah Sansi on 08/03/2023.
//

import Foundation
import CoreData

class CoreDataManager{
    
    
    let persistentContainer: NSPersistentContainer
   
    static let shared = CoreDataManager() // singleton
    
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    func getTaskById(id:NSManagedObjectID)->Task?{
        do{
            return try viewContext.existingObject(with: id) as? Task
      
        }catch{
            return nil
        }
    }
    
    func deleteTask(task: Task){
       
        viewContext.delete(task)
        
        save()
   
    }
    
    
    func getAllTasks() -> [Task]{
        
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
           return try viewContext.fetch(request)
        } catch  {
            return []
        }
        
    }
    
    
    func save(){
        do {
            try  viewContext.save()
            
        } catch  {
            viewContext.rollback()
            print(error.localizedDescription)
        }
       
    }
    
    private init() {  // make private for  singleton
        
        persistentContainer = NSPersistentContainer(name: "TodoAppModel")
        
        persistentContainer.loadPersistentStores{ (description,error) in
            
            
            self.persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

            
            if let err = error{
                fatalError("Unable to initialize the coredata stack \(err)")
            }
        }
    }
    
    
    
}
