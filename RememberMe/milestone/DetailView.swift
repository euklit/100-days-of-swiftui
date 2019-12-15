//
//  DetailView.swift
//  milestone
//
//  Created by Niklas Lieven on 13.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//

import SwiftUI
import MapKit

struct DetailView: View {
//    @Binding var person: Person
    var person: Person
    var body: some View {
            GeometryReader { geometry in
                VStack {
                    Image(uiImage: loadImageData(data: self.person.imageData))
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.8)
                        .clipShape(Circle())
                    Text(self.person.name)
                        .font(.title)
                    
                    if self.person.mail != "" {
                        HStack {
                            Image(systemName: "envelope")
                                .resizable()
                                .scaledToFit()

                                .frame(width: 30)
                            Text(self.person.mail)
                                .font(.headline)
                        }
                    }
                    
                    Spacer()
                    if self.person.latitude != nil {
                        Text("You got to know \(self.person.name) here")
                            .font(.footnote)
                        
                        MapView(person: self.person)
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.3)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                
            }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var personas = Person(imageData: (UIImage(systemName: "plus")?.jpegData(compressionQuality: 0.1))! , name: "heino")
    
    static var previews: some View {
        DetailView(person: personas)
    }
}
