import SwiftUI
import Combine
import _SpriteKit_SwiftUI

struct GameView: View {
    
    @State var offset: CGFloat = 0
    
    @Binding var win: Bool
    @Binding var miniGameActive: Bool
    
    @ObservedObject var viewModel: GameViewModel
    
    @StateObject var sc = SpaceController()
    
    var gameScene: GameScene {
        let scene = GameScene(size: CGSize(width: sc.width, height: sc.width))
        scene.scaleMode = .aspectFit
        viewModel.winAnyCancellable = scene.$win.sink { value in
            if value {
                win = true
            }
        }
        return scene
    }
    
    var body: some View {
        ZStack {
            HStack(spacing: 7) {
                Image(ImageTitles.AlarmIcon.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                TextCustom(text: viewModel.reloadTime(), size: 16, weight: .medium, color: .white)
            }
            .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
            .background(Color.bgTab)
            .clipShape(.rect(cornerRadius: 23))
            .padding(.top, 45)
            .frame(maxHeight: .infinity, alignment: .top)
            SpriteView(scene: gameScene)
                .frame(width: sc.width - 14, height: sc.width - 14)
                .padding(.trailing, 14)
                .overlay(
                    Rectangle()
                        .fill(.white)
                        .frame(width: 14, height: (sc.width - 14) / 6)
                        .overlay(
                            Image(systemName: "chevron.compact.right")
                                .resizable()
                                .scaledToFit()
                                .padding(4)
                        )
                        .padding(.top, (sc.width - 14) / 6 * 2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                )
            .frame(maxWidth: .infinity)
            .background(
                GeometryReader { geo in
                    Color.clear.onAppear(perform: {
                        DispatchQueue.main.async {
                            sc.height = geo.size.height
                            sc.width = geo.size.width
                        }
                    })
                }
            )
        }
        .onReceive(viewModel.getTimer()) { input in
            viewModel.decrementTimer()
        }
    }
}

struct GameView_Preview: PreviewProvider {
    
    @State static var win = false
    @State static var miniGameActive = true
    
    static var previews: some View {
        GameView(win: $win, miniGameActive: $miniGameActive, viewModel: GameViewModel(dataManager: DataManager()))
            //.padding()
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
    }
}

final class GameViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    var timerValue: Int
    
    private var timerCancellable: AnyCancellable?
    var winAnyCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        timerValue = dataManager.miniGameTimer
        timerCancellable = dataManager.$miniGameTimer.sink { [weak self] value in
            self?.timerValue = value
        }
    }
    
    func decrementTimer() {
        if dataManager.miniGameTimer > 0 {
            if dataManager.miniGameTimer - 1 <= 0 {
                dataManager.miniGameReloadTimer = 300
            }
            dataManager.miniGameTimer -= 1
        }
    }
    
    func getTimer() ->  Publishers.Autoconnect<Timer.TimerPublisher> {
        return dataManager.timer
    }
    
    func reloadTime() -> String {
        let minutes = timerValue / 60
        let seconds = timerValue - (timerValue / 60 * 60)
        var secondsStr = ""
        if seconds >= 10 {
            secondsStr = "\(seconds)"
        } else {
            secondsStr = "0\(seconds)"
        }
        return "\(minutes):" + secondsStr
    }
}
