import SwiftUI

struct ProfessionDetailsView: View {
    @StateObject var sheetSizeManager: SheetSizeManager
    
    @ObservedObject var viewModel: ProfessionDetailsViewModel
    
    let professionId: Int
    let closeAction: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Image(viewModel.imageTitleBy(id: professionId))
                    .resizable()
                    .scaledToFit()
                    //.frame(maxHeight: .infinity, alignment: .bottom)
                    .frame(height: 160)
                    .frame(width: 96)
                    .padding(.top, 35)
                TextCustom(text: viewModel.getProfession(by: professionId).tilte, size: 36, weight: .bold, color: .white)
                    .padding(.top, 9)
                TextCustom(text: viewModel.getProfession(by: professionId).description, size: 16, weight: .medium, color: .white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)
                
                
                if viewModel.isLevelMax(id: professionId) {
                    VStack(spacing: 0) {
                        TextCustom(text: "Total profit", size: 24, weight: .medium, color: .white)
                        HStack(spacing: 1) {
                            Image(ImageTitles.CoinDollarIcon.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            TextCustom(text: "\(viewModel.getProfession(by: professionId).totalProfit)", size: 32, weight: .bold, color: .white)
                        }
                        
                    }
                    .padding(.top, 54)
                   
                } else {
                    TextCustom(text: "Profit per hour", size: 16, weight: .medium, color: .white)
                        .padding(.top, 20)
                    HStack(spacing: 1) {
                        Image(ImageTitles.CoinDollarIcon.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        TextCustom(text: "+\(viewModel.getProfession(by: professionId).profit)", size: 16, weight: .bold, color: .white)
                    }
                    HStack(spacing: 8) {
                        Image(viewModel.isMoneyEnough(id: professionId) ? ImageTitles.CoinDollarIcon.rawValue : ImageTitles.SilverCoin.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                        TextCustom(text: "\(viewModel.getProfession(by: professionId).price)", size: 36, weight: .bold, color: .white.opacity(viewModel.isMoneyEnough(id: professionId) ? 1 : 0.4))
                    }
                    .padding(.top, 11)
                }
                
                
                
                Button {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    viewModel.buttonPressed(id: professionId)
                } label: {
                    HStack(spacing: 3) {
                        if viewModel.isLevelMax(id: professionId) {
                            TextCustom(text: "You reached maximum level", size: 24, weight: .bold, color: .white)
                        } else {
                            TextCustom(text: "Receive", size: 24, weight: .bold, color: .white.opacity(viewModel.isMoneyEnough(id: professionId) ? 1 : 0.4))
                            Image(viewModel.isMoneyEnough(id: professionId) ? ImageTitles.CoinDollarIcon.rawValue : ImageTitles.SilverCoin.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(viewModel.buttonDisabled(id: professionId) ? Color.buySkinButton : Color.blueButton)
                    .clipShape(.rect(cornerRadius: 6))
                    .frame(maxHeight: 72)
                }
                .disabled(viewModel.buttonDisabled(id: professionId))
                .padding(.top, 21)
            }
            .padding(.horizontal, 14)
            .frame(maxHeight: .infinity, alignment: .top)
            
            CloseButton(action: {
                sheetSizeManager.dismissSheet()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    closeAction()
                }})
                .padding(24)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .background(
            Image(ImageTitles.SheetRectangle.rawValue)
                .resizable()
        )
        .offset(x: 0, y: sheetSizeManager.topPadding)
        .onAppear {
            sheetSizeManager.appearance()
        }
    }
}

#Preview {
    ProfessionDetailsView(sheetSizeManager: SheetSizeManager(screenHeight: UIScreen.screenHeight), viewModel: ProfessionDetailsViewModel(dataManager: DataManager()), professionId: 0, closeAction: {}
    )
        .padding()
        .background(Color.black)
}
