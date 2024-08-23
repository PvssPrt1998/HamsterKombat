import SwiftUI

struct BurseView: View {
    
    @ObservedObject var viewModel: BurseViewModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Binding var screenType: MainViewModel.ScreenType
    @Binding var showMiniGame: Bool
    @Binding var showDailyReward: Bool
    @Binding var showBoostView: Bool
    
    var burseView: some View {
            VStack(spacing: 16) {
                //MARK: - three buttons on top of sheet
                HStack(spacing: 12) {
                    Button {
                        showDailyReward = true
                    } label: {
                        Image(ImageTitles.ButtonRectangleWithInnerShadow.rawValue)
                            .resizable()
                            .scaledToFit()
                            .overlay(
                                VStack {
                                    Image(ImageTitles.Calendar.rawValue)
                                    TextCustom(text: "Daily Reward", size: 10, weight: .bold, color: .white)
                                }
                            )
                    }
                    
                    Button {
                        screenType = .mining
                    } label: {
                        Image(ImageTitles.ButtonRectangleWithInnerShadow.rawValue)
                            .resizable()
                            .scaledToFit()
                            .overlay(
                                VStack {
                                    Image(ImageTitles.MagnifyingGlass.rawValue)
                                    TextCustom(text: "Combo", size: 10, weight: .bold, color: .white)
                                }
                            )
                    }
                        
                    Button {
                        if viewModel.miniGameAvailable {
                            showMiniGame = true
                        }
                    } label: {
                        Image(ImageTitles.ButtonRectangleWithInnerShadow.rawValue)
                            .resizable()
                            .scaledToFit()
                            .overlay(
                                VStack {
                                    if viewModel.miniGameAvailable {
                                        Image(ImageTitles.Gamepad.rawValue)
                                    } else {
                                        TextCustom(text: viewModel.hiddenReloadStr(), size: 16, weight: .medium, color: .white)
                                            .hidden()
                                            .overlay(
                                                TextCustom(text: viewModel.reloadTime(), size: 16, weight: .medium, color: .white)
                                                , alignment: .leading
                                            )
                                    }
                                    TextCustom(text: "Mini-game", size: 10, weight: .bold, color: .white)
                                }
                            )
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
                    TextCustom(text: viewModel.hiddenString(), size: 36, weight: .bold, color: .white)
                        .hidden()
                        .overlay(
                            TextCustom(text: viewModel.balanceString(), size: 36, weight: .bold, color: .white)
                            ,alignment: .leading
                        )
                }
                
                //MARK: - Hamster
                    HamsterButton(imageTitle: viewModel.selectedImageTitle(), disabled: viewModel.isTapDisabled()) {
                            viewModel.tap()
                        }
                        .simultaneousGesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onEnded {
                                viewModel.tapValue(x: $0.location.x, y: $0.location.y)
                        })
                        .overlay(
                            tapText()
                        )
                    //
                }
                HStack(spacing: 9) {
                    Image(ImageTitles.LightningIcon.rawValue)
                    HStack(spacing: 0) {
                        TextCustom(text: viewModel.hiddenEnergyString(), size: 16, weight: .semibold, color: .white)
                            .hidden()
                            .overlay(
                                TextCustom(text: "\(viewModel.energy)", size: 16, weight: .semibold, color: .white)
                            )
                        TextCustom(text: "/ \(viewModel.maxEnergy)", size: 16, weight: .semibold, color: .white)
                    }
                    Spacer()
                    HStack(spacing: 9) {
                        Image(ImageTitles.RocketIcon.rawValue)
                        TextCustom(text: "Boost", size: 16, weight: .semibold, color: .white)
                    }
                    .onTapGesture {
                        showBoostView = true
                    }
                }
                .padding(EdgeInsets(top: -12, leading: 15, bottom: 0, trailing: 15))
            }
            .frame(maxHeight: .infinity, alignment: .top)
    }
    
    var body: some View {
        burseView
    }
    
    func tapText() -> some View {
        ZStack {
            ForEach(0..<viewModel.taps.count, id: \.self) { index in
                TapTextView(tapValue: viewModel.tapValue, tap: viewModel.taps[index])
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct BurseView_Preview: PreviewProvider {
    
    @State static var showMiniGame = false
    @State static var showDailyReward = false
    @State static var showBoostView = false
    @State static var screenType: MainViewModel.ScreenType = .burse
    
    static var previews: some View {
        BurseView(viewModel: ViewModelFactory().makeBurseViewModel(), screenType: $screenType, showMiniGame: $showMiniGame, showDailyReward: $showDailyReward, showBoostView: $showBoostView)
            .background(Color.black)
    }
}
