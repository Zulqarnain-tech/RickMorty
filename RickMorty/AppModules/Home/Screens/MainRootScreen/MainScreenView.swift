//
//  MainScreenView.swift
//  RickMorty
//
//  Created by Zulqarnain Naveed Macbook on 25/08/2024.
//

import SwiftUI
import DesignSystem

struct MainScreenView: View {
    @ObservedObject var viewModel: MainCharacterListViewModel
    var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .top) {
               
                VStack() {
                    
                  
                    SearchBarView(searchText: $viewModel.searchText, isEditing: $viewModel.isEdit)
                    
                    SliderView(images: viewModel.state.sliderImages)
                    
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.primaryBGColor)
                //.toastView(viewModel: viewModel.toastModel)
                //.eyeCareActivity(isLoading: $viewModel.showLoading)
            
            
        }
    }
}

