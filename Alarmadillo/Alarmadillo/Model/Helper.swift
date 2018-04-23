//
//  Helper.swift
//  Alarmadillo
//
//  Created by Eric Rado on 4/22/18.
//  Copyright © 2018 Eric Rado. All rights reserved.
//

import Foundation

struct Helper {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        
        return documentsDirectory
    }
}
