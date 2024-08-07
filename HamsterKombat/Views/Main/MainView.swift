
import SwiftUI

struct MainView: View {
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
                ZStack {
                    viewType()
                }
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
                    TextCustom(text: "Burse", size: 10, weight: .bold, color: .white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.bgTabSelected)
                .clipShape(.rect(cornerRadius: 6))
                
                VStack {
                    Image(ImageTitles.PickaxeIcon.rawValue)
                    TextCustom(text: "Mining", size: 10, weight: .bold, color: .white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(3)
            .background(Color.bgTab)
            .clipShape(.rect(cornerRadius: 6))
            .frame(height: 51)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.horizontal, 15)
        }
    }
    
    @ViewBuilder func viewType() -> some View {
        BurseView()
    }
}

#Preview {
    MainView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
}
