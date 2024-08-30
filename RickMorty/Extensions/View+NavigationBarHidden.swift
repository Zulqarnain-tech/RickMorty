import SwiftUI

extension View {
    func navigationBarEntirelyHidden() -> some View {
      navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
