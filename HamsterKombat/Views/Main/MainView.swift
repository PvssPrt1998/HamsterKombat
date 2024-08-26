
import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory
    
    @StateObject var sc: SpaceController = SpaceController()
    
    @State var showSkinsView: Bool = false
    @State var showMiniGame: Bool = false
    @State var showProfessionDetail: Bool = false
    @State var showDailyReward: Bool = false
    @State var showEveryHourView: Bool = false
    @State var showLeagueView: Bool = false
    @State var showComboHintView: Bool = false
    @State var showBoostView: Bool = false
    
    @State var professionId: Int = 0
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 12) {
                if viewModel.screenType == .burse {
                    HStack(spacing: 5) {
                        DailyRewardButton {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            showEveryHourView = true
                        }
                        TotalProfitPerHourView(viewModel: viewModelFactory.makeTotalProfitPerHourViewModel())
                    }
                    .padding(.horizontal, 15)
                    HStack {
                        BuyASkinButton {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            showSkinsView = true
                        }
                        Spacer()
                        LeagueView(viewModel: viewModelFactory.makeLeagueViewModel()) {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            showLeagueView = true
                        }
                    }
                    .padding(.horizontal, 15)
                } else {
                    HStack(spacing: 5) {
                        LeagueView(viewModel: viewModelFactory.makeLeagueViewModel()) {
                            showLeagueView = true
                        }
                        Spacer()
                        DailyRewardButton {
                            showEveryHourView = true
                        }
                    }
                    .padding(.horizontal, 15)
                }
                
                viewType()
                    .padding(.horizontal, 14)
                    .padding(.bottom, 59)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image(ImageTitles.SheetRectangle.rawValue)
                        .resizable()
                )
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .ignoresSafeArea()
            }
            
            HStack(spacing: 9) {
                VStack {
                    Image(ImageTitles.MuscularHamsterHead.rawValue)
                        .resizable()
                        .scaledToFit()
                    TextCustom(text: "Burse", size: 10, weight: .bold, color: .white)
                }
                .padding(2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(viewModel.screenType == .burse ? Color.bgTabSelected : Color.bgTab)
                .clipShape(.rect(cornerRadius: 6))
                .onTapGesture {
                    if viewModel.screenType != .burse {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        viewModel.screenType = .burse
                    }
                }
                
                VStack {
                    Image(ImageTitles.PickaxeIcon.rawValue)
                        .resizable()
                        .scaledToFit()
                    TextCustom(text: "Mining", size: 10, weight: .bold, color: .white)
                }
                .padding(2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(viewModel.screenType == .mining ? Color.bgTabSelected : Color.bgTab)
                .clipShape(.rect(cornerRadius: 6))
                .onTapGesture {
                    if viewModel.screenType != .mining {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        viewModel.screenType = .mining
                    }
                }
            }
            .padding(3)
            .background(Color.bgTab)
            .clipShape(.rect(cornerRadius: 6))
            .frame(height: 51)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.horizontal, 15)
            
            if showMiniGame {
                MiniGameView(showMiniGame: $showMiniGame, viewModel: viewModelFactory.makeMiniGameViewModel(), sheetSizeManager: SheetSizeManager(screenHeight: sc.height))
            }
            
            if showSkinsView {
                SkinsView(viewModel: viewModelFactory.makeSkinsViewModel(), showSkinsView: $showSkinsView, sheetSizeManager: SheetSizeManager(screenHeight: sc.height))
            }
            if showProfessionDetail {
                ProfessionDetailsView(sheetSizeManager: SheetSizeManager(screenHeight: sc.height), viewModel: viewModelFactory.makeProfessionDetailViewModel(), professionId: professionId) {
                    showProfessionDetail = false
                }
            }
            if showDailyReward {
                DailyReward(viewModel: viewModelFactory.makeDailyRewardViewModel(), showDailyReward: $showDailyReward, sheetSizeManager: SheetSizeManager(screenHeight: sc.height))
            }
            if showEveryHourView {
                ProfitPerHourView(sheetSizeManager: SheetSizeManager(screenHeight: sc.height)) {
                    viewModel.screenType = .mining
                    showEveryHourView = false
                } closeAction: {
                    showEveryHourView = false
                }
            }
            if showLeagueView {
                LeagueDetailView(sheetSizeManager: SheetSizeManager(screenHeight: sc.height), viewModel: viewModelFactory.makeLeagueDetailViewModel(), imageTitle: viewModel.getImageTitleForSelectedHamster(), showLeagueDetailView: $showLeagueView)
            }
            if showComboHintView {
                ComboHintView(sheetSizeManager: SheetSizeManager(screenHeight: sc.height), showComboHintView: $showComboHintView)
            }
            if showBoostView {
                FillEnergyView(showFillEnergyView: $showBoostView, viewModel: viewModelFactory.makeFillEnergyViewModel(), sheetSizeManager: SheetSizeManager(screenHeight: sc.height))
            }
        }
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
        .onReceive(viewModel.getTimer()) { input in
            viewModel.energyIncrease()
            viewModel.addEveryHourReward(input)
            viewModel.miniGameTimer()
            viewModel.energyReloadTimer()
            viewModel.toNextDayTimer()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification), perform: { _ in
            viewModel.saveData()
        })
    }
    
    @ViewBuilder func viewType() -> some View {
        if viewModel.screenType == .burse  {
            BurseView(viewModel: viewModelFactory.makeBurseViewModel(), screenType: $viewModel.screenType, showMiniGame: $showMiniGame, showDailyReward: $showDailyReward, showBoostView: $showBoostView)
        } else {
            MiningView(viewModel: viewModelFactory.makeMiningViewModel(), showProfessionDetail: $showProfessionDetail, professionId: $professionId, showComboHintView: $showComboHintView)
        }
    }
}

#Preview {
    MainView(viewModel: ViewModelFactory().makeMainViewModel())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .environmentObject(ViewModelFactory())
}
