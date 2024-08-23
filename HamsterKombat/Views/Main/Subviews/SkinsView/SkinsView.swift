import SwiftUI

struct SkinsView: View {
    
    @ObservedObject var viewModel: SkinsViewModel
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @Binding var showSkinsView: Bool
    
    @StateObject var sheetSizeManager: SheetSizeManager
    
    @EnvironmentObject var viewModelFactory: ViewModelFactory
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                TextCustom(text: "Skin", size: 20, weight: .bold, color: .white)
                    .padding(.top, 24)
                SelectedSkinView(viewModel: viewModelFactory.makeSelectedSkinViewModel(), selection: $viewModel.selection)
                    .padding(.top, 24)
                TextCustom(text: viewModel.name, size: 16, weight: .semibold, color: .white)
                TextCustom(text: viewModel.description, size: 12, weight: .semibold, color: .white.opacity(0.4))
                    .multilineTextAlignment(.center)
                    .frame(height: 44)
                    .padding(.horizontal, 14)
                if viewModel.isSelectedHamsterPurchased() {
                    TextCustom(text: "Purchased", size: 12, weight: .semibold, color: Color.purchasedText)
                        .frame(height: 44)
                } else {
                    HStack {
                        Image(viewModel.isMoneyEnough ? ImageTitles.CoinDollarIcon.rawValue : ImageTitles.SilverCoin.rawValue)
                            .resizable()
                            .scaledToFit()
                        TextCustom(text: viewModel.price, size: 20, weight: .bold, color: .white.opacity(viewModel.isMoneyEnough ? 1 : 0.4))
                    }
                    .frame(height: 44)
                }
                Button {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    viewModel.buttonPressed()
                } label: {
                    TextCustom(text: viewModel.buttonTitle(), size: 16, weight: .semibold, color: .white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(viewModel.buttonDisabled() ? Color.buySkinButton : Color.blueButton)
                        .frame(height: 54)
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(.horizontal, 14)
                }
                .disabled(viewModel.buttonDisabled())
                .padding(.top, 8)
                
                SkinsListView(selection: $viewModel.selection, viewModel: viewModelFactory.makeSkinsListViewModel())
                    .padding(EdgeInsets(top: 24, leading: 14, bottom: safeAreaInsets.bottom + 8, trailing: 14))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            CloseButton(action: {
                sheetSizeManager.dismissSheet()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    showSkinsView = false
                }
            })
                .padding(24)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .frame(maxHeight: .infinity, alignment: .top)
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

struct SkinsView_Preview: PreviewProvider {
    
    @State static var showSkinsView = false
    
    static var previews: some View {
        SkinsView(viewModel: ViewModelFactory().makeSkinsViewModel(), showSkinsView: $showSkinsView, sheetSizeManager: SheetSizeManager(screenHeight: UIScreen.screenHeight))
            .environmentObject(ViewModelFactory())
    }
    
}
