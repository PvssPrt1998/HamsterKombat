import SwiftUI
import _SpriteKit_SwiftUI

struct GameView: View {
    
    @State var offset: CGFloat = 0
    
    @Binding var win: Bool
    @Binding var miniGameActive: Bool
    
    @StateObject var sc = SpaceController()
    
    var gameScene: GameScene {
        let scene = GameScene(size: CGSize(width: sc.width, height: sc.width))
        scene.scaleMode = .aspectFit
        sc.winAnyCancellable = scene.$win.sink { value in
            if value {
                win = true
            }
        }
        return scene
    }

    
    var body: some View {
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
}

struct GameView_Preview: PreviewProvider {
    
    @State static var win = false
    @State static var miniGameActive = true
    
    static var previews: some View {
        GameView(win: $win, miniGameActive: $miniGameActive)
            //.padding()
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
    }
}
