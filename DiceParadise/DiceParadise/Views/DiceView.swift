//
//  DiceView.swift
//  DiceParadise
//
//  Created by Niklas Lieven on 31.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//

import SwiftUI

struct DiceView: View {
    let die: Die
    let widthAndHeight: CGFloat
    
    // used for sliding in
    @State private var viewAppeared = false
    
    
    var body: some View {
        ZStack {
            die.diceShape
                .shadow(radius: 6)
                .foregroundColor(die.diceColor)
            Text("\(die.currentEyes ?? die.maxEyes)")
                .font(.custom("Gill Sans", size: widthAndHeight / 2.8))
        }
        .offset(x: 0, y: viewAppeared ? 0 : -100)
        .frame(width: widthAndHeight, height: widthAndHeight)

        .onAppear{ self.viewAppeared = true }
        .animation(.default)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(die: Die.eightSidedDie, widthAndHeight: 10)
    }
}
