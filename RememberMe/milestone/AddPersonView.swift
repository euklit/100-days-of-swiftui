//
//  AddPersonView.swift
//  milestone
//
//  Created by Niklas Lieven on 11.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//

import SwiftUI
import CoreLocation

struct AddPersonView: View {
    @Binding var persons: [Person]
    
    let locationFetcher = LocationFetcher()
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var name = ""
    @State private var mail = ""
    
    @State private var toggleIsOn = false
    @State private var showingActionSheet = false
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                Form {
                    
                    Section() {
                        TextField("Name", text: self.$name)
                        TextField("E-Mail", text: self.$mail)
                            .keyboardType(.emailAddress)
                    }

                    
                    Section() {
                        Button(action: { self.showingActionSheet = true }) {
                            HStack {
                                Image(systemName: "camera")
                                Text("Tap to select a photo")
                            }
                        }
                        
                        if self.inputImage != nil { // show picked photo
                            Image(uiImage: self.inputImage!) // we checked that its not nil so it's okay to force unwrap
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.3)
                                .clipShape(Circle())
                        }
                        
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                                  
                            
                    Section(footer: Text("The saved location is based on your current location")){
                        Toggle(isOn: self.$toggleIsOn) {
                            Text("Save location where you met this person")
                        }
                    }
                }
                    
                    
                }
                .navigationBarTitle(Text("Add new contact"))
                .navigationBarItems(trailing:
                    Button("Save"){
                        if let jpegData = self.inputImage?.jpegData(compressionQuality: 0.8){
                            if self.toggleIsOn { // save person with location
                                let newPerson = Person(imageData: jpegData, name: self.name, mail: self.mail, latitude: self.locationFetcher.lastKnownLocation?.latitude, longitude: self.locationFetcher.lastKnownLocation?.longitude)
                                self.persons.append(newPerson)
                            } else { // save person without location
                                let newPerson = Person(imageData: jpegData, name: self.name, mail: self.mail)
                                self.persons.append(newPerson)
                            }
                            
                        }
                    
                        self.presentationMode.wrappedValue.dismiss()
                        self.saveData()
                    }
                    .disabled(self.name != "" && self.inputImage != nil ? false : true))
            }
        .onAppear(perform: locationFetcher.start)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$inputImage, sourceType: self.sourceType)
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Take a photo or pick one from your libary"), buttons: [
                .default(Text("Camera")) {
                    self.sourceType = .camera
                    self.showingImagePicker = true
                },
                .default(Text("Photo Libary")) {
                    self.sourceType = .photoLibrary
                    self.showingImagePicker = true
                },
                .cancel()
            ])
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
        func setLocation() {
            
        }
}

struct AddPersonView_Previews: PreviewProvider {
    @State static var personas = [Person(imageData: (UIImage(systemName: "plus")?.jpegData(compressionQuality: 0.1))! , name: "heino")]
    static var previews: some View {
        AddPersonView(persons: $personas)
    }
}
