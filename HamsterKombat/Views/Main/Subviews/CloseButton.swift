//
//  CloseButton.swift
//  HamsterKombat
//
//  Created by Николай Щербаков on 11.08.2024.
//

import SwiftUI

struct CloseButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .scaledToFit()
                .foregroundColorCustom(.black)
                .padding(11)
                .frame(width: 36, height: 36)
                .background(Circle().fill(Color.bgTab))
        }
    }
}

#Preview {
    CloseButton(action: {})
}
