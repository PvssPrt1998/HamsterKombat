import SwiftUI

struct CoinsForAdButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 7) {
                Image(ImageTitles.VideoIcon.rawValue)
                TextCustom(text: "Get coins", size: 20, weight: .bold, color: .white)
                TimerView(minutes: 50)
                    .padding(.vertical, 7)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [.orangeTopGradient, .orangeBottomGradient], startPoint: .bottom, endPoint: .top))
            .clipShape(.rect(cornerRadius: 6))
            .frame(height: 50)
        }
    }
}

#Preview {
    CoinsForAdButton {
        
    }
        .padding()
        .background(Color.black)
}
