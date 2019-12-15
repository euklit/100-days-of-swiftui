//
//  FileManagement.swift
//  milestone
//
//  Created by Niklas Lieven on 13.12.19.
//  Copyright © 2019 euklit. All rights reserved.
//

import Foundation

func getDocumetsDirectory() -> URL {
    // find all possile document directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    //just send back the first one which ought to be the only one
    return paths[0]
}
