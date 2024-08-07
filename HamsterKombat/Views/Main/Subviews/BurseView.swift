//
//  BurseView.swift
//  HamsterKombat
//
//  Created by Николай Щербаков on 07.08.2024.
//

import SwiftUI

struct BurseView: View {
    var body: some View {
        VStack(spacing: 16) {
            //MARK: - three buttons on top of sheet
            HStack(spacing: 12) {
                Image(ImageTitles.ButtonRectangleWithInnerShadow.rawValue)
                    .overlay(
                        VStack {
                            Image(ImageTitles.Calendar.rawValue)
                            TextCustom(text: "Daily Reward", size: 10, weight: .bold, color: .white)
                        }
                    )
                Image(ImageTitles.ButtonRectangleWithInnerShadow.rawValue)
                    .overlay(
                        VStack {
                            Image(ImageTitles.MagnifyingGlass.rawValue)
                            TextCustom(text: "Combo", size: 10, weight: .bold, color: .white)
                        }
                    )
                Image(ImageTitles.ButtonRectangleWithInnerShadow.rawValue)
                    .overlay(
                        VStack {
                            Image(ImageTitles.Gamepad.rawValue)
                            TextCustom(text: "Mini-game", size: 10, weight: .bold, color: .white)
                        }
                    )
            }
            .padding(.top, 38)
            
            
            VStack(spacing: 8) {
                //MARK: - Coin balance
                HStack(spacing: 7) {
                    Image(ImageTitles.CoinDollarIcon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 44)
                    TextCustom(text: "1500", size: 36, weight: .bold, color: .white)
                }
                
                //MARK: - Hamster
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [.orangeBottomGradient, .orangeTopGradient], startPoint: .bottom, endPoint: .top))
                        .padding(17)
                        .background(
                            Circle()
                                .fill(LinearGradient(colors: [.orangeTopGradient, .orangeBottomGradient], startPoint: .bottom, endPoint: .top))
                        )
                        .shadow(color: .hamsterTapAreaShadow, radius: 25)
                        .padding(.horizontal, 15)
                    Image(ImageTitles.DefaultHamster.rawValue)
                }
            }
            HStack(spacing: 9) {
                Image(ImageTitles.LightningIcon.rawValue)
                TextCustom(text: "1500/1500", size: 16, weight: .semibold, color: .white)
                Spacer()
                Image(ImageTitles.RocketIcon.rawValue)
                TextCustom(text: "Boost", size: 16, weight: .semibold, color: .white)
            }
            .padding(EdgeInsets(top: -12, leading: 15, bottom: 0, trailing: 15))
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    BurseView()
}
