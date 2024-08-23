import SwiftUI

struct TapTextView: View {
    
    let tapValue: Int
    @ObservedObject var tap: NumberTap
    
    var body: some View {
        TextCustom(text: "+\(tapValue)", size: 36, weight: .bold, color: .white.opacity(tap.opacity))
            .padding(EdgeInsets(top: tap.y, leading: tap.x, bottom: 0, trailing: 0))
            .offset(y: -tap.offset)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    TapTextView(tapValue: 1, tap: NumberTap(x: 100, y: 100))
        .frame(width: 200, height: 200)
}
