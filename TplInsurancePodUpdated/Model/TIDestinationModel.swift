//
//  TIDestinationModel.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 18/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import Foundation
struct TIDestinationModel : Codable {
    let id : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "Id"
        case name = "Name"
    }
    
    init(with id:String, name:String) {
        self.id = id
        self.name = name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
    static func decodeJsonData(data: Data) -> [TIDestinationModel]? {
        let decodedObject = try? JSONDecoder().decode([TIDestinationModel].self, from: data)
        return decodedObject
    }
    
}


struct DestinationStruct {
    var id: String? = nil
    var name: String? = nil
    
    init(with id:String, name:String) {
        self.id = id
        self.name = name
    }
}

