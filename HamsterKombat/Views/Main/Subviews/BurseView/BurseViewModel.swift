import SwiftUI
import Combine

final class BurseViewModel: ObservableObject {
    
    @Published var dataManager: DataManager

    var energy: Int {
        dataManager.energy
    }

    var maxEnergy: Int
    
    var tapValue: Int {
        dataManager.tapValue
    }
    
    @Published var timerValue: Int
    
    private var balanceCancellable: AnyCancellable?
    private var energyCancellable: AnyCancellable?
    
    var miniGameAvailable: Bool {
        return dataManager.miniGameReloadTimer <= 0
    }

    @Published var tapIndex = 0
    
    var taps: Array<NumberTap> = [
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0),
        NumberTap(x: 0, y: 0)
    ]
    
    private var miniGameReloadCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        timerValue = dataManager.miniGameReloadTimer
        maxEnergy = dataManager.maxEnergy
        balanceCancellable = dataManager.$balance.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
        energyCancellable = dataManager.$energy.sink { [weak self] value in
            self?.objectWillChange.send()
        }
        miniGameReloadCancellable = dataManager.$miniGameReloadTimer.sink { [weak self] value in
            self?.timerValue = value
        }
    }
    
    func reloadTime() -> String {
        let hours = timerValue / 3600
        let minutes = timerValue / 60 - ((timerValue / 3600) * 60)
        let seconds = timerValue - (timerValue / 60 * 60)
        var secondsStr = ""
        var hoursStr = ""
        
        if hours > 0 {
            hoursStr = "\(hours):"
        }
        
        if seconds >= 10 {
            secondsStr = "\(seconds)"
        } else {
            secondsStr = "0\(seconds)"
        }
        return hoursStr + "\(minutes):" + secondsStr
    }
    
    func hiddenReloadStr() -> String {
        var timeString = reloadTime()
        timeString = timeString.replacingOccurrences(of: "0", with: "9")
        timeString = timeString.replacingOccurrences(of: "1", with: "9")
        timeString = timeString.replacingOccurrences(of: "2", with: "9")
        timeString = timeString.replacingOccurrences(of: "3", with: "9")
        timeString = timeString.replacingOccurrences(of: "4", with: "9")
        timeString = timeString.replacingOccurrences(of: "5", with: "9")
        timeString = timeString.replacingOccurrences(of: "6", with: "9")
        timeString = timeString.replacingOccurrences(of: "7", with: "9")
        timeString = timeString.replacingOccurrences(of: "8", with: "9")
        
        return timeString + " "
    }
    
    func getTimer() ->  Publishers.Autoconnect<Timer.TimerPublisher> {
        return dataManager.timer
    }
    
    func energyDecrease() {
        dataManager.energy -= dataManager.tapValue
    }
    
    func energyIncrease() {
        if energy < maxEnergy {
            if energy <= maxEnergy - 3 {
                dataManager.energy += 3
            } else {
                dataManager.energy = maxEnergy
            }
        }
    }
    
    func selectedImageTitle() -> String {
        dataManager.imageTitleBy(id: dataManager.selectedHamster.id)
    }
    
    func balanceString() -> String {
        String(String("\(dataManager.balance)".reversed()).separate(every: 3, with: ",").reversed())
    }
    
    func hiddenString() -> String {
        var str = " "
        for _ in 0..<"\(dataManager.balance)".count {
            str += "9"
        }
        str = String(String(str.reversed()).separate(every: 3, with: ",").reversed())
        str += " "
        return str
    }
    
    func hiddenEnergyString() -> String {
        var str = ""
        for _ in 0..<"\(energy)".count {
            str += "9"
        }
        str += " "
        return str
    }
    
    func tap() {
        dataManager.balance += dataManager.tapValue
        energyDecrease()
    }
    
    func tapValue(x: CGFloat, y: CGFloat) {
        taps[tapIndex].y = y
        taps[tapIndex].x = x + CGFloat(Int.random(in: -5...5))
        taps[tapIndex].reset()
        taps[tapIndex].start()
    
        if tapIndex < 19 {
            tapIndex += 1
        } else {
            tapIndex = 0
        }
    }
    
    func isTapDisabled() -> Bool {
        energy < tapValue ? true : false
    }
}

extension String {
    func separate(every stride: Int = 4, with separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
}

final class NumberTap: ObservableObject {
    var x: CGFloat
    var y: CGFloat
    @Published var opacity: CGFloat = 0
    @Published var offset: CGFloat = 0
    
    init(x: CGFloat, y: CGFloat) {
        self.x = x
        self.y = y
    }
    
    func start() {
        withAnimation(.linear(duration: 1)) {
            offset = y
            opacity = 0
        }
    }
    
    func reset() {
        opacity = 1
        offset = 0
    }
}
