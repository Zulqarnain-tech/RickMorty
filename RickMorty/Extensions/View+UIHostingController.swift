import SwiftUI

extension View {
    var hosted: UIViewController {
        return UIHostingController(rootView: self)
    }
}
