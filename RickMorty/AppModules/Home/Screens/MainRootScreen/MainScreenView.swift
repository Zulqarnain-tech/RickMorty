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
    @State private var animation: Animation = .default
    @State private var cornerRadius: CGFloat = 14
    var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .top) {
               
                ScrollView{
                    SearchBarView(searchText: $viewModel.searchText, isEditing: $viewModel.isEdit)
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
                        // start card
                        DropDownView(heading: "Last known location", display: $viewModel.knownLocation, list: [
                           "Nuptia 1",
                           "Nuptia 2",
                           "Nuptia 3",
                           "Nuptia 4",
                        ])
                        .padding(.top)
                        
                        DropDownView(heading: "First seen in", display: $viewModel.firstSeenIn, list: [
                           "All",
                           "Get Schwifty",
                           "Interdimensional Cable 2: Tempting Fate",
                           "One Crew Over the Crewcoo's Morty"
                        ])
                        .padding(.top)
                        //  end  card
                        
                        VStack(spacing: 24){
                            ForEach(0..<3, id: \.self) { index in
                                CharacterInfoCardView(display: viewModel.tappedCharacter == index, showDetail: {
                                    withAnimation {
                                        if viewModel.tappedCharacter != index{
                                            viewModel.tappedCharacter = index
                                        }else{
                                            viewModel.tappedCharacter = -1
                                        }
                                    }
                                    
                                })
                                    
                            }
                            
                        }
                        .padding(.vertical)
                        
                        
                    }
                    .padding(.horizontal)
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.primaryBGColor)
        }
    }
}
struct CharacterInfoCardView: View {
    var display: Bool
    var displayImage: String = "img_sample"
    var infoType: CharacterInfoEnum = .partial
    var showDetail: ()->()
    var body: some View{
            VStack(alignment: .leading){
                Image(displayImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Text("Gar Gloonch")
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
                    Text("Human")
                        .font(.montserratMedium(size: 12))
                        .foregroundStyle(.white)
                    HStack{
                        Circle()
                            .fill(Color.pearColor)
                            .frame(width: 5)
                           
                        Text("Alive")
                            .font(.montserratMedium(size: 12))
                            .foregroundStyle(.white)
                    }
                    SelectedTextView(title: "Last known location", text: "Nuptia 4", titleColor: .gray, textColor: .white)
                    SelectedTextView(title: "First seen in", text: "Mortynight Run", titleColor: .gray, textColor: .white)
                    if infoType == .partial{
                        if display{
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum dictum aliquam libero, vitae eleifend odio auctor quis. Quisque consequat convallis felis. Vivamus sodales luctus porttitor. Nulla lacinia dapibus lectus sed commodo.")
                                .truncationMode(.tail)
                                .font(.montserratMedium(size: 12))
                                .foregroundStyle(.white)
                            
                            Button(action: {
                                
                            }, label: {
                                Text("Read More")
                                    .font(.montserratMedium(size: 12))
                                    .foregroundStyle(Color.pearColor)
                                    .underline(true, color: .pearColor)
                            })
                        }
                    }else{
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum dictum aliquam libero, vitae eleifend odio auctor quis. Quisque consequat convallis felis. Vivamus sodales luctus porttitor. Nulla lacinia dapibus lectus sed commodo.")
                            .truncationMode(.tail)
                            .font(.montserratMedium(size: 12))
                            .foregroundStyle(.white)
                    }
                    
                }
                .padding(14)
            }
            .background(infoType == .partial ? Color.tunaColor : .clear)
            .cornerRadius(infoType == .partial ? 14 : 0)
    }
}
struct DropDownView: View {
    let heading: String
    @Binding var display: Bool
    let list: [String]
    @State private var selectedText: String = ""
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
                    VStack(alignment: .leading,spacing: 8) {
                        ForEach(0..<list.count, id: \.self) { index in
                            Text(list[index])
                                .font(.montserratMedium(size: 12))
                                .foregroundColor(.white)
                                .onTapGesture {
                                    selectedText = list[index]
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
}

enum CharacterInfoEnum: CaseIterable {
    case partial, full
}

