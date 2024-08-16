import SwiftUI

struct MiniGameView: View {
    
    @State var launchView = true
    @Binding var showMiniGame: Bool
    @StateObject var viewModel = MiniGameViewModel()
    
    var body: some View {
        ZStack {
            if !launchView {
                GameView(win: $viewModel.win, miniGameActive: $showMiniGame)
                    .frame(maxWidth: .infinity)
            } else {
                MiniGameLaunchView(action: {launchView = false})
            }
            
            CloseButton(action: {})
                .padding(24)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .frame(maxWidth: .infinity)
        .background(
            Image(ImageTitles.SheetRectangle.rawValue)
                .resizable()
        )
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

struct MiniGameView_Preview: PreviewProvider {
    
    @State static var showMiniGame = true
    
    static var previews: some View {
        MiniGameView(showMiniGame: $showMiniGame)
    }
    
}

final class MiniGameViewModel: ObservableObject {
    @Published var win: Bool = false {
        didSet {
            if win {
                print("WIN")
            }
        }
    }
}
