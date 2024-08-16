import Foundation

final class DataManager: ObservableObject {
    
    @Published var hamsters: Array<Hamster> = [
        Hamster(id: 0, isAvailable: true, name: "Default", description: "The standard skin of your league", price: 0),
        Hamster(id: 1, isAvailable: false, name: "Maxim", description: "Maxim is plump and good—natured, likes to cook and treat friends", price: 2500000),
        Hamster(id: 2, isAvailable: false, name: "Alexander", description: "Alexander is a businessman to the core, always busy with work and does not like to waste time", price: 2500000),
        Hamster(id: 3, isAvailable: false, name: "Mary", description: "Mary is a flight attendant with a charming smile, loves traveling and meeting new people", price: 2500000),
        Hamster(id: 4, isAvailable: false, name: "David", description: "David is an astronaut with a thirst for adventure, dreaming of exploring distant galaxies", price: 10000000),
        Hamster(id: 5, isAvailable: false, name: "Andrew", description: "Andrew is a detective with a sharp mind, always looking for new riddles and mysteries", price: 10000000),
        Hamster(id: 6, isAvailable: false, name: "Victoria", description: "Victoria is a pilot with a strong character, ready for any challenges in the air", price: 50000000),
        Hamster(id: 7, isAvailable: false, name: "Anna", description: "Anna is a policeman with a keen sense of justice, always standing guard over the law", price: 50000000)
    ]
    
    var selectedHamster: Hamster {
        hamsters[0]
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
}
