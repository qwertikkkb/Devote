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
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State var task: String = ""
    @State private var showNewTaskItem = false
 
    
     //Mark - Fetching Data
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
     //Mark - Function
   

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
                ZStack {
                     //Mark - mainView
                    
                    VStack {
                         //Mark - Headser
                        HStack(spacing: 10) {
                            //TITLE
                            Text("Devote")
                                .font(.system(.largeTitle, design: .rounded))
                                .fontWeight(.heavy)
                                .padding(.leading, 4)
                                Spacer()
                            
                            
                            //EDIT BUTTON
                                EditButton()
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .padding(.horizontal, 10)
                                .frame(minWidth: 70, minHeight: 24)
                                .background(
                                    Capsule().stroke(Color.white, lineWidth: 2)
                                )
                            //APPEARANCE BUTTON
                            Button {
                                //TOGGLE APPEARANCE
                                isDarkMode.toggle()
                                playSound(sound: "sound-tap", type: "mp3")
                                feedback.notificationOccurred(.success)
                            } label: {
                                Image(systemName: isDarkMode ?"moon.circle.fill" : "moon.circle")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .font(.system(.title, design: .rounded))
                            }

                            
                        }//HSTAck
                        .padding()
                        .foregroundStyle(.white)
                        Spacer(minLength: 80)
                        
                         //Mark - New task button
                        
                        Button {
                            showNewTaskItem = true
                            playSound(sound: "sound-ding", type: "mp3")
                            feedback.notificationOccurred(.success)
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30, weight: .semibold, design: .rounded))
                            Text("New Task")
                                .font(.system(size: 24, weight: .bold, design: .rounded))}
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                                .clipShape(Capsule())
                        )
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)

                        
                         //Mark - Tasks
                            List {
                                ForEach(items) { item in
                                    ListRowItemView(item: item)
                                }
                                .onDelete(perform: deleteItems)
                            }//List
                            
                            .listStyle(InsetGroupedListStyle())
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                            .cornerRadius(15)
                            .padding(.vertical, 60)
                            .padding(.horizontal, 20)
                            .frame(maxWidth: 640)
                        
                       
                    }//VStack
                    .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                    .transition(.move(edge: .bottom))
                    .animation(.easeOut(duration: 0.5))
                    
                    //Mark - New task item
                    if showNewTaskItem {
                        BlankView(
                            backgroundColor: isDarkMode ? Color.black : Color.gray,
                            backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                            .onTapGesture {
                                withAnimation() {
                                    showNewTaskItem = false
                                }
                            }
                        
                        NewTaskItemView(isShowing: $showNewTaskItem)
                    }
                    
                }//ZStack
                .onAppear() {
                    UITableView.appearance().backgroundColor = UIColor.clear
                }
                .navigationBarTitle("Daily Tasks", displayMode: .large)
                .toolbar(.hidden)
               
                .background(
                BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                )
                .background(
                    backgroundGradient.ignoresSafeArea(.all)
                )
            }//NavigationView
            .navigationViewStyle(StackNavigationViewStyle())
    }
}



#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
