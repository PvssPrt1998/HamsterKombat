import Foundation
import Combine

final class LeagueDetailViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    var balanceForNewLeague: Int {
        dataManager.getValueForNewLeague()
    }
    
    var balance: Int {
        dataManager.balance
    }
    
    var leagueTitle: String {
        switch dataManager.leagueId {
        case 0: return "Bronze"
        case 1: return "Silver"
        case 2: return "Gold"
        case 3: return "Platinum"
        case 4: return "Diamond"
        case 5: return "Epic"
        case 6: return "Legendary"
        case 7: return "Master"
        case 8: return "Grandmaster"
        case 9: return "Lord"
        case 10: return "Creator"
        default: return "Unknown"
        }
    }
    
    private var leagueCancellable: AnyCancellable?
    private var balanceCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        leagueCancellable = dataManager.$leagueId.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        balanceCancellable = dataManager.$balance.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func strokeValue() -> CGFloat {
        var value = CGFloat(balance) / CGFloat(balanceForNewLeague)
        if  value >= CGFloat(1) / CGFloat(20) {
            if value > 1 {
                value = 1
            }
            return value
        } else { return 0 }
    }
    
    func balanceStr() -> String {
        var balanceStr = ""
        let balance = dataManager.balance
        if balance / 1000000000 >= 1 {
            var truncateValue = 2
            let value = Double(balance)/Double(1000000000)
            if Int(value * 100) % 10 == 0 {
                truncateValue = 1
            }
            if Int(value * 100) % 100 == 0 {
                truncateValue = 0
            }
            balanceStr = "\((Double(balance)/Double(1000000000)).fractionDigitsRounded(to: truncateValue))B"
        } else if balance / 1000000 >= 1 {
            var truncateValue = 2
            let value = Double(balance)/Double(1000000)
            if Int(value * 100) % 10 == 0 {
                truncateValue = 1
            }
            if Int(value * 100) % 100 == 0 {
                truncateValue = 0
            }
            balanceStr = "\((Double(balance)/Double(1000000)).fractionDigitsRounded(to: truncateValue))M"
        } else if balance / 1000 >= 1 {
            var truncateValue = 2
            let value = Double(balance)/Double(1000)
            if Int(value * 100) % 10 == 0 {
                truncateValue = 1
            }
            if Int(value * 100) % 100 == 0 {
                truncateValue = 0
            }
            balanceStr = "\((Double(balance)/Double(1000)).fractionDigitsRounded(to: truncateValue))K"
        } else {
            balanceStr = "\(balance)"
        }
        return balanceStr
    }
    
    func balanceForNewleague() -> String {
        var balanceStr = ""
        let balance = dataManager.getValueForNewLeague()
        if balance / 1000000000 >= 1 {
            balanceStr = "\(balance/1000000000)B"
        } else if balance / 1000000 >= 1 {
            balanceStr = "\(balance/1000000)M"
        } else if balance / 1000 >= 1 {
            balanceStr = "\(balance/1000)K"
        } else {
            balanceStr = "\(balance)"
        }
        return balanceStr
    }
}
