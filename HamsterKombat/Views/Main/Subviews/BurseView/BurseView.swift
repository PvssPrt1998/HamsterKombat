import SwiftUI

struct BurseView: View {
    
    @ObservedObject var viewModel: BurseViewModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Binding var screenType: MainViewModel.ScreenType
    @Binding var showMiniGame: Bool
    @Binding var showDailyReward: Bool
    @Binding var showBoostView: Bool
    
    @State var leadingOffset1: CGFloat = 70
    @State var leadingOffset2: CGFloat = 70
    @State var leadingOffset3: CGFloat = 70
    @State var coinPadding: CGFloat = 70
    
    var burseView: some View {
            VStack(spacing: 16) {
                //MARK: - three buttons on top of sheet
                HStack(spacing: 12) {
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        showDailyReward = true
                    } label: {
                        Image(ImageTitles.ButtonRectangleWithInnerShadow.rawValue)
                            .resizable()
                            .scaledToFit()
                            .overlay(
                                VStack {
                                    Image(ImageTitles.Calendar.rawValue)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 40)
                                    TextCustom(text: "Daily Reward", size: 10, weight: .bold, color: .white)
                                }
                            )
                    }
                    .offset(x: leadingOffset1)
                    
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        screenType = .mining
                    } label: {
                        Image(ImageTitles.ButtonRectangleWithInnerShadow.rawValue)
                            .resizable()
                            .scaledToFit()
                            .overlay(
                                VStack {
                                    Image(ImageTitles.MagnifyingGlass.rawValue)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 40)
                                    TextCustom(text: "Combo", size: 10, weight: .bold, color: .white)
                                }
                            )
                    }
                    .offset(x: leadingOffset2)
                        
                    Button {
                        if viewModel.miniGameAvailable {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
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
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 40)
                                    } else {
                                        TextCustom(text: viewModel.hiddenReloadStr(), size: 16, weight: .medium, color: .white)
                                            .hidden()
                                            .overlay(
                                                TextCustom(text: viewModel.reloadTime(), size: 16, weight: .medium, color: .white)
                                                , alignment: .leading
                                            )
                                            .frame(height: 40)
                                    }
                                    TextCustom(text: "Mini-game", size: 10, weight: .bold, color: .white)
                                }
                            )
                    }
                    .disabled(!viewModel.miniGameAvailable)
                    .offset(x: leadingOffset3)
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
                    HamsterButton(initialImageTitle: viewModel.selectedImageTitle, imageTitle: $viewModel.selectedImageTitle, disabled: viewModel.isTapDisabled()) {
                            viewModel.tap()
                        }
                        .simultaneousGesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onEnded {
                                viewModel.tapValue(x: $0.location.x, y: $0.location.y)
                        })
                        .overlay(
                            tapText()
                        )
                        .padding(coinPadding)
                    //
                }
                HStack(spacing: 9) {
                    Image(ImageTitles.LightningIcon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 33, height: 33)
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
                            .resizable()
                            .scaledToFit()
                            .frame(width: 33, height: 33)
                        TextCustom(text: "Boost", size: 16, weight: .semibold, color: .white)
                    }
                    .onTapGesture {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        showBoostView = true
                    }
                }
                .padding(EdgeInsets(top: -12, leading: 15, bottom: 0, trailing: 15))
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .onAppear {
                withAnimation(.spring(duration: 0.1, bounce: 0.7)) {
                    leadingOffset1 = 0
                    leadingOffset2 = 0
                    leadingOffset3 = 0
                }
                withAnimation(.linear(duration: 0.1)) {
                    coinPadding = 0
                }
            }
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
