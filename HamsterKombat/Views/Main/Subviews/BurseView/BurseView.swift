import SwiftUI

struct BurseView: View {
    
    @ObservedObject var viewModel: BurseViewModel
    
    @Binding var showMiniGame: Bool
    
    var burseView: some View {
        VStack(spacing: 16) {
            //MARK: - three buttons on top of sheet
            HStack(spacing: 12) {
                Image(ImageTitles.ButtonRectangleWithInnerShadow.rawValue)
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        VStack {
                            Image(ImageTitles.Calendar.rawValue)
                            TextCustom(text: "Daily Reward", size: 10, weight: .bold, color: .white)
                        }
                    )
                Image(ImageTitles.ButtonRectangleWithInnerShadow.rawValue)
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        VStack {
                            Image(ImageTitles.MagnifyingGlass.rawValue)
                            TextCustom(text: "Combo", size: 10, weight: .bold, color: .white)
                        }
                    )
                Image(ImageTitles.ButtonRectangleWithInnerShadow.rawValue)
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        VStack {
                            Image(ImageTitles.Gamepad.rawValue)
                            TextCustom(text: "Mini-game", size: 10, weight: .bold, color: .white)
                        }
                    )
                    .onTapGesture {
                        showMiniGame = true
                    }
            }
            .padding(.top, 38)
            
            
            VStack(spacing: 8) {
            //MARK: - Coin balance
            HStack(spacing: 7) {
                Image(ImageTitles.CoinDollarIcon.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 44)
                TextCustom(text: "1500", size: 36, weight: .bold, color: .white)
            }
            
            //MARK: - Hamster
                Circle()
                    .fill(LinearGradient(colors: [.orangeBottomGradient, .orangeTopGradient], startPoint: .bottom, endPoint: .top))
                    .overlay(
                        Image(viewModel.selectedImageTitle())
                            .resizable()
                            .scaledToFit()
                            .padding(33)
                    )
                    .padding(17)
                    .background(
                        Circle()
                            .fill(LinearGradient(colors: [.orangeTopGradient, .orangeBottomGradient], startPoint: .bottom, endPoint: .top))
                    )
                    .shadow(color: .hamsterTapAreaShadow, radius: 25)
                    .padding(.horizontal, 15)
            }
            HStack(spacing: 9) {
                Image(ImageTitles.LightningIcon.rawValue)
                TextCustom(text: "1500/1500", size: 16, weight: .semibold, color: .white)
                Spacer()
                Image(ImageTitles.RocketIcon.rawValue)
                TextCustom(text: "Boost", size: 16, weight: .semibold, color: .white)
            }
            .padding(EdgeInsets(top: -12, leading: 15, bottom: 0, trailing: 15))
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    var body: some View {
        burseView
//        ZStack {
//            if showMiniGame {
//                MiniGameView(showMiniGame: $showMiniGame)
//            } else {
//                burseView
//            }
//        }
    }
}

struct BurseView_Preview: PreviewProvider {
    
    @State static var showMiniGame = false
    
    static var previews: some View {
        BurseView(viewModel: ViewModelFactory().makeBurseViewModel(), showMiniGame: $showMiniGame)
            .background(Color.black)
    }
}
