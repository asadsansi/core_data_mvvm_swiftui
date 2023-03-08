//
//  TaskListViewModel.swift
//  core_data
//
//  Created by Asad Ullah Sansi on 08/03/2023.
//

import Foundation
import CoreData

class TaskListViewModel: ObservableObject{
   
    
    var title: String = ""
    var descrip: String = ""
    
    @Published var tasks: [TaskViewModel] = []
    
    func getAllTasks(){
    
     tasks = CoreDataManager.shared.getAllTasks().map(TaskViewModel.init)
        
    }
    
    func delete(_ task: TaskViewModel){
        
        let existingTask = CoreDataManager.shared.getTaskById(id: task.id)
     
        if let existingTask = existingTask {
            CoreDataManager.shared.deleteTask(task: existingTask)
        }
        
        
    }
    
    func save(){
        
        let task = Task(context: CoreDataManager.shared.viewContext)
        task.title = title
        task.descrip = descrip
        CoreDataManager.shared.save()
    
    }

}


struct TaskViewModel{
    
    let task:Task
    
    var id: NSManagedObjectID{
        return task.objectID
    }
    var title: String{
        return task.title ?? ""
    }
    var descrip: String{
        return task.descrip ?? ""
    }
}
