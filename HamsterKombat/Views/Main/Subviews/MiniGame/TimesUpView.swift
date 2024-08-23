import SwiftUI
import Combine

struct TimesUpView: View {
    
    @ObservedObject var viewModel: TimesUpViewModel
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Image(ImageTitles.EnergyEllipse.rawValue)
                    .resizable()
                    .frame(width: 200, height: 200)
                Image(ImageTitles.Alarm.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 139)
            }
            .padding(.top, 15)
            TextCustom(text: "Time's up", size: 36, weight: .bold, color: .white)
            
            Button {
                action()
            } label: {
                if viewModel.timerValue > 0 {
                    HStack(spacing: 14) {
                        TextCustom(text: "Replay", size: 24, weight: .bold, color: .white)
                        HStack(spacing: 7) {
                            Image(ImageTitles.AlarmIcon.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            TextCustom(text: viewModel.reloadTime(), size: 16, weight: .medium, color: .white)
                        }
                        .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
                        .background(Color.bgTab)
                        .clipShape(.rect(cornerRadius: 23))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(height: 72)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    )
                    .padding(.horizontal, 14)
                } else {
                    TextCustom(text: "Replay", size: 24, weight: .bold, color: .white)
                        .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.blueButton)
                        .frame(height: 72)
                        .clipShape(.rect(cornerRadius: 6))
                        .padding(.horizontal, 14)
                }
            }
            .disabled(viewModel.buttonDisabled)
            .padding(.top, 40)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    TimesUpView(viewModel: TimesUpViewModel(dataManager: DataManager())) {
        
    }
    .background(Color.black)
}

final class TimesUpViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    @Published var timerValue: Int
    
    var buttonDisabled: Bool {
        timerValue > 0
    }
    
    private var timerCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        timerValue = dataManager.miniGameReloadTimer
        timerCancellable = dataManager.$miniGameReloadTimer.sink { [weak self] value in
            self?.timerValue = value
        }
    }
    
    func reloadTime() -> String {
        let minutes = timerValue / 60
        let seconds = timerValue - (timerValue / 60 * 60)
        var secondsStr = ""
        if seconds >= 10 {
            secondsStr = "\(seconds)"
        } else {
            secondsStr = "0\(seconds)"
        }
        return "\(minutes):" + secondsStr
    }
}
