//
//  ContentView.swift
//  FilmLog
//
//  Created by Aroon Narayanan on 12/25/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var showingStockList = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                Text("Kodak Portra").font(.largeTitle)
                Text("ISO 400").font(.title2)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity
            )
            .padding()
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
            )
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: finishReel) {
                        Label("Finish Reel", systemImage: "film")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: showStockList) {
                        Label("Film Stocks", systemImage: "list.and.film")
                    }
                }
            }
            .navigationTitle(Text("You're Shooting"))
            .sheet(isPresented: $showingStockList) {
                StockList(viewMode: .ViewOnly)
            }
           
        } .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func finishReel() {
        
    }
    
    private func showStockList() {
        showingStockList.toggle()
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.landscapeLeft)
    }
}
