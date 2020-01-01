//
//  PlayView.swift
//  DiceParadise
//
//  Created by Niklas Lieven on 27.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//
import CoreData
import SwiftUI

struct PlayView: View {
    let dices: [Die] = Die.availableDice
    
    @State private var rowUpperBound = 1 // #rows in grid
    @State private var rotationAmount = 1.0


    @ObservedObject var myDices: Dices = Dices()
    
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                
                // MARK: dicepicker
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(0 ..< self.dices.count) { index in
                            DiceView(die: self.dices[index], widthAndHeight: geo.size.width / 5.5)
                            .blur(radius: geo.size.height > 670 ?
                                (self.myDices.activeDice.count == 12 ? 8 : 0) :
                                (self.myDices.activeDice.count == 9 ? 8 : 0)
                            )
                            .onTapGesture {
                                let newDice = self.dices[index]
                                
                                self.myDices.activeDice.append(newDice)
                                self.rowUpperBound = self.calcRowUpperBound()
                                
                            }
                            // on iP 8 or older max 3 rows, newer devices max 4 rows
                            .disabled(geo.size.height > 670 ?
                                self.myDices.activeDice.count == 12 : self.myDices.activeDice.count == 9)
                        }
                    }
                    .padding()
                }
                
                Divider()
                
                if self.myDices.activeDice.count == 0 {
                    Image(systemName: "arrow.up")
                        .resizable()
                    .scaledToFit()
                        .frame(width: geo.size.width / 5)
                    Text("Tap a dice to start")
                        .font(.title)
                    Text("Swipe from the right edge to see more dice.")
                        .font(.subheadline)
                }
                
                
                // MARK: grid
                VStack(spacing: 20) {
                    ForEach(0 ..< self.rowUpperBound, id: \.self) { row in
                        HStack(spacing: 20) {
                            ForEach(3 * row ..< self.calcColUpperBound(row), id: \.self) { index in
                                DiceView(die: self.myDices.activeDice[index], widthAndHeight: geo.size.width / 4)
                                    .rotationEffect(Angle(degrees: self.rotationAmount * 360 ))
                            }
                        }
    //                    .frame(height: geo.size.width / 3.5)
                    }
                }
                
                Spacer()
                
                
                Text("Total: \(self.myDices.score)")
                    .font(.title)
                

                // MARK: buttons
                HStack {
                    // Roll button
                    Button(action: {
                        withAnimation(.spring(dampingFraction: 0.55)) {
                            self.rotationAmount *= -1
                            
                            self.myDices.roll()
                            self.addToCoreData()
                        }
                        
                    }) {
                        Text("Roll")
                            .foregroundColor(.primary)
                            .frame(width: 2*geo.size.width / 3)
                            .padding(.vertical)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }.disabled(self.myDices.activeDice.count == 0)
                    
                    
                    // Clear button
                    Button(action: {
                        self.myDices.activeDice = []
                    }) {
                        Text("Clear")
                            .foregroundColor(.primary)
                            .padding()
                            .background(Color.red)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                
                Spacer().frame(height: 10)
                
            }
            

            
        }
    }
    
    func addToCoreData() {
        let currentThrow = ThrowCD(context: self.moc)
        currentThrow.date = Date()
        currentThrow.total = Int16(myDices.score)
        
        for index in 0..<myDices.activeDice.count {
            let dice = DiceCD(context: self.moc)
            dice.maxNumber = Int16(myDices.activeDice[index].maxEyes)
            dice.rolledNumber = Int16(myDices.activeDice[index].currentEyes!)
            currentThrow.addToDices(dice)
        }
        
        try? self.moc.save()
        

    }
    
    // MARK: grid functions
    func calcColUpperBound(_ row: Int) -> Int {
        if (myDices.activeDice.count - row * 3) >= 3 { // complete row (3 items)
            return 3 * row + 3
            
        } else {
            return 3 * row + myDices.activeDice.count % 3
        }
    }
    
    func calcRowUpperBound() -> Int {
        if self.myDices.activeDice.count % 3 == 0 {
            return Int(self.myDices.activeDice.count/3)
        } else {
            return Int(self.myDices.activeDice.count/3)+1
        }
    }

}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
