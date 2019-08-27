//
//  TIAgeSlabModel.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 13/05/2019.
//  Copyright © 2019 TPLHolding. All rights reserved.
//

import Foundation
import Foundation
struct TIAgeSlabModel : Codable {
    let band : String?
    let bandValues : String?
    
    enum CodingKeys: String, CodingKey {
        case band = "Bands"
        case bandValues = "BandValues"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        band = try values.decodeIfPresent(String.self, forKey: .band)
        bandValues = try values.decodeIfPresent(String.self, forKey: .bandValues)
    }
    
    static func decodeJsonData(data: Data) -> [TIAgeSlabModel]? {
        let decodedObject = try? JSONDecoder().decode([TIAgeSlabModel].self, from: data)
        return decodedObject
    }
    
}
