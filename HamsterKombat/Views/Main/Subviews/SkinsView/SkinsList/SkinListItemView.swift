import SwiftUI

struct SkinListItemView: View {
    
    let hamster: Hamster
    let isSelected: Bool
    let isDefault: Bool
    
    var body: some View {
        ZStack {
            Image(backgroundTitle())
                .resizable()
            if !hamster.isAvailable {
                Image(ImageTitles.HamsterListLock.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
            VStack {
                Image(imageTitleBy(id: hamster.id))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 75)
                TextCustom(text: hamster.name, size: 10, weight: .bold, color: .white)
            }
        }
        .frame(width: 83, height: 113)
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 3))
        .overlay(
            checkmark()
            ,alignment: .topTrailing
        )
    }
    
    @ViewBuilder func checkmark() -> some View {
        if isDefault {
            Image(ImageTitles.checkMarkFilled.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
                .background(
                    Circle()
                        .fill(LinearGradient(colors: [.checkmarkGradientTop, .checkmarkGradientBottom], startPoint: .top, endPoint: .bottom))
                        .shadow(color: .black.opacity(0.25), radius: 4, y: 4)
                )
        } else {
            EmptyView()
        }
    }
    
    func backgroundTitle() -> String {
        isSelected ? ImageTitles.HamsterListSelectedBackground.rawValue : ImageTitles.HamsterListBackground.rawValue
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

#Preview {
    SkinListItemView(hamster: Hamster(id: 0, isAvailable: true, name: "Default", description: "Standart hamster", price: 0), isSelected: false, isDefault: false)
}
