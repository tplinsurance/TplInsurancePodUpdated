//
//  Area.swift
//  TplInsurancTesting
//
//  Created by Tahir Raza on 31/07/2019.
//  Copyright © 2019 Mohammed Ahsan. All rights reserved.
//

import Foundation
struct Area: Decodable {
    
    let Id: Int
    let Name: String
    
    static func decodeJsonData(data: Data) -> [Area]? {
        let decodedObject = try? JSONDecoder().decode([Area].self, from: data)
        return decodedObject
    }
}
