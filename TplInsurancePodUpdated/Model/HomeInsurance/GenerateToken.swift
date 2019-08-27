//
//  GenerateToken.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 11/03/2019.
//  Copyright © 2019 TPLHolding. All rights reserved.
//

import Foundation
class GenerateToken: Decodable{
    
    var Token: String

    static func decodeJsonData(data: Data) -> GenerateToken? {
        let decodedObject = try? JSONDecoder().decode(GenerateToken.self, from: data)
        return decodedObject
    }
    
}
