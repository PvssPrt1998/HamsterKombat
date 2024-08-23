import SwiftUI

struct LeagueView: View {
    
    @ObservedObject var viewModel: LeagueViewModel
    
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 2) {
            HStack {
                HStack {
                    TextCustom(text: viewModel.leagueTitle, size: 16, weight: .bold, color: .white)
                    Image(systemName: "chevron.right")
                        .fontCustom(size: 16, weight: .bold, color: .white)
                }
                Spacer()
                HStack(spacing: 0) {
                    TextCustom(text: "\(viewModel.leagueId + 1)", size: 16, weight: .bold, color: .white)
                    TextCustom(text: "/\(11)", size: 16, weight: .bold, color: .white.opacity(0.5))
                }
            }
            Rectangle()
                .fill(Color.progressBarBackground)
                .frame(height: 12)
                .clipShape(.rect(cornerRadius: 22))
                .overlay(
                    GeometryReader { geo in
                        Rectangle()
                            .fill(LinearGradient(colors: [.orangeTopGradient, .orangeBottomGradient], startPoint: .top, endPoint: .bottom))
                            .frame(width: geo.size.width * strokeValue() , height: 12)
                            .clipShape(.rect(cornerRadius: 22))
                    }
                    ,alignment: .leading
                )
        }
        .frame(width: 137)
        .onTapGesture {
            action()
        }
    }
    
    func strokeValue() -> CGFloat {
        CGFloat(viewModel.leagueId + 1) / CGFloat(11)
    }
}

#Preview {
    LeagueView(viewModel: ViewModelFactory().makeLeagueViewModel()) {
        
    }
        .padding()
        .background(Color.black)
}
