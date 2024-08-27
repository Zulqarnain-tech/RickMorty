import SwiftUI

public extension Font {
   
   static func montserratMedium(size: CGFloat) -> Font {
       return Font.custom("Montserrat-Medium", size: size)
   }
                        
   static func montserratSemiBold(size: CGFloat) -> Font {
       return Font.custom("Montserrat-SemiBold", size: size)
   }
    static func montserratBold(size: CGFloat) -> Font {
        return Font.custom("Montserrat-Bold", size: size)
    }
    static func montserratBlack(size: CGFloat) -> Font {
        return Font.custom("Montserrat-Black", size: size)
    }
}
