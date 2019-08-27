//
//  GetAmountOfPolicyModel.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 11/03/2019.
//  Copyright © 2019 TPLHolding. All rights reserved.
//

import Foundation

class GetAmountOfPolicyModel: Decodable{
    
    var Msg: String
    var Result: String
    var Status: String

    
    static func decodeJsonData(data: Data) -> GetAmountOfPolicyModel? {
        let decodedObject = try? JSONDecoder().decode(GetAmountOfPolicyModel.self, from: data)
        return decodedObject
    }
    
}
