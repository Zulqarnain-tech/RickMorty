//
//  SearchBarView.swift
//  RickMorty
//
//  Created by Zulqarnain Naveed Macbook on 25/08/2024.
//

import SwiftUI
import Combine


struct SearchBarView: View, KeyboardReadable{
    
    @Binding var searchText: String
    @Binding var isEditing: Bool
    var height: CGFloat = 36
    var placeHolder: String = "search by name"
    var goAction: (()->())?
    var cancelAction: (()->())?
    var body: some View {

        HStack {
            
            TextField("", text: $searchText, prompt: Text(placeHolder).foregroundStyle(.white))
                .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                                debugPrint("Is keyboard visible? ", newIsKeyboardVisible)
                    NotificationCenter.default.post(name: .toggleUIComponentVisibility, object: nil, userInfo: ["isVisible": !newIsKeyboardVisible])
                            }
                .keyboardType(.webSearch)
                .onSubmit {
                    goAction?()
                }
                
                .frame(height: 30)
                .padding(7)
                //.padding(.horizontal, 32)
                .background(Color.tunaColor)
                .cornerRadius(10)
                .keyboardType(.webSearch)
                .onTapGesture {
                    self.isEditing = true
                }
                .overlay(
                    HStack {
                        Spacer()
                        Image.ic_glass
                            .padding(.leading, 10)
                            if isEditing {
                                Button(action: {
                                    self.searchText = ""
                                    cancelAction?()
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 20)
                                }
                                
                            }
 
                    }
                        .padding(.trailing)
                )
            
            if isEditing {
                Button(action: {
                    
                    self.isEditing = false
                    self.searchText = ""
                    cancelAction?()
                    hideKeyboard()
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.easeInOut(duration: 0.3), value: 1.0)
            }
        }
    }
}


extension Notification.Name {
    static let toggleUIComponentVisibility = Notification.Name("toggleUIComponentVisibility")
    static let togglePushNotificationVisibility = Notification.Name("togglePushNotificationVisibility")
    static let togglePremiumUserVisibility = Notification.Name("togglePremiumUserVisibility")
}



class UIComponentVisibilityManager: ObservableObject {
    @Published var isVisible: Bool = true
    
    var notificationSubscription: AnyCancellable?
    
    init() {
        notificationSubscription = NotificationCenter.default.publisher(for: .toggleUIComponentVisibility)
            .sink { [weak self] _ in
                self?.isVisible.toggle()
            }
    }
}


/// Publisher to read keyboard changes.
protocol KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}

extension KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
}
