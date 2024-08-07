import SwiftUI

struct DailyRewardButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 7) {
                Image(ImageTitles.CoinDollarIcon.rawValue)
                TextCustom(text: "Every hour", size: 20, weight: .bold, color: .white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [.orangeTopGradient, .orangeBottomGradient], startPoint: .top, endPoint: .bottom))
            .clipShape(.rect(cornerRadius: 6))
            .frame(height: 50)
        }
    }
}

#Preview {
    DailyRewardButton {
        
    }
        .padding()
        .background(Color.black)
}
