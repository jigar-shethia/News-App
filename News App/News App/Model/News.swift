//
//  News.swift
//  News App
//
//  Created by Jigar Shethia on 29/03/24.

import Foundation
struct NewsResponse: Codable {
    let response: Response
}

struct Response: Codable {
    let docs: [NewsDetials]
}


struct NewsDetials: Codable,Identifiable {
    var id = UUID()
    let headline: Headline
    let abstract: String
    let pub_date: String
    let multimedia: [Multimedia]
    var date: Date = Date()
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.headline = try container.decode(Headline.self, forKey: .headline)
        self.abstract = try container.decode(String.self, forKey: .abstract)
        self.pub_date = try container.decode(String.self, forKey: .pub_date)
        self.multimedia = try container.decode([Multimedia].self, forKey: .multimedia)
        self.date = convertStringToDate(dateString: pub_date)
    }
    func convertStringToDate(dateString:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.date(from:dateString) ?? Date()
    }
}

struct Headline: Codable {
    let main: String
}

struct Multimedia: Codable {
    let url: String
    var imageUrl:URL?
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
        createUrlForImage(link: url)
    }
    mutating func createUrlForImage(link:String) {
        self.imageUrl = URL(string:"\(APIConstants.imageBaseURL)\(link)")
    }
}

struct News: Identifiable {
    var id: UUID
    let title: String
    let description: String
    let date: Date
    let imageUrl: URL?
}

