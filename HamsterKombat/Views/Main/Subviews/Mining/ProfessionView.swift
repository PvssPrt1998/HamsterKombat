import SwiftUI

struct ProfessionView: View {
    
    let imageTitle: String
    let professtionTitle: String
    let silverCoinValue: Int
    let level: Int
    let price: Int
    let specialPrice: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 16) {
                Image(imageTitle)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45)
                    .frame(maxHeight: .infinity)
                    .padding(1)
                ProfessionViewDescription(title: professtionTitle, profit: silverCoinValue)
                Spacer()
            }
            .padding(.top, 10)
            Rectangle()
                .fill(Color.white.opacity(0.1))
                .frame(height: 1)
                .padding(.horizontal, 2)
            HStack(spacing: 0) {
                TextCustom(text: "Lvl \(level)", size: 12, weight: .bold, color: .white.opacity(0.4))
                    .frame(width: 45)
                    .padding(.leading, 1)
                Rectangle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 1, height: 34)
                    .padding(.trailing, specialPrice ? 5 : 16)
                HStack(spacing: 5) {
                    Image(ImageTitles.CoinDollarIcon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    if specialPrice {
                        VStack(spacing: 0) {
                            TextCustom(text: "HamsterBook", size: 12, weight: .bold)
                            TextCustom(text: "Lvl 5", size: 10, weight: .medium)
                        }
                    } else {
                        TextCustom(text: textForPrice(), size: 12, weight: .bold, color: .white)
                    }
                    Spacer()
                }
            }
            .padding(.top, -4)
            
        }
        .frame(height: 113)
        .background(Color.bgTab)
        .clipShape(.rect(cornerRadius: 6))
    }
    
    private func textForPrice() -> String {
        if price < 1000 {
            return "\(price)"
        } else {
            return "\(price/1000)K"
        }
    }
}

#Preview {
    ProfessionView(imageTitle: ImageTitles.HamsterWithCarLarge.rawValue, professtionTitle: "SEO", silverCoinValue: 100, level: 0, price: 1000, specialPrice: false, action: {})
        .padding()
        .background(Color.black)
}
