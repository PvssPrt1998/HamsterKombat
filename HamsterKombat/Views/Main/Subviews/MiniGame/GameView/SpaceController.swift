
import Foundation
import Combine

final class SpaceController: ObservableObject {
    
    @Published var width: CGFloat = 300
    @Published var height: CGFloat = 300
    
    var winAnyCancellable: AnyCancellable?
}
