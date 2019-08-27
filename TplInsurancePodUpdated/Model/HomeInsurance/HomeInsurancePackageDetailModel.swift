//
//  HomeInsurancePackageDetailModel.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 06/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import Foundation
struct HomeInsurancePackageDetailModel : Codable {
    let packageType : String?
    let premium : String?
    let discountPremium : String?
    let shortDescription : String?
    let longDescription : String?
    
    enum CodingKeys: String, CodingKey {
        
        case packageType = "PackageType"
        case premium = "Premium"
        case discountPremium = "DiscountPremium"
        case shortDescription = "ShortDescription"
        case longDescription = "LongDescription"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        packageType = try values.decodeIfPresent(String.self, forKey: .packageType)
        premium = try values.decodeIfPresent(String.self, forKey: .premium)
        discountPremium = try values.decodeIfPresent(String.self, forKey: .discountPremium)
        shortDescription = try values.decodeIfPresent(String.self, forKey: .shortDescription)
        longDescription = try values.decodeIfPresent(String.self, forKey: .longDescription)
    }
    
    static func decodeJsonData(data: Data) -> [HomeInsurancePackageDetailModel]?{
        let decodeObject = try? JSONDecoder().decode([HomeInsurancePackageDetailModel].self, from: data)
        return decodeObject
    }
    
}
