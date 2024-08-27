//
//  CharacterDetailScreen.swift
//  RickMorty
//
//  Created by Zulqarnain Naveed Macbook on 25/08/2024.
//

import SwiftUI

struct CharacterDetailScreen: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
   
    var body: some View {
        GeometryReader { geometry in
            
           
                
                VStack{
                    CustomNavBarView(text: "Gar Gloonch", backAction: {
                        
                    })
                    CharacterInfoCardView(display: true,displayImage: "img_sampleDetail", infoType: .full, showDetail: {})
                    Spacer()
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .background(Color.primaryBGColor)
        }
    }
}
    struct CustomNavBarView: View {
        var text: String
        var backAction: (()->Void)
        
        var body: some View{
            HStack {
                Button(action: {
                    backAction()
                }, label: {
                    Image.ic_back
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 48, height: 48)
                })
                .frame(width: 48, height: 48)
                Spacer()
                Text(text)
                    .foregroundStyle(.white)
                    .font(.montserratSemiBold(size: 25))
                
                Spacer()
                
                
                
            }
            .offset(x: -14)
            .padding(.horizontal, 16)
            
        }
    }

