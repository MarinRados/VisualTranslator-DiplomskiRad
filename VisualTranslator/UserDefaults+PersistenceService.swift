//
//  UserDefaults+PersistenceService.swift
//  VisualTranslator
//
//  Created by Marin Rados on 12/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation


protocol PersistenceServiceProtocol {
    var currentLanguage: Language? { get set }
    var totalScore: Int { get set }
}

private extension Language {
    convenience init?(dictionary: [String: Any]) {
        guard
            let abrv = dictionary["abrv"] as? String,
            let name = dictionary["name"] as? String
            else {
                return nil
        }
        
        self.init()
        self.name = name
        self.abrv = abrv
    }
    
    var asDictionary: [String: Any] {
        return ["name": name,
                "abrv": abrv
        ]
    }
    
}

extension UserDefaults: PersistenceServiceProtocol {
    var currentLanguage: Language? {
        get {
            if let languageDictionary = object(forKey: "currentLanguage") as? [String: Any] {
                return Language(dictionary: languageDictionary)
            } else {
                return Language(name: "German", abrv: "de")
            }
        } set {
            set(newValue?.asDictionary, forKey: "currentLanguage")
        }
    }
    
    var totalScore: Int {
        get {
            return integer(forKey: "totalScore")
        } set {
            set(newValue, forKey: "totalScore")
        }
    }
}
