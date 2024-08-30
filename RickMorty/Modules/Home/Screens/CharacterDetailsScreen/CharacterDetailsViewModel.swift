import Foundation
import Domain

final class CharacterDetailsViewModel {
    let character: Result
    var onMoveBack: ()->()
    init(character: Result, onMoveBack: @escaping () -> Void) {
        self.character = character
        self.onMoveBack = onMoveBack
    }
}
