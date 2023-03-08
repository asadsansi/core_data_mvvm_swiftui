//
//  ContentView.swift
//  core_data
//
//  Created by Asad Ullah Sansi on 08/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var taskListVM = TaskListViewModel()
    
    func deleteTask(at offset: IndexSet){
        offset.forEach{ index in
            
            let task = taskListVM.tasks[index]
            taskListVM.delete(task )
            
        }
        
        taskListVM.getAllTasks()
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter Task", text: $taskListVM.title).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Enter Description", text: $taskListVM.descrip).textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save"){
                    taskListVM.save()
                    taskListVM.getAllTasks()
                }
            }
            List{
                ForEach(taskListVM.tasks,id: \.id){ task in
                    HStack {
                        Text("\(task.title)")
                        Spacer()
                       Text("\(task.descrip)")
                    }
                }.onDelete(perform: deleteTask)
                
                
            }
          
            Spacer()
            
        }
        .padding().onAppear{
            taskListVM.getAllTasks()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
