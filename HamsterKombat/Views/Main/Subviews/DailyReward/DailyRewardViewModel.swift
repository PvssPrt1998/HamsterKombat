import Foundation
import Combine

final class DailyRewardViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    var date: Date = Date()
    
    var dayIndex: Int {
        dataManager.dayIndex
    }
    
    var rewardsCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        rewardsCancellable = dataManager.$rewards.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func getReward(by index: Int) -> Day {
        dataManager.rewards[index]
    }
    
    func earned(index: Int) -> Bool {
        index == dayIndex
    }
    
    func action(index: Int) {
        if index == dataManager.dayIndex {
            dataManager.getReward()
        }
    }
    
    func getTimer() -> Publishers.Autoconnect<Timer.TimerPublisher> {
        return dataManager.timer
    }
    
    func setDate(_ date: Date) {
        self.date = date
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy.HH.mm"
        let dateString = dateFormatter.string(from: date)
        let dateComponents = dateString.components(separatedBy: ".")
        if dateComponents[0] != dataManager.dailyRewardDay {
            dataManager.increaseOrDropDayIndex(dateComponents[0])
        }
    }
}
