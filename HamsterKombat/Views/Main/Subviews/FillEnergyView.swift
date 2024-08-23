import SwiftUI
import Combine

struct FillEnergyView: View {
    
    @Binding var showFillEnergyView: Bool
    
    @ObservedObject var viewModel: FillEnergyViewModel
    
    @StateObject var sheetSizeManager: SheetSizeManager
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    sheetSizeManager.dismissSheet()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showFillEnergyView = false
                    }
                }
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        Image(ImageTitles.EnergyEllipse.rawValue)
                            .resizable()
                            .scaledToFit()
                        Image(ImageTitles.EnergyLightning.rawValue)
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(height: 150)
                    .padding(.top, 75)
                    TextCustom(text: "Fill energy", size: 36, weight: .bold, color: .white)
                        .padding(.top, 39)
                    TextCustom(text: "Restore your energy to the limit and make another round of mining", size: 16, weight: .medium, color: .white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                    HStack(spacing: 7) {
                        Image(ImageTitles.CoinDollarIcon.rawValue)
                        TextCustom(text: "Free", size: 36, weight: .bold, color: .white)
                    }
                    .frame(height: 44)
                    .padding(.top, 20)
                    
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        viewModel.restoreEnergy()
                    } label: {
                        if viewModel.timerValue <= 0 {
                            HStack(spacing: 3) {
                                TextCustom(text: "Receive", size: 24, weight: .bold, color: .white)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.blueButton)
                            .clipShape(.rect(cornerRadius: 6))
                            .frame(maxHeight: 72)
                        } else {
                            HStack(spacing: 14) {
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
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .frame(height: 72)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.white.opacity(0.2), lineWidth: 1)
                            )
                        }
                    }
                    .disabled(viewModel.timerValue > 0)
                    .padding(.top, 39)
                    
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        viewModel.tapValueLevelUp()
                    } label: {
                        HStack(spacing: 8) {
                            TextCustom(text: "Multitap", size: 24, weight: .bold, color: .white)
                            Image(viewModel.balance >= viewModel.tapValueLevelPrice ? ImageTitles.CoinDollarIcon.rawValue : ImageTitles.SilverCoin.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            TextCustom(text: "\(viewModel.tapValueLevelPrice)", size: 24, weight: .bold, color: .white.opacity(viewModel.balance >= viewModel.tapValueLevelPrice ? 1 : 0.4))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(viewModel.balance >= viewModel.tapValueLevelPrice ? Color.blueButton : Color.buySkinButton)
                        .clipShape(.rect(cornerRadius: 6))
                        .frame(maxHeight: 72)
                    }
                    .disabled(viewModel.balance >= viewModel.tapValueLevelPrice ? false : true)
                    .padding(.top, 12)
                    
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        viewModel.maxEnergyLevelUp()
                    } label: {
                        HStack(spacing: 8) {
                            TextCustom(text: "Max energy", size: 24, weight: .bold, color: .white)
                            Image(viewModel.balance >= viewModel.maxEnergyLevelPrice ? ImageTitles.CoinDollarIcon.rawValue : ImageTitles.SilverCoin.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            TextCustom(text: "\(viewModel.maxEnergyLevelPrice)", size: 24, weight: .bold, color: .white.opacity(viewModel.balance >= viewModel.maxEnergyLevelPrice ? 1 : 0.4))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(viewModel.balance >= viewModel.maxEnergyLevelPrice ? Color.blueButton : Color.buySkinButton)
                        .clipShape(.rect(cornerRadius: 6))
                        .frame(maxHeight: 72)
                    } 
                    .disabled(viewModel.balance >= viewModel.maxEnergyLevelPrice ? false : true)
                    .padding(.top, 12)
                }
                .padding(.horizontal, 14)
                .frame(maxHeight: .infinity, alignment: .top)
                CloseButton(action: {
                    sheetSizeManager.dismissSheet()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showFillEnergyView = false
                    }
                })
                .padding(24)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
            .background(
                Image(ImageTitles.SheetRectangle.rawValue)
                    .resizable()
            )
            .ignoresSafeArea(.container, edges: .bottom)
            .offset(x: 0, y: sheetSizeManager.topPadding)
            .onAppear {
                sheetSizeManager.appearance()
            }
        }
    }
}

struct FillEnergy_Preview: PreviewProvider {
    
    @State static var showFillEnergyView = false
    
    static var previews: some View {
        FillEnergyView(showFillEnergyView: $showFillEnergyView, viewModel: FillEnergyViewModel(dataManager: DataManager()), sheetSizeManager: SheetSizeManager(screenHeight: UIScreen.screenHeight))
    }
}

final class FillEnergyViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    @Published var timerValue: Int
    
    @Published var balance: Int
    
    @Published var tapValueLevelPrice: Int
    
    @Published var maxEnergyLevelPrice: Int
    
    private var balanceCancellable: AnyCancellable?
    
    private var timerCancellable: AnyCancellable?
    private var tapValueLevelPriceCancellable: AnyCancellable?
    private var maxEnergyLevelPriceCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        timerValue = dataManager.energyTimer
        tapValueLevelPrice = dataManager.tapValueLevelPrice
        maxEnergyLevelPrice = dataManager.maxEnergyLevelPrice
        balance = dataManager.balance
        timerCancellable = dataManager.$energyTimer.sink { [weak self] value in
            self?.timerValue = value
        }
        balanceCancellable = dataManager.$balance.sink { [weak self] value in
            self?.balance = value
        }
        tapValueLevelPriceCancellable = dataManager.$tapValueLevelPrice.sink { [weak self] value in
            self?.tapValueLevelPrice = value
        }
        maxEnergyLevelPriceCancellable = dataManager.$maxEnergyLevelPrice.sink { [weak self] value in
            self?.maxEnergyLevelPrice = value
        }
    }
    
    func maxEnergyLevelUp() {
        dataManager.maxEnergyLevelUp()
    }
    
    func tapValueLevelUp() {
        dataManager.tapValueLevelUp()
    }
    
    func restoreEnergy() {
        dataManager.energy = dataManager.maxEnergy
        dataManager.energyTimer = 3600
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
