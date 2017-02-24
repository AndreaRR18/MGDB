import Foundation
import UIKit
import CoreData

func saveCompany(idCompany: Int32, nameCompany: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    var arrayCompanies: [NSManagedObject] = []
    let context = appDelegate.persistentContainer.viewContext
    let newCompany = NSEntityDescription.insertNewObject(forEntityName: "CompaniesData", into: context)
    newCompany.setValue(idCompany, forKey: "idCompany")
    newCompany.setValue(nameCompany, forKey: "nameCompany")
    do {
        try context.save()
        arrayCompanies.append(newCompany)
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

func fetchCompany(id: Int32) -> String? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
    var stringOfCompanies: String?
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CompaniesData")
    request.returnsObjectsAsFaults = false
    do {
        let results = try context.fetch(request)
        for result in results as! [NSManagedObject] {
            if id == result.value(forKey: "idCompany") as? Int32 {
                stringOfCompanies = result.value(forKey: "nameCompany") as? String
                return stringOfCompanies
            }
        }
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
    return nil
}

func nameCompanyDB(id: [Int], callback:@escaping (String, Bool) -> ()) {
    var companies: [String] = []
    var new = true
    id.forEach{ idCompany in
        if let nameCompany = fetchCompany(id: Int32(idCompany)) {
            new = false
            companies.append(nameCompany)
        } else {
            let decodeJSON = DecodeJSON(url: getUrlIDCompany(idCompany: idCompany))
            decodeJSON.getCompanies(callback: { arrayCompanies in
                arrayCompanies.forEach({
                    companies.append( $0.name )
                    saveCompany(idCompany: Int32($0.idCompany), nameCompany: $0.name)
                })
                
            })
        }
    }
    callback(companies.joined(separator: "-"), new)
}



