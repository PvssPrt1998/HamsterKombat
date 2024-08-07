//
//  LeagueView.swift
//  HamsterKombat
//
//  Created by Николай Щербаков on 07.08.2024.
//

import SwiftUI

struct LeagueView: View {
    
    let text: String
    let value: Int
    let totalValue: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                HStack {
                    TextCustom(text: text, size: 16, weight: .bold, color: .white)
                    Image(systemName: "chevron.right")
                        .fontCustom(size: 16, weight: .bold, color: .white)
                }
                Spacer()
                HStack(spacing: 0) {
                    TextCustom(text: "\(value)", size: 16, weight: .bold, color: .white)
                    TextCustom(text: "/\(totalValue)", size: 16, weight: .bold, color: .white.opacity(0.5))
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
                            .frame(width: (geo.size.width / CGFloat(totalValue)) * CGFloat(value) , height: 12)
                            .clipShape(.rect(cornerRadius: 22))
                    }
                    ,alignment: .leading
                )
        }
        .frame(width: 137)
    }
}

#Preview {
    LeagueView(text: "Silver", value: 2, totalValue: 11)
        .padding()
        .background(Color.black)
}
