import SwiftUI

struct DailyReward: View {
    
    @ObservedObject var viewModel: DailyRewardViewModel
    @Binding var showDailyReward: Bool
    @StateObject var sheetSizeManager: SheetSizeManager
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 14), count: 4)
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    sheetSizeManager.dismissSheet()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showDailyReward = false
                    }
                }
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        Image(ImageTitles.EnergyEllipse.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 220, height: 220)
                        Image(ImageTitles.CalendarLarge.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 126, height: 126)
                    }
                    .padding(.top, 55)
                    
                    TextCustom(text: "Daily Reward", size: 36, weight: .bold, color: .white)
                    TextCustom(text: "Collect coins for daily entry into the game without skipping. The \"Pick up\" button must be pressed daily, otherwise the day counter will start over", size: 16, weight: .medium, color: .white)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 20, leading: 44, bottom: 0, trailing: 44))
                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(0..<10, id: \.self) { index in
                            DailyRewardDayView(dayNumber: index + 1,
                                               reward: viewModel.getReward(by: index).reward,
                                               earned: viewModel.earned(index: index), got: viewModel.getReward(by: index).got) {
                                viewModel.action(index: index)
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 20, leading: 24, bottom: 0, trailing: 24))
                    
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                CloseButton(action: {
                    sheetSizeManager.dismissSheet()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showDailyReward = false
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
            .onReceive(viewModel.getTimer()) { input in
                viewModel.setDate(input)
        }
        }
    }
}

struct DailyReward_Preview: PreviewProvider {
    
    @State static var showDailyReward = true
    
    static var previews: some View {
        DailyReward(viewModel: DailyRewardViewModel(dataManager: DataManager()), showDailyReward: $showDailyReward, sheetSizeManager: SheetSizeManager(screenHeight: UIScreen.screenHeight))
    }
    
}
