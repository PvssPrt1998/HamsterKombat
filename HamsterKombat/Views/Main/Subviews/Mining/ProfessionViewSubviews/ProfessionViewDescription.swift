import SwiftUI

struct ProfessionViewDescription: View {
    
    let title: String
    let profit: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            TextCustom(text: title, size: 14, weight: .medium, color: .white)
            TextCustom(text: "Profit per hour", size: 10, weight: .medium, color: .white.opacity(0.4))
            HStack(spacing: 1) {
                Image(ImageTitles.SilverCoin.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                TextCustom(text: "+\(profit)", size: 12, weight: .bold, color: .white.opacity(0.4))
            }
        }
    }
}

#Preview {
    ProfessionViewDescription(title: "SEO", profit: 270)
        .background(Color.black)
}
