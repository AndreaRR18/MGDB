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
    let logo: Logo? //logo
}

struct Logo {
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


extension Logo: Decodable {
    static func decode(_ json: JSON) -> Decoded<Logo> {
        return curry(Logo.init)
            <^> json <|? "url"
            <*> json <|? "width"
            <*> json <|? "height"
        
    }
}

//
//func getCompanyName(id: Int) -> String {
//    let companies = [CompaniesMO]()
//    var fetchResultController: NSFetchedResultsController<CompaniesMO>
//    let fetchRequest:NSFetchRequest<CompaniesMO> = CompaniesMO.fetchRequest()
//    let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
//    fetchRequest.sortDescriptors = [sortDescriptor]
//        
//    if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
//        let request: NSFetchRequest<CompaniesMO> = CompaniesMO.fetchRequest()
//        let context = appDelegate.persistentContainer.viewContext
//        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//        fetchResultController.delegate = self
//    }
//    let decodedJSON = DecodeJSON(url: getUrlIDCompany(id: id), apiKey: "ESZw4bgv1bmshrOge5OFyDGSG1BQp1vRtU9jsnrhB6thY2fEN5", httpHeaderField: "X-Mashape-Key")
//    decodedJSON.getCompanies(callback: { arrayCompanies in
//        return arrayCompanies.first?.name
//    })
//    return "\(companies.first?.id)"
//}
