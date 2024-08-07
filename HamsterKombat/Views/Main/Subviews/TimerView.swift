import SwiftUI

struct TimerView: View {
    
    let minutes: Int
    
    @State var lineWidth: CGFloat = 2
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(LinearGradient(colors: [.loadingIndicator, .white.opacity(0.59)], startPoint: .leading, endPoint: .trailing),
                        style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .round
                        ))
            .padding(lineWidth/2)
            TextCustom(text: "\(minutes)\nmin", size: 10, weight: .bold, color: .white)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    TimerView(minutes: 50)
        .padding()
        .background(Color.black)
}
