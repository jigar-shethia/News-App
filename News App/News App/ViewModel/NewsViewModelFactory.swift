//
//  NewsViewModelFactory.swift
//  News App
//
//  Created by Jigar Shethia on 30/03/24.
//

import Foundation

final class NewsViewModelFactory {
    
    static func createTaskViewModel() -> NewsViewModel {
        
        return NewsViewModel(newsCBManger: NewsCDMangerImplemenatation())
    }
}
