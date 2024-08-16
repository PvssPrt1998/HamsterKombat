
import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @EnvironmentObject var viewModelFactory: ViewModelFactory
    
    @State var showMiniGame: Bool = false
    
    var body: some View {
        ZStack {
            Color.bgMain.ignoresSafeArea()
            VStack(spacing: 12) {
                HStack(spacing: 5) {
                    DailyRewardButton {
                        
                    }
                    CoinsForAdButton {
                        
                    }
                }
                .padding(.horizontal, 15)
                HStack {
                    BuyASkinButton {
                        
                    }
                    Spacer()
                    LeagueView(text: "Silver", value: 2, totalValue: 11)
                }
                .padding(.horizontal, 15)
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
                
            }
        }
    }
    
    @ViewBuilder func viewType() -> some View {
        if viewModel.screenType == .burse  {
            BurseView(viewModel: viewModelFactory.makeBurseViewModel(), showMiniGame: $showMiniGame)
        } else {
            MiningView()
        }
    }
}

#Preview {
    MainView(viewModel: ViewModelFactory().makeMainViewModel())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .environmentObject(ViewModelFactory())
}
