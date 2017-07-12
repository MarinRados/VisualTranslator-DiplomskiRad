//
//  BaseCoordinator.swift
//  VisualTranslator
//
//  Created by Marin Rados on 06/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation
import UIKit

public protocol Coordinator: class {
    
    @discardableResult
    func start() -> UIViewController
}

class NavCoordinator {
    
    let serviceFactory = ServiceLocator.factory
}
