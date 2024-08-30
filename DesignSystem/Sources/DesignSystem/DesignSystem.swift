import Foundation
import SwiftUI

public struct DesignSystem {
    public enum PoppinsFont: CaseIterable {
        case extraLight
        case light
        case medium
        case regular
        case semiBold
        
        public var fullName: String {
            switch self {
            case .extraLight:
                return "Poppins-ExtraLight"
            case .light:
                return "Poppins-Light"
            case .medium:
                return "Poppins-Medium"
            case .regular:
                return "Poppins-Regular"
            case .semiBold:
                return "Poppins-SemiBold"
            }
        }
    }
    
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
            let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
            let font = CGFont(fontDataProvider) else {
                fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
        }
        
        var error: Unmanaged<CFError>?

        CTFontManagerRegisterGraphicsFont(font, &error)
    }
    
    public static func registerFonts() {
        PoppinsFont.allCases.forEach {
            registerFont(bundle: .module, fontName: $0.fullName, fontExtension: "ttf")
        }
    }
}
