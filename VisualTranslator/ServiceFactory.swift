//
//  ServiceFactory.swift
//  VisualTranslator
//
//  Created by Marin Rados on 12/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation


protocol ServiceFactoryProtocol {
    var persistenceService: PersistenceServiceProtocol { get }
}

enum ServiceLocator {
    static let factory: ServiceFactory = ServiceFactory()
}

struct ServiceFactory: ServiceFactoryProtocol {
    
    var persistenceService: PersistenceServiceProtocol {
        return UserDefaults.standard
    }
}
