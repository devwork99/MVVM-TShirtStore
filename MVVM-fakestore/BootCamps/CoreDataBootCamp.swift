//
//  CoreDataBootCamp.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 20/01/2025.
//

import SwiftUI
import CoreData

class CoreDataViewModel  : ObservableObject{
    
    let container : NSPersistentContainer
    
    @Published var savedEntities : [FruitEntity] = []
    
    init() {
        self.container = NSPersistentContainer(name: "FruitContainer")
        self.container.loadPersistentStores { description, error in
            if let err = error {
                print("CoreDataViewModel - Error -\(err.localizedDescription)")
            }else{
                print("CoreData load Success")
            }
        }
        
        fetchFruits()
    }
    
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error - fetchFruits - \(error.localizedDescription)")
        }
    }
    
    func add(name:String){
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = name
        saveData()
    }
   
    func update(entity:FruitEntity){
        let name = entity.name ?? ""
        entity.name = name + "!"
        saveData()
    }
    
    func deleteItem(indxSet:IndexSet){
        guard let indx = indxSet.first else{
            return
        }
        
        let entity = savedEntities[indx]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData(){
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error  {
            print("Error - saveData - \(error.localizedDescription)")
        }
    }
}


struct CoreDataBootCamp: View {
    
    @StateObject var vm = CoreDataViewModel()
    
    @State var textFieldText : String = ""
    
    var body: some View {
        NavigationView {
            
            VStack (spacing:20){
                
                TextField("Add fruit name", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth:.infinity)
                    .frame(height:55)
                    .background(Color(.lightGray))
                    .padding(.horizontal)
                    .cornerRadius(10)
                
                
                Button {
                    guard !textFieldText.isEmpty else {return}
                    vm.add(name: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity)
                        .frame(height:55)
                        .background(Color(.systemPink))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                

                
                List{
                    ForEach(vm.savedEntities) { entity in
                        HStack{
                            Text(entity.name ?? "NA")
                                .onTapGesture {
                                    vm.update(entity: entity)
                                }
                        }
                    }
                    .onDelete(perform:vm.deleteItem)
                }
                .listStyle(.plain)
                
            }
            
            .navigationTitle("Fruits")
            
        }
        
    }
}

struct CoreDataBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootCamp()
    }
}
