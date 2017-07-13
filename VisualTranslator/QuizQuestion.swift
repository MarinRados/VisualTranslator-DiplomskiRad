//
//  QuizQuestion.swift
//  VisualTranslator
//
//  Created by Marin Rados on 13/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class QuizQuestion: Object {
    dynamic var originalText = ""
    dynamic var translatedText = ""
    dynamic var image: UIImage?
    dynamic var language: Language?
}
