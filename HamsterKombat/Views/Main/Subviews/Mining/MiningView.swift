import SwiftUI

struct MiningView: View {
    
    @EnvironmentObject var viewModelFactory: ViewModelFactory
    
    @ObservedObject var viewModel: MiningViewModel
    
    @Binding var showProfessionDetail: Bool
    @Binding var professionId: Int
    @Binding var showComboHintView: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 6) {
                HStack(spacing: 3) {
                    TextCustom(text: viewModel.reloadTime(), size: 10, weight: .bold, color: .white.opacity(0.4))
                    Image(ImageTitles.WarningFilledIcon.rawValue)
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                .padding(.top, 18)
                .onTapGesture {
                    showComboHintView = true
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                HStack {
                    TextCustom(text: "Combo", size: 15, weight: .bold, color: .white)
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.comboCircle)
                            .padding(3)
                            .background(Circle().fill(viewModel.comboAmount >= 1 ? Color.green : Color.comboCircleBorder))
                        Circle()
                            .fill(Color.comboCircle)
                            .padding(3)
                            .background(Circle().fill(viewModel.comboAmount >= 2 ? Color.green : Color.comboCircleBorder))
                        Circle()
                            .fill(Color.comboCircle)
                            .padding(3)
                            .background(Circle().fill(viewModel.comboAmount >= 3 ? Color.green : Color.comboCircleBorder))
                    }
                    .frame(height: 16)
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Image(ImageTitles.CoinDollarIcon.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 21, height: 21)
                        TextCustom(text: "+20 000", size: 12, weight: .bold, color: .white)
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
                        .resizable()
                        .scaledToFit()
                        .frame(height: 44)
                    TextCustom(text: viewModel.hiddenString(), size: 36, weight: .bold, color: .white)
                        .hidden()
                        .overlay(
                            TextCustom(text: viewModel.balanceString(), size: 36, weight: .bold, color: .white)
                            ,alignment: .leading
                        )
                }
                .padding(.top, 17)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        HStack(spacing: 10) {
                            ProfessionView(viewModel: viewModelFactory.makeProfessionViewModel(), profession: viewModel.getProfession(by: 0)) {
                                professionId = 0
                                showProfessionDetail = true
                            }
                                           
                            ProfessionView(viewModel: viewModelFactory.makeProfessionViewModel(), profession: viewModel.getProfession(by: 1)) {
                                professionId = 1
                                showProfessionDetail = true
                            }
                        }
                        HStack(spacing: 10) {
                            ProfessionView(viewModel: viewModelFactory.makeProfessionViewModel(), profession: viewModel.getProfession(by: 2)) {
                                professionId = 2
                                showProfessionDetail = true
                            }
                            ProfessionView(viewModel: viewModelFactory.makeProfessionViewModel(), profession: viewModel.getProfession(by: 3)) {
                                professionId = 3
                                showProfessionDetail = true
                            }
                        }
                        HStack(spacing: 10) {
                            ProfessionView(viewModel: viewModelFactory.makeProfessionViewModel(), profession: viewModel.getProfession(by: 4)) {
                                professionId = 4
                                showProfessionDetail = true
                            }
                            ProfessionView(viewModel: viewModelFactory.makeProfessionViewModel(), profession: viewModel.getProfession(by: 5), lockedText: viewModel.getProfession(by: 4).level >= 5 ? nil : "HamsterBook lvl 5") {
                                if viewModel.getProfession(by: 4).level >= 5 {
                                    professionId = 5
                                    showProfessionDetail = true
                                }
                            }
                        }
                        HStack(spacing: 10) {
                            ProfessionView(viewModel: viewModelFactory.makeProfessionViewModel(), profession: viewModel.getProfession(by: 6)) {
                                professionId = 6
                                showProfessionDetail = true
                            }
                            ProfessionView(viewModel: viewModelFactory.makeProfessionViewModel(), profession: viewModel.getProfession(by: 7)) {
                                professionId = 7
                                showProfessionDetail = true
                            }
                        }
                    }
                    .padding(.bottom, 59)
                }
                .padding(.top, 19)
            }
            .padding(.horizontal, 15)
        }
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

struct MiningView_Preview: PreviewProvider {
    
    @State static var showProfessionDetail = false
    @State static var professionId = 0
    @State static var showComboHintView = false
    
    static var previews: some View {
        MiningView(viewModel: ViewModelFactory().makeMiningViewModel(), showProfessionDetail: $showProfessionDetail, professionId: $professionId, showComboHintView: $showComboHintView)
            .background(Color.black)
            .environmentObject(ViewModelFactory())
    }
}
