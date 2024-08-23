import SwiftUI

struct ProfitPerHourView: View {
    
    @StateObject var sheetSizeManager: SheetSizeManager
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    let action: () -> Void
    let closeAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .onTapGesture {
                    sheetSizeManager.dismissSheet()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        closeAction()
                    }
                }
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        Image(ImageTitles.EnergyEllipse.rawValue)
                            .resizable()
                            .scaledToFit()
                        Image(ImageTitles.rocket.rawValue)
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 190, height: 190)
                    .padding(.top, 51)
                    TextCustom(text: "Increase your profit", size: 36, weight: .bold, color: .white)
                        .padding(.top, 10)
                    TextCustom(text: "Go to the mining menu and buy upgrades for your exchange to increase", size: 16, weight: .medium, color: .white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                    TextCustom(text: "Earn offline for 3 hours", size: 16, weight: .medium, color: .white)
                        .padding(.top, 10)
                    
                    Button {
                        sheetSizeManager.dismissSheet()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            action()
                        }
                    } label: {
                        HStack(spacing: 3) {
                            TextCustom(text: "Start mining", size: 24, weight: .bold, color: .white)
                            Image(ImageTitles.CoinDollarIcon.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 28)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.blueButton)
                        .clipShape(.rect(cornerRadius: 6))
                        .frame(maxHeight: 72)
                    }
                    .padding(.top, 39)
                }
                .padding(.horizontal, 14)
                .frame(maxHeight: .infinity, alignment: .top)
                CloseButton(action: {
                    sheetSizeManager.dismissSheet()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        closeAction()
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
            .offset(x: 0, y: sheetSizeManager.topPadding + (sheetSizeManager.screenHeight - 542 - safeAreaInsets.bottom))
            .onAppear {
                sheetSizeManager.appearance()
            }
        }
    }
}

struct ProfitPerHour_Preview: PreviewProvider {
    
    static var previews: some View {
        ProfitPerHourView(sheetSizeManager: SheetSizeManager(screenHeight: UIScreen.screenHeight)) {
            
        } closeAction: {
            
        }
    }
}
