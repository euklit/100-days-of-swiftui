//
//  StatView.swift
//  DiceParadise
//
//  Created by Niklas Lieven on 27.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: ThrowCD.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]) var throwed: FetchedResults<ThrowCD>

    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                List {

                    ForEach(0 ..< self.throwed.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text("Total: \(self.throwed[index].total)")
                            HStack {
                                ForEach(0 ..< self.throwed[index].diceArray.count , id: \.self) { index2 in
                                    ZStack {
                                        Dices().getView(dice: self.throwed[index].diceArray[index2])
                                            .frame(width: geo.size.width / 12, height: geo.size.width / 12)
                                        Text("\(self.throwed[index].diceArray[index2].rolledNumber)")
                                            .font(.custom("Gill Sans", size: 18))
                                    }
                                    
                                }
                            }
                        }
                            
                    }
                }
            .navigationBarTitle("History")
            }
        }
    }

}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
