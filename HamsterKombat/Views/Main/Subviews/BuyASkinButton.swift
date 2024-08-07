import SwiftUI

struct BuyASkinButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 7) {
                Image(ImageTitles.MuscularHumsterButtonIcon.rawValue)
                    .frame(width: 36, height: 36)
                    .background(Color.specialGray1)
                    .clipShape(.rect(cornerRadius: 3))
                TextCustom(text: "Buy a skin", size: 10, weight: .bold, color: .white)
                Image(ImageTitles.CoolMuscularHamsterButtonIcon.rawValue)
            }
            .background(LinearGradient(colors: [.orangeTopGradient, .orangeBottomGradient], startPoint: .top, endPoint: .bottom))
            .clipShape(.rect(cornerRadius: 3))
            .frame(height: 36)
        }
    }
}

#Preview {
    BuyASkinButton {
        
    }
}
