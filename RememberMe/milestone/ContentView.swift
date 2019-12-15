//
//  ContentView.swift
//  milestone
//
//  Created by Niklas Lieven on 11.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var name = ""
    @Environment(\.managedObjectContext) var moc

    @State private var showingAddView = false
    @State private var showingNameInput = false
    
    @State private var persons = [Person]()
    
    var body: some View {
        NavigationView {
            List(persons.sorted(), id: \.name) { person in
                NavigationLink(destination: DetailView(person: person)) {
                    HStack {
                        Image(uiImage: loadImageData(data: person.imageData) ) 
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text(person.name)
                            .font(.title)
                    }
                }
                    
            }
            .sheet(isPresented: $showingAddView) {
                AddPersonView(persons: self.$persons)
            }
            .navigationBarItems(trailing: Button(action: { self.showingAddView.toggle() }) {
                Image(systemName: "person.badge.plus")
                .resizable()
                .scaledToFit()
                .frame(width: 30)

            })
            .navigationBarTitle(Text("Remember Me"))
            .onAppear(perform: loadData)
        }

        
    }


    func saveData() {
        do {
            let filename = getDocumetsDirectory().appendingPathComponent("persons")
            let data = try JSONEncoder().encode(self.persons)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("unable to save data")
        }
    }
    func loadData() {
        let filename = getDocumetsDirectory().appendingPathComponent("persons")
        
        do {
            let data = try Data(contentsOf: filename)
            persons = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            print("unable to load saved data")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
