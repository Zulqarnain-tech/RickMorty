//
//  SliderView.swift
//  RickMorty
//
//  Created by Zulqarnain Naveed Macbook on 25/08/2024.
//

import SwiftUI

struct SliderView: View {
    
    @State private var currentPage = 0
    let images: [String]
    
    var body: some View {
       
        VStack {
            Image(images[currentPage])
                .resizable()
                .scaledToFill()
        }
        .frame(height: 100)
        .overlay{
            HStack{
                Button(action: {
                    if currentPage > 0{
                        currentPage -= 1
                    }
                }, label: {
                    Image.ic_chevLeft
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                })
                Spacer()
                Button(action: {
                    if currentPage < images.count - 1{
                        currentPage += 1
                    }
                }, label: {
                    Image.ic_chevRight
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                })
            }
            .padding(.horizontal, 30)
        }
    }
}

