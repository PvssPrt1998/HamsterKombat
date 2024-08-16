import SwiftUI

struct MiniGameLaunchView: View {
    
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(ImageTitles.HamsterTeacher.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 143)
                Image(ImageTitles.MiniGameExample.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 175, maxHeight: .infinity, alignment: .top)
                    .padding(EdgeInsets(top: 14, leading: 0, bottom: 0, trailing: 30))
            }
            .frame(maxHeight: 286)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            
            TextCustom(text: "Move the candlesticks of the market and get the keys", size: 20, weight: .bold, color: .white)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 8, leading: 15, bottom: 0, trailing: 15))
            Button {
                action()
            } label: {
                HStack(spacing: 3) {
                    TextCustom(text: "Play", size: 24, weight: .bold, color: .white)
                    Image(ImageTitles.CoinDollarIcon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blueButton)
                .clipShape(.rect(cornerRadius: 6))
                .frame(maxHeight: 72)
            }
            .padding(EdgeInsets(top: 30, leading: 15, bottom: 0, trailing: 15))
        }
    }
}

#Preview {
    MiniGameLaunchView(action: {})
}
