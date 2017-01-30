import Foundation
import UIKit
import Runes
import Argo
import Curry
import CoreData

struct Companies {
    //required
    let idCompany: Int //id
    let name: String //name
    
    //optional
    let logo: LogoCompanies? //logo
}

struct LogoCompanies {
    //optional
    let url: String? //string
    let width: Int? //int
    let height: Int? //int
}

extension Companies: Decodable {
    static func decode(_ json: JSON) -> Decoded<Companies> {
        return curry(Companies.init)
            <^> json <| "id"
            <*> json <| "name"
            <*> json <|? "logo"
    }
}


extension LogoCompanies: Decodable {
    static func decode(_ json: JSON) -> Decoded<LogoCompanies> {
        return curry(LogoCompanies.init)
            <^> json <|? "url"
            <*> json <|? "width"
            <*> json <|? "height"
    }
}

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


func nameCompanyDB(id: Int?, callback:@escaping (String) -> ()) {
    if let idCompany = id {
        if let nameCompany = fetchCompany(id: Int32(idCompany)) {
            callback(nameCompany)
        } else {
            let decodeJSON = DecodeJSON(url: getUrlIDCompany(idCompany: idCompany), apiKey: "ESZw4bgv1bmshrOge5OFyDGSG1BQp1vRtU9jsnrhB6thY2fEN5", httpHeaderField: "X-Mashape-Key")
            decodeJSON.getCompanies(callback: { arrayCompanies in
                guard let idCompany = arrayCompanies.first?.idCompany, let nameCompany = arrayCompanies.first?.name else { return }
                saveCompany(idCompany: Int32(idCompany), nameCompany: nameCompany)
                callback(nameCompany)
            })
        }
    } else {
        callback("N.D.")
    }
}




