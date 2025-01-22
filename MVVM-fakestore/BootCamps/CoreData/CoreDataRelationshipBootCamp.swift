//
//  CoreDataRelationshipBootCamp.swift
//  MVVM-fakestore
//
//  Created by Muhammad Yasir on 20/01/2025.
//

import SwiftUI
import CoreData

//https://www.youtube.com/watch?v=huRKU-TAD3g


//3 entities
// BusinessEntity
// DepartmentEntity
// EmployeeEntity


//lets setup separate CoreDataManager, with container & context object.

//MARK: - CoreDataManager

class CoreDataManager {
    
    static let instance = CoreDataManager() //Singleton
    
    let container : NSPersistentContainer
    let context : NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let err = error {
                print("CoreDataManager error - \(err.localizedDescription)")
            }else{
                print("Container load successful")
            }
        }
        
        context = container.viewContext
    }

    
    func save(){
        do {
            try context.save()
            print("Entity Saved")
        } catch let error {
            print("CDManager Save error - \(error.localizedDescription)")
        }
        
    }
    
}


//MARK: - CoreDataRelationshipViewModel

class CoreDataRelationshipViewModel : ObservableObject {
    
    let manager = CoreDataManager()
    
    @Published var businesses : [BusinessEntity] = []
    @Published var departments : [DepartmentEntity] = []
    @Published var employees : [EmployeeEntity] = []
    
    
    init(){
        getBusinesses()
        getDepartments()
        getEmployee()
    }
    
    func getBusinesses(){
        let request = NSFetchRequest<BusinessEntity>(entityName:"BusinessEntity")
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetch businessEntity - \(error.localizedDescription)")
        }
    }
    
    func addBusiness(){
        let business = BusinessEntity(context:manager.context)
        business.name = "Facebook"
        
        //has 2 departments
        
        //business.departments = [departments[0], departments[1]]
        
        //has 1 employee
        //business.employee = [employees[1]]
        
        save()
    }
    
    //-----------------------
    func getDepartments(){
        let request = NSFetchRequest<DepartmentEntity>(entityName:"DepartmentEntity")
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Error fetch getDepartments - \(error.localizedDescription)")
        }
    }
    
    func addDepartment(){
        let department = DepartmentEntity(context: manager.context)
        department.name = "Engineering"
        //department.business = [businesses[0]]
        
        department.addToEmployee(employees[1])
        
        save()
    }
    //-----------------------
    
    func addEmployee(){
        let employee = EmployeeEntity(context: manager.context)
        employee.name = "Emily"
        employee.age = 35
        employee.dateOfJoin = Date()
        
        //employee.business = businesses[0]
        //employee.department = departments[0]
        
        
        save()
    }
    
    func getEmployee(){
        let request = NSFetchRequest<EmployeeEntity>(entityName:"EmployeeEntity")
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetch getEmployee - \(error.localizedDescription)")
        }
    }
    
    func save(){
        
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.manager.save()
            
            self.getBusinesses()
            self.getDepartments()
            self.getEmployee()
        })
    }
    
}



//MARK: - CoreDataRelationshipBootCamp

struct CoreDataRelationshipBootCamp: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing:10){
                    Button {
                        vm.addBusiness()
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height:55)
                            .frame(maxWidth:.infinity)
                            .background(Color.blue.cornerRadius(10))
                    }

                    
                    ScrollView(.horizontal, showsIndicators:true) {
                        HStack(alignment:.top){
                            ForEach(vm.businesses) { business in
                                BusinessesView(entity:business)
                            }
                        }
                    }
                    
                    
                    ScrollView(.horizontal, showsIndicators:true) {
                        HStack(alignment:.top){
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators:true) {
                        HStack(alignment:.top){
                            ForEach(vm.employees) { emp in
                                EmployeeView(entity: emp)
                            }
                        }
                    }
                    
                    
                }
                .padding(.horizontal)
                
            }
            
            .navigationTitle("Relationships")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct CoreDataRelationshipBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipBootCamp()
    }
}


//MARK: - Separate Views

struct BusinessesView : View {
    
    let entity : BusinessEntity
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: 10, content: {
            Text("Business : \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { depart in
                    Text(depart.name ?? "")
                }
            }
            
            if let employees = entity.employee?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { emp in
                    Text(emp.name ?? "")
                }
            }
        })
        .padding()
        .frame(maxWidth:300, alignment:.leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius:10)
        
    }
}

struct DepartmentView : View {
    
    let entity : DepartmentEntity

    var body: some View {
        
        VStack(alignment:.leading, spacing: 10, content: {
            Text("Department : \(entity.name ?? "")")
                .bold()
            
            if let businesses = entity.business?.allObjects as? [BusinessEntity] {
                Text("Businesses:")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees = entity.employee?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { emp in
                    Text(emp.name ?? "")
                }
            }
        })
        .padding()
        .frame(maxWidth:300, alignment:.leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius:10)
    }
}


struct EmployeeView : View {
    
    let entity : EmployeeEntity

    var body: some View {
        
        VStack(alignment:.leading, spacing: 10, content: {
            Text("Employee: \(entity.name ?? "")")
                .bold()
            Text("Age: \(entity.age)")
            Text("Joining: \(entity.dateOfJoin ?? Date())")
            
            Text("Business")
                .bold()
            Text(entity.business?.name ?? "")
            
            Text("Department")
                .bold()
            Text(entity.department?.name ?? "")
        })
        .padding()
        .frame(maxWidth:300, alignment:.leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius:10)
    }
}
