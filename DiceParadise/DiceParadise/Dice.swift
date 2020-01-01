//
//  Dice.swift
//  DiceParadise
//
//  Created by Niklas Lieven on 29.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//

import Foundation
import SwiftUI

struct Die {
//    let id = UUID() // problems with ForEach when its not identifiable
    let maxEyes: Int
    var currentEyes: Int?
    let diceShape: AnyView
    let diceColor: Color
    
    static let fourSidedDie = Die(maxEyes: 4, diceShape: AnyView(Triangle()), diceColor: .blue)
    static let sixSidedDie = Die(maxEyes: 6, diceShape: AnyView(Rectangle()), diceColor: .red)
    static let eightSidedDie = Die(maxEyes: 8, diceShape: AnyView(Triangle().rotationEffect(Angle(degrees: 180))), diceColor: .green)
    static let tenSidedDie = Die(maxEyes: 10, diceShape: AnyView(Kite()), diceColor: .purple)
    static let twelveSidedDie = Die(maxEyes: 12, diceShape: AnyView(Pentagon()), diceColor: .orange)
    static let twentySidedDie = Die(maxEyes: 20, diceShape: AnyView(Triangle().rotationEffect(Angle(degrees: 180))), diceColor: .pink)
    
    static let availableDice = [fourSidedDie, sixSidedDie, eightSidedDie, tenSidedDie, twelveSidedDie, twentySidedDie]
    
}

class Dices: ObservableObject {
    @Published var activeDice: [Die] = []
    var score: Int {
        var score = 0
        for dice in activeDice {
            score += dice.currentEyes ?? 0
        }
        return score
    }
    
    init(){}
    
    func roll() {
        for index in 0..<activeDice.count {
            activeDice[index].currentEyes = Int.random(in: 1 ... activeDice[index].maxEyes)
        }
    }
    
    func getView(dice: DiceCD) -> AnyView {
        let rolledNumber = dice.maxNumber
        switch rolledNumber {
        case 4:
            return AnyView(Triangle().foregroundColor(.blue))
        case 6:
            return AnyView(Rectangle().foregroundColor(.red))
        case 8:
            return AnyView(Triangle().rotationEffect(Angle(degrees: 180)).foregroundColor(.green))
        case 10:
            return AnyView(Kite().foregroundColor(.purple))
        case 12:
            return AnyView(Pentagon().foregroundColor(.orange))
        case 20:
            return AnyView(Triangle().rotationEffect(Angle(degrees: 180)).foregroundColor(.pink))
        default:
            return AnyView(Triangle().foregroundColor(.pink))
        }
    }
    

    
}
