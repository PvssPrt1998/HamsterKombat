import SwiftUI

struct LeagueDetailView: View {
    
    @StateObject var sheetSizeManager: SheetSizeManager
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @ObservedObject var viewModel: LeagueDetailViewModel
    
    let imageTitle: String
    @Binding var showLeagueDetailView: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    sheetSizeManager.dismissSheet()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showLeagueDetailView = false
                    }
                }
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        Image(ImageTitles.EnergyEllipse.rawValue)
                            .resizable()
                            .frame(width: 260, height: 397)
                        Image(imageTitle)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 154, height: 277)
                    }
                    .padding(.top, 21)
                    TextCustom(text: viewModel.leagueTitle, size: 32, weight: .semibold, color: .white)
                    TextCustom(text: "\(viewModel.balanceStr()) / \(viewModel.balanceForNewleague())", size: 14, weight: .semibold, color: .white.opacity(0.4))
                        .padding(.top, 10)
                    Rectangle()
                        .fill(Color.progressBarBackground)
                        .frame(height: 18)
                        .clipShape(.rect(cornerRadius: 22))
                        .overlay(
                            GeometryReader { geo in
                                Rectangle()
                                    .fill(LinearGradient(colors: [.orangeTopGradient, .orangeBottomGradient], startPoint: .top, endPoint: .bottom))
                                    .frame(width: geo.size.width * viewModel.strokeValue(), height: 18)
                                    .clipShape(.rect(cornerRadius: 22))
                            }
                            ,alignment: .leading
                        )
                        .padding(EdgeInsets(top: 15, leading: 14, bottom: 0, trailing: 14))
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                CloseButton(action: {
                    sheetSizeManager.dismissSheet()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showLeagueDetailView = false
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
            .offset(x: 0, y: sheetSizeManager.topPadding + (sheetSizeManager.screenHeight - 600 - safeAreaInsets.bottom))
            .onAppear {
                sheetSizeManager.appearance()
            }
        }
    }
}

struct LeagueDetailView_Preview: PreviewProvider {
    
    @State static var showLeagueDetailView = false
    
    static var previews: some View {
        LeagueDetailView(sheetSizeManager: SheetSizeManager(screenHeight: UIScreen.screenHeight), viewModel: LeagueDetailViewModel(dataManager: DataManager()), imageTitle: ImageTitles.DefaultHamster.rawValue, showLeagueDetailView: $showLeagueDetailView)
    }
}
