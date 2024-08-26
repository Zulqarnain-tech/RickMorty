import SwiftUI

public struct LoadingView: View {
    public init() {}
    
    public var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ProgressView()
                    .tint(.black)
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
