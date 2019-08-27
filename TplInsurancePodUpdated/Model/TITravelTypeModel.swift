//
//  TITravelTypeModel.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 08/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import Foundation
struct TITravelTypeModel : Codable {
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
    static func decodeJsonData(data: Data) -> [TITravelTypeModel]? {
        let decodedObject = try? JSONDecoder().decode([TITravelTypeModel].self, from: data)
        return decodedObject
    }
    
}
