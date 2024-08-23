import SwiftUI

@main
struct HamsterKombatApp: App {
    
    let viewModelFactory: ViewModelFactory
    @ObservedObject var coordinator: Coordinator
    
    init() {
        viewModelFactory = ViewModelFactory()
        coordinator = Coordinator(viewModelFactory: viewModelFactory)
    }
    
    var body: some Scene {
        WindowGroup {
            coordinator.build()
                .environmentObject(viewModelFactory)
        }
    }
}
