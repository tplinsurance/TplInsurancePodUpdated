//
//  TravelPackageModel.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 27/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import Foundation
struct TravelPackageModel : Codable {
    let id : Int?
    let packageType : String?
    let package : String?
    let premium : String?
    let discountPremium : String?
    let shortDescription : String?
    let longDescription : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "Id"
        case packageType = "PackageType"
        case package = "Package"
        case premium = "Premium"
        case discountPremium = "DiscountPremium"
        case shortDescription = "ShortDescription"
        case longDescription = "LongDescription"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        packageType = try values.decodeIfPresent(String.self, forKey: .packageType)
        package = try values.decodeIfPresent(String.self, forKey: .package)
        premium = try values.decodeIfPresent(String.self, forKey: .premium)
        discountPremium = try values.decodeIfPresent(String.self, forKey: .discountPremium)
        shortDescription = try values.decodeIfPresent(String.self, forKey: .shortDescription)
        longDescription = try values.decodeIfPresent(String.self, forKey: .longDescription)
    }
    
    static func decodeJsonData(data: Data) -> [TravelPackageModel]? {
        let decodedObject = try? JSONDecoder().decode([TravelPackageModel].self, from: data)
        return decodedObject
    }
    
}
