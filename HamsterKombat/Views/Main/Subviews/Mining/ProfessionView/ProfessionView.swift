import SwiftUI

struct ProfessionView: View {
    
    @ObservedObject var viewModel: ProfessionViewModel
    let profession: Profession
    var lockedText: String?
    
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 16) {
                Image(viewModel.imageTitleBy(id: profession.id))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45)
                    .frame(maxHeight: .infinity)
                    .padding(2)
                ProfessionViewDescription(title: profession.tilte, profit: profession.profit)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 5)
            Rectangle()
                .fill(Color.white.opacity(0.1))
                .frame(height: 1)
                .padding(.horizontal, 2)
            HStack(spacing: 0) {
                TextCustom(text: "Lvl \(profession.level)", size: 12, weight: .bold, color: .white.opacity(0.4))
                    .frame(width: 45)
                    .padding(.leading, 1)
                Rectangle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 1, height: 34)
                    .padding(.trailing, 16)
                if lockedText != nil {
                    VStack(spacing: 1) {
                        TextCustom(text: lockedTextElements().0, size: 12, weight: .bold, color: .white)
                        TextCustom(text: lockedTextElements().1, size: 10, weight: .medium, color: .white)
                    }
                    
                } else {
                    HStack(spacing: 5) {
                        Image(viewModel.isMoneyEnough(id: profession.id) ? ImageTitles.CoinDollarIcon.rawValue : ImageTitles.SilverCoin.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        TextCustom(text: viewModel.textPrice(for: profession.id), size: 12, weight: .bold, color: .white)
                        Spacer()
                    }
                }
            }
            .padding(.top, -4)
        }
        .frame(height: 113)
        .background(Color.bgTab)
        .clipShape(.rect(cornerRadius: 6))
        .onTapGesture {
            action()
        }
    }
    
    func lockedTextElements() -> (String, String) {
        guard let lockedText = lockedText else { return ("","")}
        let text = lockedText.components(separatedBy: " ")
        return (text[0], text[1] + " " + text[2])
        
    }
}

#Preview {
    ProfessionView(viewModel: ProfessionViewModel(dataManager: DataManager()), profession: Profession(id: 5, level: 0, tilte: "HamsterTube", description: "Increase the presence of your exchange on HumsterTube", profit: 80, price: 550, initialPrice: 550, initialProfit: 80, totalProfit: 0), action: {
        
    })
        .padding()
        .background(Color.black)
}
