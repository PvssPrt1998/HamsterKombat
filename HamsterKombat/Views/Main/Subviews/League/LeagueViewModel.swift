import Foundation
import Combine

final class LeagueViewModel: ObservableObject {
    
    @Published var dataManager: DataManager
    
    @Published var leagueId: Int
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
    
    private var leagueIdCancellable: AnyCancellable?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        leagueId = dataManager.leagueId
        leagueIdCancellable = dataManager.$leagueId.sink { [weak self] value in
            self?.leagueId = value
        }
    }
}
