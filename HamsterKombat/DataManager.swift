import SwiftUI

final class DataManager: ObservableObject {
    
    let localStorage = LocalStorage()
    @Published var localDataLoaded = false
    
    @Published var leagueId: Int = 0
    @Published var balance: Int = 0 {
        didSet {
            leagueCheck()
        }
    }
    @Published var rewardPerHour: Int = 0
    @Published var energy: Int = 1500
    @Published var energyTimer: Int = 0
    
    @Published var combo: Array<(Int,Bool)> = []
    var comboIssued: Bool = false
    
    @AppStorage("firstLaunch") var firstLaunch = true
    
    var maxEnergyLevel = 1
    var maxEnergy = 1500
    @Published var maxEnergyLevelPrice = 2000
    
    @Published var miniGameTimer: Int = 60
    @Published var miniGameReloadTimer: Int = 0
    var tapValue: Int = 1
    var tapValueLevel: Int = 1
    @Published var tapValueLevelPrice: Int = 1000
    
    @Published var toNextDayTimer: Int = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published var hamsters: Array<Hamster>
    
    @Published var professions: Array<Profession>

    @Published var dayIndex: Int = 0
    @Published var dailyRewardDay = ""
    
    var dateString: String = "21.08.2024.00.00"

    var selectedHamsterId: Int = 0
    
    @Published var rewards: Array<Day> = [
        Day(reward: 500, got: false),
        Day(reward: 1000, got: false),
        Day(reward: 2500, got: false),
        Day(reward: 5000, got: false),
        Day(reward: 15000, got: false),
        Day(reward: 25000, got: false),
        Day(reward: 100000, got: false),
        Day(reward: 500000, got: false),
        Day(reward: 1000000, got: false),
        Day(reward: 5000000, got: false)
    ]
    
    var selectedHamster: Hamster {
        didSet {
            selectedHamsterId = selectedHamster.id
        }
    }
    
    let profitIndexes: Array<Double> = [1, 1.07, 1.14, 1.23, 1.31, 1.4, 1.5, 1.61, 1.72, 1.84, 1.97, 2.1, 2.25, 2.41, 2.58, 2.76, 2.95, 3.16, 3.38, 3.62]
    let priceIndexes: Array<Double> = [1, 1.1, 1.28, 1.55, 1.98, 2.65, 3.73, 5.52, 8.56, 13.9, 23.8, 42.8, 80.7, 160, 332, 725, 1663, 4001, 10111, 26826]
    
    init() {
        let hamsters = [
            Hamster(id: 0, isAvailable: true, name: "Default", description: "The standard skin of your league", price: 0),
            Hamster(id: 1, isAvailable: false, name: "Maxim", description: "Maxim is plump and good—natured, likes to cook and treat friends", price: 2500000),
            Hamster(id: 2, isAvailable: false, name: "Alexander", description: "Alexander is a businessman to the core, always busy with work and does not like to waste time", price: 2500000),
            Hamster(id: 3, isAvailable: false, name: "Mary", description: "Mary is a flight attendant with a charming smile, loves traveling and meeting new people", price: 2500000),
            Hamster(id: 4, isAvailable: false, name: "David", description: "David is an astronaut with a thirst for adventure, dreaming of exploring distant galaxies", price: 10000000),
            Hamster(id: 5, isAvailable: false, name: "Andrew", description: "Andrew is a detective with a sharp mind, always looking for new riddles and mysteries", price: 10000000),
            Hamster(id: 6, isAvailable: false, name: "Victoria", description: "Victoria is a pilot with a strong character, ready for any challenges in the air", price: 50000000),
            Hamster(id: 7, isAvailable: false, name: "Anna", description: "Anna is a policeman with a keen sense of justice, always standing guard over the law", price: 50000000)
        ]
        self.hamsters = hamsters
        
        self.professions = [
            Profession(id: 0, level: 0, tilte: "SEO", description: "Develop your management skills as a company founder. Improve your leadership skills. Attract the best people to your team", profit: 100, price: 1103, initialPrice: 1000, initialProfit: 100, totalProfit: 0),
            Profession(id: 1, level: 0, tilte: "Marketing", description: "Develop marketing channels and drivers to attract an audience. Test hypotheses and sales funnels", profit: 70, price: 1000, initialPrice: 1000, initialProfit: 70, totalProfit: 0),
            Profession(id: 2, level: 0, tilte: "IT Team", description: "Assemble and develop a great IT team. Implement the best processes and technologies", profit: 240, price: 2000, initialPrice: 2000, initialProfit: 240, totalProfit: 0),
            Profession(id: 3, level: 0, tilte: "Support team", description: "Helps users solve trade issues and queries", profit: 70, price: 750, initialPrice: 750, initialProfit: 70, totalProfit: 0),
            Profession(id: 4, level: 0, tilte: "HamsterBook", description: "Expand your exchange's presence on HamsterBook", profit: 70, price: 500, initialPrice: 500, initialProfit: 70, totalProfit: 0),
            Profession(id: 5, level: 0, tilte: "HamsterTube", description: "Increase the presence of your exchange on HumsterTube", profit: 80, price: 550, initialPrice: 550, initialProfit: 80, totalProfit: 0),
            Profession(id: 6, level: 0, tilte: "Х", description: "Increase the presence of your exchange on Twitter", profit: 80, price: 550, initialPrice: 550, initialProfit: 80, totalProfit: 0),
            Profession(id: 7, level: 0, tilte: "Cointelegraph", description: "Lvl 1", profit: 40, price: 350, initialPrice: 350, initialProfit: 40, totalProfit: 0)
        ]

        self.selectedHamster = hamsters[0]
        toNextDayTimer = secondsForNextDay()
    }
    
    func firstLaunchPrepares() {
        if firstLaunch {
            self.hamsters.forEach { hamster in
                localStorage.saveHamster(hamster)
            }
            self.professions.forEach { profession in
                localStorage.saveProfession(profession)
            }
            dayIndex = 0
            localStorage.editEnergyLevel(maxEnergy, energyLevel: maxEnergyLevel)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "dd.MM.yyyy.HH.mm"
            let dateString = dateFormatter.string(from: Date())
            localStorage.saveSavedDate(dateString)
            localStorage.editTapValue(1, tapValueLevel: 1)
            var numbersArray: Array<Int> = [0, 1, 2, 3, 4, 5, 6, 7]
            let first = Int.random(in: 0...7)
            combo.append((numbersArray[first], false))
            numbersArray.remove(at: first)
            let second = Int.random(in: 0...6)
            combo.append((numbersArray[second],false))
            numbersArray.remove(at: second)
            let third = Int.random(in: 0...5)
            combo.append((numbersArray[third],false))
            numbersArray.remove(at: third)
            localStorage.save(combo: combo)
        }
        firstLaunch = false
    }
    
    func setDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy.HH.mm"
        let dateString = dateFormatter.string(from: Date())
        self.dateString = dateString
    }
    
    func saveData() {
        setDate()
        localStorage.saveBalance(balance)
        localStorage.save(combo: combo)
        localStorage.saveSavedDate(dateString)
        localStorage.saveMiniGameTimer(miniGameReloadTimer)
        localStorage.saveEnergyFillRestoreTimer(energyTimer)
        localStorage.saveEnergy(energy)
        localStorage.saveBalance(balance)
        localStorage.saveDayIndex(dayIndex)
        localStorage.saveParameters(leagueId: leagueId, selectedHamsterId: selectedHamsterId)
    }
    
    func energyFillRestoreTimerCheck() {
        let offlineSeconds = secondsFromSavedDate()
        energyTimer = max(energyTimer - offlineSeconds, 0)
    }
    
    func energyCheck() {
        let offlineEnergy = secondsFromSavedDate() * 3
        energy = min(maxEnergy, energy + offlineEnergy)
    }
    
    func loadLocalData() {
        firstLaunchPrepares()
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            if let professionsCoreData = try? localStorage.fetchProfessions() {
                professionsCoreData.forEach { professionCoreData in
                    self.professions[Int(professionCoreData.id)].level = Int(professionCoreData.level)
                    self.professions[Int(professionCoreData.id)].totalProfit = Int(professionCoreData.totalProfit)
                    self.professions[Int(professionCoreData.id)].profit = Int(professionCoreData.profit)
                    self.professions[Int(professionCoreData.id)].price = Int(professionCoreData.price)
                }
            }
            if let hamstersCoreData = try? localStorage.fetchHamstersCoreData() {
                hamstersCoreData.forEach { hamsterCoreData in
                    self.hamsters[Int(hamsterCoreData.id)].isAvailable = hamsterCoreData.available
                }
            }
            if let savedDate = try? localStorage.fetchSavedDate() {
                self.dateString = savedDate
            }
            if let balance = try? localStorage.fetchBalance() {
                self.balance = balance
            }
            if let energy = try? localStorage.fetchEnergy() {
                self.energy = energy
            }
            if let miniGameReloadTimer = try? localStorage.fetchMiniGameTimer() {
                self.miniGameReloadTimer = miniGameReloadTimer
            }
            if let energyFillRestoreTimer = try? localStorage.fetchEnergyFillRestoreTimer() {
                self.energyTimer = energyFillRestoreTimer
            }
            if let dayIndex = try? localStorage.fetchDayIndex() {
                self.dayIndex = dayIndex
                print(dayIndex)
            }
            if let energyLevel = try? localStorage.fetchEnergyLevel() {
                self.maxEnergyLevel = Int(energyLevel.maxEnergyLevel)
                self.maxEnergy = Int(energyLevel.maxEnergy)
            }
            if let parameters = try? localStorage.fetchParameters() {
                self.leagueId = Int(parameters.leagueId)
                self.selectedHamsterId = Int(parameters.selectedHamsterId)
            }
            if let tapValue = try? localStorage.fetchTapValue() {
                self.tapValue = Int(tapValue.tapValue)
                self.tapValueLevel = Int(tapValue.tapValueLevel)
            }
            
            self.rewardPerHour = professions.map({ profession in
                profession.totalProfit
            }).reduce(0, +)
            self.getRewardPerHourInitial()
            
            energyFillRestoreTimerCheck()
            energyCheck()
            miniGameReloadTimerCheck()
            setEnergyLevelPrice()
            leagueCheck()
            checkSelectedHamsterId()
            dailyRewardInitialCheck()
            setTapValueLevelPrice()
            comboFillCheck()
            DispatchQueue.main.async {
                self.localDataLoaded = true
            }
        }
    }
    
    func comboFillCheck() {
        let dateStringSaved = self.dateString.components(separatedBy: ".")
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy.HH.mm"
        let dateString = dateFormatter.string(from: Date())
        let dateStringComponents = dateString.components(separatedBy: ".")
        guard let savedDate = stringToDate() else { return }
        if savedDate < Date() {
            if dateStringSaved[0] != dateStringComponents[0] ||
                dateStringSaved[1] != dateStringComponents[1] ||
                dateStringSaved[2] != dateStringComponents[2] {
                var numbersArray: Array<Int> = [0, 1, 2, 3, 4, 5, 6, 7]
                let first = Int.random(in: 0...7)
                combo.append((numbersArray[first] , false))
                numbersArray.remove(at: first)
                let second = Int.random(in: 0...6)
                combo.append((numbersArray[second] , false))
                numbersArray.remove(at: second)
                let third = Int.random(in: 0...5)
                combo.append((numbersArray[third] , false))
                numbersArray.remove(at: third)
                comboIssued = false
                localStorage.save(combo: combo)
            } else {
                if let comboCoreData = try? localStorage.fetchCombo() {
                    combo = comboCoreData
                }
            }
        }
    }
    
    func checkSelectedHamsterId() {
        selectedHamster = hamsters[selectedHamsterId]
    }
    
    func miniGameReloadTimerCheck() {
        let seconds = secondsFromSavedDate()
        let timer = miniGameReloadTimer
        if timer - seconds <= 0 {
            miniGameReloadTimer = 0
        } else {
            miniGameReloadTimer = timer - seconds
        }
    }
    
    func secondsFromSavedDate() -> Int {
        guard let savedDate = stringToDate() else { return 0 }
        return Date().seconds(from: savedDate)
    }
    
    func secondsForNextDay() -> Int {
        guard let nextDay = nextDay() else { return 0 }
        return nextDay.seconds(from: Date())
    }
    
    func nextDay() -> Date? {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        guard let tomorrow = tomorrow else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let tomorrowString = dateFormatter.string(from: tomorrow)
        
        let date = dateFormatter.date(from: tomorrowString)
        return date
    }
    
    func setTapValueLevelPrice() {
        tapValueLevelPrice = 1000
        for index in 1...tapValueLevel {
            tapValueLevelPrice *= index
        }
    }
    func setEnergyLevelPrice() {
        maxEnergyLevelPrice = 1000
        for index in 1...maxEnergyLevel {
            maxEnergyLevelPrice *= index
        }
    }
    
    func getRewardPerHourInitial() {
        guard let savedDate = stringToDate() else { return }
        let hours = Date().hour(from: savedDate)
        if hours > 0 {
            balance += hours * rewardPerHour
        }
    }
    
    func stringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy.HH.mm"
        let date = dateFormatter.date(from: dateString)
        if let date = date {
            return date
        } else { return nil }
    }
    
    func professionLevelUp(id: Int) {
        professions[id].totalProfit += professions[id].profit
        rewardPerHour += professions[id].profit
        balance -= professions[id].price
        professions[id].level += 1
        if professions[id].level < 20 {
            professions[id].profit = Int(Double(professions[id].initialProfit) * profitIndexes[professions[id].level])
            professions[id].price = Int(Double(professions[id].initialPrice) * priceIndexes[professions[id].level])
        }
        localStorage.editProfession(professions[id])
    }
    
    func tapValueLevelUp() {
        balance -= tapValueLevelPrice
        tapValue += 1
        tapValueLevel += 1
        tapValueLevelPrice *= 2
        localStorage.editTapValue(tapValue, tapValueLevel: tapValueLevel)
    }
    
    func maxEnergyLevelUp() {
        balance -= maxEnergyLevelPrice
        maxEnergy += 500
        maxEnergyLevel += 1
        maxEnergyLevelPrice *= 2
        localStorage.editEnergyLevel(maxEnergy, energyLevel: maxEnergyLevel)
    }
    
    func getValueForNewLeague() -> Int {
        switch leagueId {
        case 0: return 5000
        case 1: return 25000
        case 2: return 100000
        case 3: return 1000000
        case 4: return 2000000
        case 5: return 10000000
        case 6: return 50000000
        case 7: return 100000000
        case 8: return 1000000000
        case 9 : return 18000000000
        default: return -1
        }
    }
    
    func leagueCheck() {
        switch balance {
        case 0..<5000: leagueId = 0
        case 5000..<25000: leagueId = 1
        case 25000..<100000: leagueId = 2
        case 100000..<1000000: leagueId = 3
        case 1000000..<2000000: leagueId = 4
        case 2000000..<10000000: leagueId = 5
        case 10000000..<50000000: leagueId = 6
        case 50000000..<100000000: leagueId = 7
        case 100000000..<1000000000: leagueId = 8
        case 1000000000..<18000000000: leagueId = 9
        default: leagueId = 10
        }
        if leagueId > self.leagueId {
            self.leagueId = leagueId
        }
    }
    
    func imageTitleBy(id: Int) -> String {
        switch id {
        case 0: return ImageTitles.DefaultHamster.rawValue
        case 1: return ImageTitles.Maxim.rawValue
        case 2: return ImageTitles.Alexander.rawValue
        case 3: return ImageTitles.Mary.rawValue
        case 4: return ImageTitles.David.rawValue
        case 5: return ImageTitles.Andrew.rawValue
        case 6: return ImageTitles.Victoria.rawValue
        case 7: return ImageTitles.Anna.rawValue
        default:
            return ImageTitles.DefaultHamster.rawValue
        }
    }
    
    func professionImageTitle(id: Int) -> String {
        switch id {
        case 0: return ImageTitles.HamsterWithCar.rawValue
        case 1: return ImageTitles.HamsterWithLoudspeaker.rawValue
        case 2: return ImageTitles.ITHamster.rawValue
        case 3: return ImageTitles.HeadphonesHamster.rawValue
        case 4: return ImageTitles.HamsterBook.rawValue
        case 5: return professions[4].level < 5 ? ImageTitles.HamsterTube.rawValue : ImageTitles.HamsterTubeUnlocked.rawValue
        case 6: return ImageTitles.xHamster.rawValue
        case 7: return ImageTitles.CryptoHamster.rawValue
        default:
            return ImageTitles.HamsterWithCar.rawValue
        }
    }
    
    func professionImageTitleLarge(id: Int) -> String {
        switch id {
        case 0: return ImageTitles.HamsterWithCarLarge.rawValue
        case 1: return ImageTitles.HamsterWithLoudspeakerLarge.rawValue
        case 2: return ImageTitles.ITHamsterLarge.rawValue
        case 3: return ImageTitles.SupportHamsterLarge.rawValue
        case 4: return ImageTitles.HamsterBookLarge.rawValue
        case 5: return professions[4].level < 5 ? ImageTitles.HamsterTubeLarge.rawValue : ImageTitles.HamsterTubeUnlocked.rawValue
        case 6: return ImageTitles.xHamsterLarge.rawValue
        case 7: return ImageTitles.CryptoHamsterLarge.rawValue
        default:
            return ImageTitles.HamsterWithCar.rawValue
        }
    }
    
    func dailyRewardInitialCheck() {
        guard let savedDate = stringToDate() else { return }
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd.MM.yyyy.HH.mm"
        let dateString = dateFormatter.string(from: Date())
        let dateComponents = dateString.components(separatedBy: ".")
        let savedDateComponents = dateString.components(separatedBy: ".")
        dailyRewardDay = savedDateComponents[0]
        if currentDate > savedDate && dateComponents[0] != savedDateComponents[0] {
            increaseOrDropDayIndex(dateComponents[0])
        }
    }
    
    func getReward() {
        rewards[dayIndex].got = true
        balance += rewards[dayIndex].reward
    }
    
    func increaseOrDropDayIndex(_ day: String) {
        dailyRewardDay = day
        if !rewards[dayIndex].got || dayIndex == 9 {
            dayIndex = 0
            resetDailyRewards()
        } else {
            dayIndex += 1
        }
    }
    
    func resetDailyRewards() {
        for index in 0..<rewards.count {
            rewards[index].got = false
        }
    }
}

extension Date {
    func hour(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
