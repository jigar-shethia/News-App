//
//  NewsListView.swift
//  News App
//
//  Created by Jigar Shethia on 29/03/24.
//



import SwiftUI

struct NewsScreen: View {
    @ObservedObject var viewModel: NewsViewModel = NewsViewModelFactory.createTaskViewModel()
    
    var body: some View {
        VStack{
            if viewModel.news.count == 0 {
                ProgressView()
                Text("Loading…")
                    .padding(.top, 20)
            } else {
                
                ScrollView {
                    LazyVStack {
                        
                        ForEach(viewModel.news) { news in
                            NewsRow(newsItem: news)
                            
                        }
                        
                    }
                }
                
            }
        }.onAppear(perform: {
            viewModel.fetchNews(for: "election")
        })
    }
    
}
#Preview {
    NewsScreen()
}
