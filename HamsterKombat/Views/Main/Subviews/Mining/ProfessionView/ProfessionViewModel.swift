import Foundation
import Combine

final class ProfessionViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    private var professionCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        professionCancellable = dataManager.$professions.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func isMoneyEnough(id: Int) -> Bool {
        if dataManager.professions[id].price > dataManager.balance {
            return false
        } else {
            return true
        }
    }
    
    func imageTitleBy(id: Int) -> String {
        dataManager.professionImageTitle(id: id)
    }
    
    func textPrice(for id: Int) -> String {
        var balanceStr = ""
        let balance = dataManager.professions[id].price
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
//    
//    func textPrice(for id: Int) -> String {
//        var priceStr = ""
//        let price = dataManager.professtions[id].price
//        if price / 1000000000 >= 1 {
//            priceStr = "\(price/1000000000)B"
//        } else if price / 1000000 >= 1 {
//            priceStr = "\(price/1000000)M"
//        } else if price / 1000 >= 1 {
//            priceStr = "\(price/1000)K"
//        } else {
//            priceStr = "\(price)"
//        }
//        return priceStr
//    }
}
