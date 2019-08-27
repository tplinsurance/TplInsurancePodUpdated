//
//  TIGetRelationshipModel.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 08/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import Foundation
struct TIGetRelationshipModel : Codable {
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "Id"
        case name = "Name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
    static func decodeJsonData(data: Data) -> [TIGetRelationshipModel]? {
        let decodedObject = try? JSONDecoder().decode([TIGetRelationshipModel].self, from: data)
        return decodedObject
    }
    
}
