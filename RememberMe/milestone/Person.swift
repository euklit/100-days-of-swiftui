//
//  Person.swift
//  milestone
//
//  Created by Niklas Lieven on 11.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//

import Foundation
import SwiftUI
import CoreLocation

struct Person: Codable, Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    var imageData: Data
    var name = ""
    var mail = ""
    var latitude: Double?
    var longitude: Double?
}

func loadImageData(data: Data) -> UIImage {
    return UIImage(data: data)!
}


//class CodableImage:  UIImage, Codable {
//    enum CodingKeys: CodingKey {
//        case image
//    }
//    override init() {
//        super.init()
//    }
//
//    public required init(from decoder: Decoder) throws {
//        super.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        avatar = try container.decode(UIImage.self, forKey: .image)
//    }
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(
//    }
//
//}
