//
//  MainScreenView.swift
//  RickMorty
//
//  Created by Zulqarnain Naveed Macbook on 25/08/2024.
//

import SwiftUI
import DesignSystem
import Domain


struct MainScreenView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    @State private var animation: Animation = .default
    @State private var cornerRadius: CGFloat = 14
    var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .top) {
               
                ScrollView{
                    SearchBarView(searchText: $viewModel.searchText, isEditing: $viewModel.isEdit, goAction: {
                        if viewModel.searchText.count != 0{
                            Task{
                                await self.viewModel.fetchCharacterData(searchedQuery: true)
                            }
                        }
                    }, cancelAction: {
                        
                    })
                        .padding(.horizontal)
                    SliderView(images: viewModel.state.sliderImages)
                        .padding(.vertical)
                    VStack{
                        
                      
                       
                        
                        SegmentControlView(segments: CharacterStatusSegment.allCases,
                                           selected: $viewModel.selectedStatus,
                                           titleNormalColor: .white,
                                           titleSelectedColor: .tunaColor,
                                           bgColor: .pearColor,
                                           animation: animation) { segment in
                            Text(segment.title)
                                .font(.montserratMedium(size: 13))
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                        } background: {
                            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        }
                        .frame(height: 48)
                        .background(Color.tunaColor)
                        .overlay(RoundedRectangle(cornerRadius: 14, style: .continuous).stroke(Color.tunaColor, lineWidth: 1)).cornerRadius(14)
                        
                        SegmentControlView(segments: CharacterSpeciesSegment.allCases,
                                           selected: $viewModel.selectedSpecies,
                                           titleNormalColor: .white,
                                           titleSelectedColor: .tunaColor,
                                           bgColor: .pearColor,
                                           animation: animation) { segment in
                            Text(segment.title)
                                .font(.montserratMedium(size: 13))
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                        } background: {
                            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        }
                        .frame(height: 48)
                        
                        DropDownView(heading: "Last known location", display: $viewModel.knownLocation, list: viewModel.lastKnownLocation, selectedText: $viewModel.selectedKnown)
                        .padding(.top)
                        
                        DropDownView(heading: "First seen in", display: $viewModel.firstSeenIn, list: viewModel.firstSeenList, selectedText: $viewModel.selectedFirstSeen)
                        .padding(.top)
                        
                        
                        VStack(spacing: 24){
                            ForEach(0..<viewModel.charactersList.count, id: \.self) { index in
                                let characterInfo = viewModel.charactersList[index]
                                CharacterInfoCardView(characterInfo: characterInfo, display: viewModel.tappedCharacter == index, imageHeight: geometry.size.width, showDetail: {
                                    withAnimation {
                                        if viewModel.tappedCharacter != index{
                                            viewModel.tappedCharacter = index
                                        }else{
                                            viewModel.tappedCharacter = -1
                                        }
                                    }
                                    
                                }
                                )
                                .onTapGesture {
                                
                                    Task {
                                        await viewModel.dispatch(.characterTapped(characterInfo))
                                    }
                                
                                }
                                    
                            }
                            
                        }
                        .padding(.vertical)
                        
                        
                    }
                    .padding(.horizontal)
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.primaryBGColor)
                .toastView(toast: $viewModel.state.error)
                .task {
                    if !viewModel.movedFromDetailScreen{
                        await viewModel.dispatch(.onAppear)
                    }else{
                        viewModel.movedFromDetailScreen = true
                    }
                    
                }
        }
    }
}
struct CharacterInfoCardView: View {
    var characterInfo: Result
    var display: Bool
    var infoType: CharacterInfoEnum = .partial
    var imageHeight: CGFloat
    var showDetail: ()->()
    var body: some View{
            VStack(alignment: .leading){
                CustomImageView(mediaUrl: characterInfo.image, imageHeight: infoType == .partial ? imageHeight * 0.4 : imageHeight * 0.8)
                    .clipped()
                    .contentShape(Rectangle())

                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Text(characterInfo.name)
                            .font(.montserratSemiBold(size: 25))
                            .foregroundStyle(.white)
                        Spacer()
                        if infoType == .partial{
                            Button(action: {
                                showDetail()
                            }, label: {
                                display ? Image.ic_chevUp : Image.ic_chevDown
                            })
                        }
                        
                        
                    }
                    Text(characterInfo.species)
                        .font(.montserratMedium(size: 12))
                        .foregroundStyle(.white)
                    HStack{
                        Circle()
                            .fill(Color.pearColor)
                            .frame(width: 5)
                           
                        Text(characterInfo.status)
                            .font(.montserratMedium(size: 12))
                            .foregroundStyle(.white)
                    }
                    SelectedTextView(title: "Last known location", text: characterInfo.location.name, titleColor: .gray, textColor: .white)
                    SelectedTextView(title: "First seen in", text: characterInfo.episode[0], titleColor: .gray, textColor: .white)
                    if infoType == .partial{
                        if display{
                            Text(characterInfo.gender)
                                .truncationMode(.tail)
                                .font(.montserratMedium(size: 12))
                                .foregroundStyle(.white)
                            
                            Text("Read More")
                                .font(.montserratMedium(size: 12))
                                .foregroundStyle(Color.pearColor)
                                .underline(true, color: .pearColor)
                        }
                    }
                    
                }
                .padding(14)
            }
            .background(infoType == .partial ? Color.tunaColor : .clear)
            .cornerRadius(infoType == .partial ? 14 : 0)
    }
}
struct CustomImageView: View {
    var mediaUrl: String
    var imageHeight: CGFloat
    
    var body: some View {
        ZStack { // Wrap everything inside a ZStack
            VStack(alignment: .center) {
                if let url = URL(string: mediaUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: imageHeight)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .controlSize(.small)
                            .tint(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity) // Expand to fill the available space
                    }
                } else {
                    ProgressView()
                        .controlSize(.small)
                        .tint(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Expand to fill the available space
                }
            }
            .frame(height: imageHeight)
            //.clipped()
            
        }
        .frame(height: imageHeight)
    }
}


struct DropDownView: View {
    let heading: String
    @Binding var display: Bool
    var list: [String]
    @Binding var selectedText: String
    var body: some View{
        VStack(alignment: .leading, spacing: 10){
            HStack{
                SelectedTextView(title: heading, text: selectedText)
                Spacer()
                display ? Image.ic_chevUp : Image.ic_chevDown
            }
            
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.5)) {
                    display.toggle()
                }
            }
            
            if display {
                VStack(alignment: .leading,spacing: 10){
                    //
                    ScrollView(showsIndicators: true){
                        VStack(alignment: .leading,spacing: 8) {
                            ForEach(0..<list.count, id: \.self) { index in
                                Text(list[index])
                                    .font(.montserratMedium(size: 12))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            selectedText = list[index]
                                            display.toggle()
                                        }
                                        
                                    }
                            }
                        }
                        
                    }
                }
                .frame(height: 120)
                
            }
        }
        .padding(14)
        
        .background(Color.tunaColor)
        .cornerRadius(14)
    }
}

struct SelectedTextView: View {
    let title: String
    let text: String
    var titleColor: Color = .white
    var textColor: Color = .pearColor
    var body: some View{
        VStack(alignment: .leading, spacing: 6){
            Text(title)
                .font(.montserratMedium(size: 9))
                .foregroundColor(titleColor)
            Text(text)
                .font(.montserratMedium(size: 12))
                .foregroundColor(textColor)
        }
    }
}

enum CharacterStatusSegment: Identifiable, CaseIterable {
    case dead, alive
    
    var id: String {
        title
    }
    
    var title: String {
        switch self {
        case .alive:
            return "Alive"
        case .dead:
            return "Dead"
        }
    }
    var isEmpty: String {
        ""
    }
}

enum CharacterSpeciesSegment: Identifiable, CaseIterable {
    case alien, human, robot
    
    var id: String {
        title
    }
    
    var title: String {
        switch self {
        case .alien:
            return "Alien"
        case .human:
            return "Human"
        case .robot:
            return "Robot"
        }
    }
    var isEmpty: String {
        ""
    }
}

enum CharacterInfoEnum: CaseIterable {
    case partial, full
}

