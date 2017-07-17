//
//  RealmResults+Extensions.swift
//  VisualTranslator
//
//  Created by Marin Rados on 17/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    
    func toArray() -> [Object] {
        var array = [Object]()
        for result in self {
            array.append(result)
        }
        return array
    }
}
