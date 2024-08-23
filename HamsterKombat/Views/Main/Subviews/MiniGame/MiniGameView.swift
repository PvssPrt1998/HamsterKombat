import SwiftUI
import Combine

struct MiniGameView: View {
    
    @State var launchView = true
    @Binding var showMiniGame: Bool
    @StateObject var viewModel: MiniGameViewModel
    @StateObject var sheetSizeManager: SheetSizeManager
    
    @EnvironmentObject var viewModelFactory: ViewModelFactory
    
    var body: some View {
        ZStack {
            if !launchView && viewModel.miniGameTimer > 0 {
                GameView(win: $viewModel.win, miniGameActive: $showMiniGame, viewModel: viewModelFactory.makeGameViewModel())
                    .padding(.leading, 14)
                    .frame(maxWidth: .infinity)
            } else if !launchView && viewModel.miniGameTimer <= 0 {
                TimesUpView(viewModel: viewModelFactory.makeTimesUpViewModel()) {
                    viewModel.setMiniGameTimer60()
                }
            } else {
                MiniGameLaunchView(action: {
                    viewModel.setMiniGameTimer60()
                    launchView = false})
            }
            
            CloseButton(action: {
                if !launchView && viewModel.miniGameTimer > 0 {
                    viewModel.setReloadTimer()
                }
                    sheetSizeManager.dismissSheet()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showMiniGame = false
                    }
                })
                .padding(24)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .frame(maxWidth: .infinity)
        .background(
            Image(ImageTitles.SheetRectangle.rawValue)
                .resizable()
        )
        .ignoresSafeArea(.container, edges: .bottom)
        .offset(x: 0, y: sheetSizeManager.topPadding)
        .onAppear {
            sheetSizeManager.appearance()
        }
        .onReceive(viewModel.$win) { value in
            if value {
                viewModel.getMoney()
                if !launchView && viewModel.miniGameTimer > 0 {
                    viewModel.setWinReloadTimer()
                }
                sheetSizeManager.dismissSheet()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    showMiniGame = false
                }
            }
        }
    }
}

struct MiniGameView_Preview: PreviewProvider {

    @State static var showMiniGame = true
    
    static var previews: some View {
        MiniGameView(showMiniGame: $showMiniGame, viewModel: MiniGameViewModel(dataManager: DataManager()), sheetSizeManager: SheetSizeManager(screenHeight: UIScreen.screenHeight))
            .environmentObject(ViewModelFactory())
    }
    
}

final class MiniGameViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    @Published var win: Bool = false
    
    @Published var miniGameTimer: Int
    
    private var miniGameTimerCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        miniGameTimer = dataManager.miniGameTimer
        miniGameTimerCancellable = dataManager.$miniGameTimer.sink { [weak self] value in
            self?.miniGameTimer = value
        }
    }
    
    func setReloadTimer() {
        dataManager.miniGameReloadTimer = 300
    }
    
    func setWinReloadTimer() {
        dataManager.miniGameReloadTimer = dataManager.secondsForNextDay()
    }
    
    func setMiniGameTimer60() {
        dataManager.miniGameTimer = 60
    }
    
    func getMoney() {
        dataManager.balance += 5000
    }
}

