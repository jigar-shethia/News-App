//
//  NewsView.swift
//  News App
//
//  Created by Jigar Shethia on 29/03/24.
//

import SwiftUI

struct NewsRow: View {
    var newsItem:News
    @ObservedObject var viewModel: NewsViewModel
    @State var isChecked:Bool = false
    
    var body: some View {
        VStack{
            HStack(spacing: 10) {
                VStack (alignment: .leading, content: {
                    AsyncImage(url: newsItem.imageUrl, transaction: Transaction(animation: .spring(response: 0.5,dampingFraction: 0.6, blendDuration: 0.25))) {
                        
                        phase in
                        
                        switch(phase){
                        case.success(let image):
                            image.imagemodifier()
                                .transition(.scale)
                        case .empty:
                            Image(systemName: "photo.circle.fill").iconModifier()
                        case .failure(let error):
                            let _ = print(error)
                            
                            Image(systemName: "person.crop.circle.badge.exclamationmark").iconModifier()
                                .frame(width: 80, height: 80)
                                .cornerRadius(8)
                        @unknown default:
                            ProgressView()
                        }
                    }
                    Spacer()
                    CheckBoxView(isChecked: $isChecked)
                        .onChange(of: isChecked) { newValue in
                            if newValue{
                                viewModel.selectedArray.append(newsItem.id)
                            }
                            else {
                                viewModel.selectedArray = viewModel.selectedArray.filter({ $0 != newsItem.id })
                            }
                        }
                })
                VStack(alignment: .leading, spacing: 4) {
                    Text(newsItem.title)
                        .font(.headline)
                    
                    Text(newsItem.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(newsItem.date.toString())
                        .font(.caption)
                        .fontWeight(.thin)
                        .italic()
                        .foregroundColor(.secondary)
                        .padding(.top, 5)
                }
                
            }
            .padding( 8)
            
            Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .foregroundColor(Color.gray)
                .padding(.leading, 20)
                .padding(.trailing, 20)
        }
    }
}


