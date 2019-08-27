//
//  familyData.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 27/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import Foundation
struct familyData {
    var name: String
    var dob: Date
    var cnic: String?
    var relation: String
}

struct City: Decodable {
    
    let Id: Int
    let Name: String
    
    static func decodeJsonData(data: Data) -> [City]? {
        let decodedObject = try? JSONDecoder().decode([City].self, from: data)
        return decodedObject
    }
}
