//
//  homeInsuranceModel.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 06/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import Foundation
struct homeInsuranceModel : Codable {
    let value : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case value = "Value"
        case name = "Name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
    static func decodeJsonData(data: Data) -> [homeInsuranceModel]? {
        let decodedObject = try? JSONDecoder().decode([homeInsuranceModel].self, from: data)
        return decodedObject
    }
    
}
