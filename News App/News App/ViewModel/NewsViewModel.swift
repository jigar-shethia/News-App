//
//  NewsViewModel.swift
//  News App
//
//  Created by Jigar Shethia on 29/03/24.
//

import Foundation

final class NewsViewModel: ObservableObject {
    
    @Published var news: [News] = []
    let network : NetworkService
    private let newsCBManger: NewsCBManger
    
    init(newsCBManger: NewsCBManger, network: NetworkService) {
        self.newsCBManger = newsCBManger
        self.network = network

    }
    
    // Fetch Data from API using NetworkLayer.
    
    func fetchNews(for type: String) {
        let endPoint = NewsApi.getNewsFor(type: type)
        network.dataRequest(endPoint, objectType: NewsResponse.self) { [weak self]
            (result: Result<NewsResponse, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                handleSucdessRespnse(reponse: response)
            case let .failure(error):
                handleFailureRespnse(error: error)
            }
        }
        
    }
    
    private func handleSucdessRespnse(reponse: NewsResponse) {
        let dataToReturn = reponse.response.docs.map {News(id:UUID(), title: $0.headline.main, description: $0.abstract, date: $0.date, imageUrl: $0.multimedia[0].imageUrl)}
        DispatchQueue.main.async {
            //            self.news = dataToReturn
        }
        // Deleting previous data to prevent duplicate.
        // Mantianing last id can help in impleming this scenerio better.
        if(self.delete()) {
            if(self.add(news: dataToReturn)){
                self.get()
            } 
        }
    }
    
    private func handleFailureRespnse(error: NetworkError) {
        print(error)
        self.get()
    }
    
    // CoreDate Execution
    private func get(){
        DispatchQueue.main.async {
            self.news = self.newsCBManger.get()
        }
    }
    
    private func add(news:[News]) -> Bool {
        return newsCBManger.add(news: news)
    }
    
    private func delete() -> Bool{
        return newsCBManger.delete()
    }
    
}
