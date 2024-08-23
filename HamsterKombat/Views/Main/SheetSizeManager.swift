import SwiftUI

class SheetSizeManager: ObservableObject {
    
    @Published var defaultPadding: CGFloat {
        didSet {
            appearance()
        }
    }
    @Published var topPadding: CGFloat
    
    let screenHeight: CGFloat
    var sheetHeight: CGFloat
    
    let dragGesture: DragGesture
    
    init(screenHeight: CGFloat) {
        self.dragGesture = DragGesture()
        self.defaultPadding = 0
        self.screenHeight = screenHeight
        self.topPadding = screenHeight
        self.sheetHeight = screenHeight
        self.sheetHeight = screenHeight - self.defaultPadding
    }
    
    func appearance() {
        withAnimation(.linear(duration: 0.1)) {
            topPadding = defaultPadding
        }
    }
    
    func dismissSheet() {
        withAnimation(.linear(duration: 0.1)) {
            topPadding = screenHeight
        }
    }
}

extension UIScreen {
    static let screenHeight = UIScreen.main.bounds.height
}
