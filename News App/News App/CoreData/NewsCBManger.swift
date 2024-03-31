//
//  NewsRepository.swift
//  News App
//
//  Created by Jigar Shethia on 30/03/24.
//
import CoreData
import Foundation
 
protocol NewsCBManger {
    func get() -> [News]
    func add(news:[News]) -> Bool
    func delete() -> Bool
}

class NewsCDMangerImplemenatation: NewsCBManger {
   
    

    private let managedObjectContext: NSManagedObjectContext = PersistenceController.shared.viewContext
    
    func get() -> [News] {
        let fetchRequest = NewsEntity.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(NewsEntity.date), ascending: false)
            fetchRequest.sortDescriptors = [sort]
        do{
            let result = try managedObjectContext.fetch(fetchRequest)
            if(!result.isEmpty){
                return result.map {News(id: $0.id ?? UUID(), title: $0.title ?? "", description: $0.newsDescription  ?? "" , date: $0.date  ?? Date(), imageUrl: $0.imageUrl ?? URL(string:""))}
            }
        }
        catch{
            print("error = \(error.localizedDescription)")
        }
        return []
    }

    
    func add(news: [News]) -> Bool {
        
        
        for newsArticle in news{
            let newsEntity = NewsEntity(context: managedObjectContext)
            newsEntity.id = UUID()
            newsEntity.title = newsArticle.title
            newsEntity.newsDescription = newsArticle.description
            newsEntity.imageUrl = newsArticle.imageUrl
            newsEntity.date = newsArticle.date
        }
        
        do {
            try managedObjectContext.save()
            return true
        }
        catch {
            print("error on add = \(error.localizedDescription)")
        }
        return false
    }
    
    func delete() -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
                let entities = try managedObjectContext.fetch(fetchRequest)
                
                for entity in entities {
                    if let entityObject = entity as? NSManagedObject {
                        managedObjectContext.delete(entityObject)
                    }
                }
                
                try managedObjectContext.save()
                return true
            } catch {
                print("Error deleting entities: \(error)")
                return false
            }
    }
}
