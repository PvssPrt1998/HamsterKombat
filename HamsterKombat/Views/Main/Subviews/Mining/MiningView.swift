import SwiftUI

struct MiningView: View {
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 3) {
                TextCustom(text: "00:09:59", size: 10, weight: .bold, color: .white.opacity(0.4))
                Image(ImageTitles.WarningFilledIcon.rawValue)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .padding(.top, 18)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            HStack {
                TextCustom(text: "Combo", size: 15, weight: .bold, color: .white)
                Spacer()
                
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.comboCircle)
                        .padding(3)
                        .background(Circle().fill(Color.comboCircleBorder))
                    Circle()
                        .fill(Color.comboCircle)
                        .padding(3)
                        .background(Circle().fill(Color.comboCircleBorder))
                    Circle()
                        .fill(Color.comboCircle)
                        .padding(3)
                        .background(Circle().fill(Color.comboCircleBorder))
                }
                .frame(height: 16)
                
                Spacer()
                
                HStack(spacing: 0) {
                    Image(ImageTitles.CoinDollarIcon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 21, height: 21)
                    TextCustom(text: "+5 000 000", size: 12, weight: .bold, color: .white)
                }
                .padding(EdgeInsets(top: 5, leading: 6, bottom: 5, trailing: 6))
                .background(
                    Image(ImageTitles.ComboButtonBackground.rawValue)
                        .resizable()
                )
            }
            .padding(EdgeInsets(top: 6, leading: 9, bottom: 6, trailing: 9))
            .background(Color.comboBackground)
            .clipShape(.rect(cornerRadius: 6))
            
            HStack(spacing: 8) {
                hintButton()
                hintButton()
                hintButton()
            }
            HStack(spacing: 7) {
                Image(ImageTitles.CoinDollarIcon.rawValue)
                TextCustom(text: "1500", size: 36, weight: .bold, color: .white)
            }
            .padding(.top, 17)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        ProfessionView(imageTitle: ImageTitles.HamsterWithCar.rawValue,
                                       professtionTitle: "SEO", silverCoinValue: 100, level: 0, price: 1000, specialPrice: false) {
                            
                        }
                        ProfessionView(imageTitle: ImageTitles.HamsterWithLoudspeaker.rawValue,
                                       professtionTitle: "Marketing", silverCoinValue: 70, level: 0, price: 1000, specialPrice: false) {
                            
                        }
                    }
                    HStack(spacing: 10) {
                        ProfessionView(imageTitle: ImageTitles.ITHamster.rawValue,
                                       professtionTitle: "IT team", silverCoinValue: 240, level: 0, price: 2000, specialPrice: false) {
                            
                        }
                        ProfessionView(imageTitle: ImageTitles.HeadphonesHamster.rawValue,
                                       professtionTitle: "Support team", silverCoinValue: 70, level: 0, price: 750, specialPrice: false) {
                            
                        }
                    }
                    HStack(spacing: 10) {
                        ProfessionView(imageTitle: ImageTitles.HamsterBook.rawValue,
                                       professtionTitle: "HamsterBook", silverCoinValue: 70, level: 0, price: 500, specialPrice: false) {
                            
                        }
                        ProfessionView(imageTitle: ImageTitles.HamsterTube.rawValue,
                                       professtionTitle: "HamsterTube", silverCoinValue: 90, level: 0, price: 0, specialPrice: true) {
                            
                        }
                    }
                    HStack(spacing: 10) {
                        ProfessionView(imageTitle: ImageTitles.xHamster.rawValue,
                                       professtionTitle: "X", silverCoinValue: 90, level: 0, price: 550, specialPrice: false) {
                            
                        }
                        ProfessionView(imageTitle: ImageTitles.CryptoHamster.rawValue,
                                       professtionTitle: "HamsterTube", silverCoinValue: 90, level: 0, price: 350, specialPrice: false) {
                            
                        }
                    }
                }
            }
            .padding(.top, 19)
        }
        .padding(.horizontal, 15)
    }
    
    func hintButton() -> some View {
        Image(ImageTitles.ButtonRectangleWithInnerShadow.rawValue)
            .resizable()
            .scaledToFit()
            .overlay(
                Image(ImageTitles.CoinsIcon.rawValue)
                    .resizable()
                    .scaledToFit()
                ,alignment: .bottom
            )
            .overlay(
                Image(ImageTitles.QuestionMark.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 34)
                    .padding(.top, 14)
                ,alignment: .top
            )
    }
}

#Preview {
    MiningView()
        .background(Color.black)
}
