import SwiftUI
import Combine

struct TotalProfitPerHourView: View {
    
    @ObservedObject var viewModel: TotalProfitPerHourViewModel
    
    var body: some View {
        HStack(spacing: 7) {
            TextCustom(text: "Profit per hour", size: 12, weight: .semibold, color: .white)
            TextCustom(text: "\(viewModel.totalProfit)", size: 12, weight: .medium, color: .white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [.orangeTopGradient, .orangeBottomGradient], startPoint: .top, endPoint: .bottom))
        .clipShape(.rect(cornerRadius: 6))
        .frame(height: 50)
        .padding(.leading, 14)
    }
}

#Preview {
    TotalProfitPerHourView(viewModel: TotalProfitPerHourViewModel(dataManager: DataManager()))
}

final class TotalProfitPerHourViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    @Published var totalProfit: Int
    
    private var totalProfitCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        totalProfit = dataManager.rewardPerHour
        totalProfitCancellable = dataManager.$rewardPerHour.sink { [weak self] value in
            self?.totalProfit = value
        }
    }
}
