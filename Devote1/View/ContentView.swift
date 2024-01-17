//
//  ContentView.swift
//  Devote1
//
//  Created by Nicolai Bodean on 09.01.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
     //Mark - 1 Property
    @State var task: String = ""
    
    private var isButtonDisabled: Bool {
        task.isEmpty
    }
    
     //Mark - Fetching Data
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
     //Mark - Function
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            hideKeyboard()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
     //Mark - Body

    var body: some View {
            NavigationView {
                VStack {
                    VStack(spacing: 16) {
                    TextField("New Task", text: $task)
                            .padding()
                            .background(
                                Color(UIColor.systemGray6))
                            .cornerRadius(10)
                        
                        Button(action: {
                            addItem()
                        }, label: {
                            Spacer()
                            Text("Save")
                            Spacer()
                        })
                        .disabled(isButtonDisabled)
                        .padding()
                        .font(.headline)
                        .foregroundStyle(.white)
                        .background(isButtonDisabled ? Color.gray : Color.pink)
                        .cornerRadius(10)
                    }//VStack
                    .padding()
                    
                    List {
                        ForEach(items) { item in
                        
                            VStack(alignment: .leading) {
                                Text(item.task ?? "")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }//List Item
                        }
                        .onDelete(perform: deleteItems)
                    }//List
                }//VStack
                .navigationTitle("Daily Tasks")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                   
            }//toolbar
            }//NavigationView
            Text("Select an item")
        
    }


}



#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
