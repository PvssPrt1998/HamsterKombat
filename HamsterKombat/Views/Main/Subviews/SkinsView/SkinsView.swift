import SwiftUI

struct SkinsView: View {
    
    @ObservedObject var viewModel: SkinsViewModel
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
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
                        Image(ImageTitles.SilverCoin.rawValue)
                            .resizable()
                            .scaledToFit()
                        TextCustom(text: viewModel.price, size: 20, weight: .bold, color: .white.opacity(0.4))
                    }
                    .frame(height: 44)
                }
                Button {
                    
                } label: {
                    TextCustom(text: "Choose", size: 16, weight: .semibold, color: .white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.buySkinButton)
                        .frame(height: 54)
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(.horizontal, 14)
                }
                .padding(.top, 8)
                
                SkinsListView(selection: $viewModel.selection, viewModel: viewModelFactory.makeSkinsListViewModel())
                    .padding(EdgeInsets(top: 24, leading: 14, bottom: safeAreaInsets.bottom + 8, trailing: 14))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            CloseButton(action: {})
                .padding(24)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(
            Image(ImageTitles.SheetRectangle.rawValue)
                .resizable()
        )
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

#Preview {
    SkinsView(viewModel: ViewModelFactory().makeSkinsViewModel())
        .environmentObject(ViewModelFactory())
}
