import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    enum ScreenType {
        case burse
        case mining
    }
    
    var everyHourRewardIssued = false
    
    @Published var screenType: ScreenType = .burse
    
    var showInitialExplode: Bool {
        dataManager.showInitialExplode
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        dataManager.localStorage.saveBalance(dataManager.balance)
    }
    
    func getImageTitleForSelectedHamster() -> String {
        dataManager.imageTitleBy(id: dataManager.selectedHamster.id)
    }
    
    func getProfession(by index: Int) -> Profession {
        dataManager.professions[index]
    }
    
    func toNextDayTimer() {
        if dataManager.toNextDayTimer > 0 {
            dataManager.toNextDayTimer -= 1
        }
    }
    
    func getProfessionImageTitle(by index: Int) -> String {
        dataManager.professionImageTitleLarge(id: index)
    }
    
    func miniGameTimer() {
        if dataManager.miniGameReloadTimer > 0 {
            dataManager.miniGameReloadTimer -= 1
        }
    }
    
    func saveData() {
        dataManager.saveData()
    }
    
    func energyReloadTimer() {
        if dataManager.energyTimer > 0 {
            dataManager.energyTimer -= 1
        }
    }
    
    func getTimer() ->  Publishers.Autoconnect<Timer.TimerPublisher> {
        return dataManager.timer
    }
    
    func addEveryHourReward(_ date: Date) {
        dataManager.calculateRewardPerSecond()
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.dateFormat = "dd.MM.yyyy.HH.mm"
//        let dateString = dateFormatter.string(from: date)
//        let dateComponents = dateString.components(separatedBy: ".")
//        if dateComponents[4] == "00" && !everyHourRewardIssued {
//            dataManager.balance += dataManager.rewardPerHour
//            everyHourRewardIssued = true
//        } else {
//            everyHourRewardIssued = false
//        }
    }
    
    
    func energyIncrease() {
        if dataManager.energy < dataManager.maxEnergy {
            if dataManager.energy <= dataManager.maxEnergy - 3 {
                dataManager.energy += 3
            } else {
                dataManager.energy = dataManager.maxEnergy
            }
        }
    }
}
