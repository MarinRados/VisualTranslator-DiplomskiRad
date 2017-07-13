//
//  Language.swift
//  VisualTranslator
//
//  Created by Marin Rados on 12/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation
import RealmSwift


class Language: Object {
    dynamic var name: String = ""
    dynamic var abrv: String = ""
    
    convenience init(name: String, abrv: String) {
        self.init()
        self.name = name
        self.abrv = abrv
    }
}
