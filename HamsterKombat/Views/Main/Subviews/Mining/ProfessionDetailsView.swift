//
//  ProfessionDetailsView.swift
//  HamsterKombat
//
//  Created by Николай Щербаков on 08.08.2024.
//

import SwiftUI

struct ProfessionDetailsView: View {
    let imageTitle: String
    let title: String
    let description: String
    let profit: Int
    let price: Int
    let closeAction: () -> Void
    let action: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Image(imageTitle)
                    .padding(.top, 35)
                TextCustom(text: title, size: 36, weight: .bold, color: .white)
                    .padding(.top, 9)
                TextCustom(text: description, size: 16, weight: .medium, color: .white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)
                TextCustom(text: "Profit per hour", size: 16, weight: .medium, color: .white)
                    .padding(.top, 20)
                HStack(spacing: 1) {
                    Image(ImageTitles.CoinDollarIcon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    TextCustom(text: "+\(profit)", size: 16, weight: .bold, color: .white)
                }
                HStack(spacing: 8) {
                    Image(ImageTitles.CoinDollarIcon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                    TextCustom(text: "\(price)", size: 36, weight: .bold, color: .white)
                }
                .padding(.top, 11)
                
                Button {
                    action()
                } label: {
                    HStack(spacing: 3) {
                        TextCustom(text: "Receive", size: 24, weight: .bold, color: .white)
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
                .padding(.top, 21)
            }
            .padding(.horizontal, 14)
            .frame(maxHeight: .infinity, alignment: .top)
            
            CloseButton(action: closeAction)
                .padding(24)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .background(
            Image(ImageTitles.SheetRectangle.rawValue)
                .resizable()
        )
    }
}

#Preview {
    ProfessionDetailsView(imageTitle: ImageTitles.HamsterWithCarLarge.rawValue , title: "SEO", description: "Develop your management skills as a company founder. Improve your leadership skills. Attract the best people to your team", profit: 100, price: 1103, closeAction: {}, action: {}
    )
        .padding()
        .background(Color.black)
}
