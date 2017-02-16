import Foundation
import UIKit
import Argo

class CacheGame {
    
    private enum FileErrors: Error {
        case JsonNotSerialized
        case FileNotSaved
        case ImageNotConvertedToData
        case FileNotRead
        case FileNotFound
    }
    
    enum FileExtension: String {
        case TXT = ".txt"
        case JPG = ".jpg"
        case JSON = ".json"
    }
    
    private let directory: FileManager.SearchPathDirectory
    private let directoryPath: String
    private let fileManager = FileManager.default
    private let fileName: String
    private let filePath: String
    private let fullyQualifiedPath: URL
    private let subDirectory: String
    
    var fileExists: Bool {
        get {
            return fileManager.fileExists(atPath: fullyQualifiedPath.path)
        }
    }
    
    var directoryExists: Bool {
        get {
            var isDir = ObjCBool(true)
            return fileManager.fileExists(atPath: filePath, isDirectory: &isDir)
        }
    }
    
    init(fileName: String, fileExtension: FileExtension, subDirectory: String, directory: FileManager.SearchPathDirectory) {
        self.fileName = (fileName + fileExtension.rawValue)
        self.subDirectory = "/\(subDirectory)"
        self.directory = directory
        
        self.directoryPath = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true)[0]
        self.filePath = directoryPath + self.subDirectory
        let path: String = "\(filePath)/\(self.fileName)"
        self.fullyQualifiedPath = URL(string: path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!)!
        createDirectory()
        print(self.directoryPath)
    }
    
    private func createDirectory() {
        if !directoryExists {
            do {
                try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: false, attributes: nil)
            } catch {
                print("An Error was generated creating directory")
            }
        }
    }
    
    func savefile(string fileContents: String) throws {
        do {
            try fileContents.write(to: fullyQualifiedPath, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            throw error
        }
    }
    
    func saveFile(dataForJson: Data) throws {
        do {
            if !fileManager.createFile(atPath: fullyQualifiedPath.path, contents: dataForJson, attributes: nil) {
                throw FileErrors.FileNotSaved
            }
        } catch {
            print(error)
            throw FileErrors.FileNotSaved
        }
    }
    
    convenience init(fileName: String, fileExtension: FileExtension, subDirectory: String) {
        self.init(fileName: fileName, fileExtension: fileExtension, subDirectory: subDirectory, directory: .applicationSupportDirectory)
    }
    
    convenience init(fileName: String, fileExtension: FileExtension) {
        self.init(fileName: fileName, fileExtension: fileExtension, subDirectory: "", directory: .applicationSupportDirectory)
    }
    
    func saveFile(image: UIImage) throws {
        guard let data = UIImageJPEGRepresentation(image, 1.0) else { throw FileErrors.ImageNotConvertedToData }
        if !fileManager.createFile(atPath: fullyQualifiedPath.path, contents: data, attributes: nil) {
            throw FileErrors.FileNotSaved
        }
    }
    
    func getContentsOfFile() throws -> String {
        guard fileExists else { throw FileErrors.FileNotFound }
        var returnString: String
        do {
            returnString = try String(contentsOfFile: fullyQualifiedPath.path, encoding: String.Encoding.utf8)
        } catch {
            throw FileErrors.FileNotRead
        }
        return returnString
    }
    
    func getImage() throws -> UIImage {
        guard fileExists else { throw FileErrors.FileNotFound }
        guard let image = UIImage(contentsOfFile: fullyQualifiedPath.path) else { throw FileErrors.FileNotRead }
        return image
    }
    
    func getJSONData() throws -> [Game]? {
        guard fileExists else { throw FileErrors.FileNotFound }
        do {
            let data = try NSData(contentsOfFile: fullyQualifiedPath.path, options: NSData.ReadingOptions.mappedIfSafe)
            let jsonDictionary = parsingJsonDataGame(data: data as Data)
            return jsonDictionary
        } catch {
            throw FileErrors.FileNotRead
        }
    }
    func parsingJsonDataGame(data: Data) -> [Game]? {
        var games: [Game]? = []
        let jsonResult: Any? = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        if let j: Any = jsonResult {
            games = decode(j)
        }
        return games.flatMap{ $0 }
    }

}

