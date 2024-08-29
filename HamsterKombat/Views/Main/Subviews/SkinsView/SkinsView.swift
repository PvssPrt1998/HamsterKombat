import SwiftUI

struct SkinsView: View {
    
    @ObservedObject var viewModel: SkinsViewModel
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @Binding var showSkinsView: Bool
    
    @State var origin: CGPoint = .zero
    @State var origin1: CGPoint = .zero
    @State var origin2: CGPoint = .zero
    @State var origin3: CGPoint = .zero
    @State var coinsOpacity: CGFloat = 0
    
    @StateObject var sheetSizeManager: SheetSizeManager
    
    @EnvironmentObject var viewModelFactory: ViewModelFactory
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    sheetSizeManager.dismissSheet()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showSkinsView = false
                    }
                }
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
                                .background(
                                    GeometryReader { geo in
                                        Color.clear.onAppear(perform: {
                                            DispatchQueue.main.async {
                                                origin = geo.frame(in: .global).origin
                                                origin1 = geo.frame(in: .global).origin
                                                origin2 = geo.frame(in: .global).origin
                                                origin3 = geo.frame(in: .global).origin
                                            }
                                        })
                                    }
                                )
                            TextCustom(text: viewModel.price, size: 20, weight: .bold, color: .white.opacity(viewModel.isMoneyEnough ? 1 : 0.4))
                        }
                        .frame(height: 44)
                    }
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        if viewModel.buttonTitle() == "Buy" {
                            coinsOpacity = 1
                            withAnimation(.linear(duration: 1)) {
                                origin = .zero
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.linear(duration: 1)) {
                                    origin1 = .zero
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                withAnimation(.linear(duration: 1)) {
                                    origin2 = .zero
                                }
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                withAnimation(.linear(duration: 1)) {
                                    origin3 = .zero
                                }
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                                coinsOpacity = 0
                            }
                        }
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
            .overlay(
                coinViews()
            )
        }
    }
    
    func coinViews() -> some View {
        ZStack {
            Image(ImageTitles.CoinDollarIcon.rawValue)
                .resizable()
                .scaledToFit()
                .frame(height: 44)
                .padding(EdgeInsets(top: origin.y, leading: origin.x, bottom: 0, trailing: 0))
                .opacity(coinsOpacity)
            Image(ImageTitles.CoinDollarIcon.rawValue)
                .resizable()
                .scaledToFit()
                .frame(height: 44)
                .padding(EdgeInsets(top: origin1.y, leading: origin1.x, bottom: 0, trailing: 0))
                .opacity(coinsOpacity)
            Image(ImageTitles.CoinDollarIcon.rawValue)
                .resizable()
                .scaledToFit()
                .frame(height: 44)
                .padding(EdgeInsets(top: origin2.y, leading: origin2.x, bottom: 0, trailing: 0))
                .opacity(coinsOpacity)
            Image(ImageTitles.CoinDollarIcon.rawValue)
                .resizable()
                .scaledToFit()
                .frame(height: 44)
                .padding(EdgeInsets(top: origin3.y, leading: origin3.x, bottom: 0, trailing: 0))
                .opacity(coinsOpacity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct SkinsView_Preview: PreviewProvider {
    
    @State static var showSkinsView = false
    
    static var previews: some View {
        SkinsView(viewModel: ViewModelFactory().makeSkinsViewModel(), showSkinsView: $showSkinsView, sheetSizeManager: SheetSizeManager(screenHeight: UIScreen.screenHeight))
            .environmentObject(ViewModelFactory())
    }
    
}
