import SwiftUI

struct DailyRewardDayView: View {
    
    let dayNumber: Int
    let reward: Int
    let earned: Bool
    let got: Bool
    
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 2) {
            TextCustom(text: "Day \(dayNumber)", size: 14, weight: .bold, color: .white)
            Image(ImageTitles.CoinDollarIcon.rawValue)
                .resizable()
                .frame(width: 28, height: 28)
            TextCustom(text: rewardString(), size: 14, weight: .bold, color: .white)
        }
        .padding(EdgeInsets(top: 4, leading: 18, bottom: 4, trailing: 18))
        .frame(width: 80, height: 80)
        .background(background())
        .clipShape(.rect(cornerRadius: 6))
        .onTapGesture {
            action()
        }
    }
    
    @ViewBuilder func background() -> some View {
        if got {
            LinearGradient(colors: [.dailyRewardGradient1, .dailyRewardGradient2], startPoint: .top, endPoint: .bottom)
        } else if earned {
            ZStack {
                Color.bgTab
                RoundedRectangle(cornerRadius: 6)
                           .stroke(LinearGradient(colors: [.dailyRewardGradient1, .dailyRewardGradient2], startPoint: .top, endPoint: .bottom), lineWidth: 4)
            }
        } else {
            Color.bgTab
        }
    }
    
    func rewardString() -> String {
        if reward >= 1000000 {
            "\(reward/1000000)" + "\(reward % 1000000 > 0 ? ",\(reward % 1000000 / 100000)M" : "M")"
        } else if reward >= 1000 {
            "\(reward/1000)" + "\(reward % 1000 > 0 ? ",\(reward % 1000 / 100)K" : "K")"
        } else {
            "\(reward)"
        }
    }
}

#Preview {
    DailyRewardDayView(dayNumber: 1, reward: 2500, earned: true, got: true, action: {})
        .background(Color.black)
}
