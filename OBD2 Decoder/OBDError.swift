//
//  OBDError.swift
//  OBD2 Decoder
//
//  Created by Georgy Dyagilev on 22/12/2018.
//  Copyright © 2018 Georgy Dyagilev. All rights reserved.
//

import Foundation

struct OBDError: Codable {
    var code: String
    var englishDescription: String
    var russianDescription: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case englishDescription = "eng_desc"
        case russianDescription = "rus_desc"
    }
    
    init?(code: String, englishDescription: String, russianDescription: String) {
        self.code = code
        self.englishDescription = englishDescription
        self.russianDescription = russianDescription
    }
}
