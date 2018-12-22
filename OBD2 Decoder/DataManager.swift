//
//  DataManager.swift
//  OBD2 Decoder
//
//  Created by Georgy Dyagilev on 22/12/2018.
//  Copyright © 2018 Georgy Dyagilev. All rights reserved.
//

import Foundation

class DataManager {
    
    func fetchDataFromFile(complition: @escaping ([OBDError]) -> Void) {
        guard let filePath = Bundle.main.url(forResource: "data", withExtension: "json") else { return }
        
        guard let data = try? Data(contentsOf: filePath) else { return }
        
        guard let results = try? JSONDecoder().decode([OBDError].self, from: data) else { return }
        
        complition(results)
    }
}
