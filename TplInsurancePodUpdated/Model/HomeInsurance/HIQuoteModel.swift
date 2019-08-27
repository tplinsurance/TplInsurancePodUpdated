//
//  HIQuoteModel.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 07/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import Foundation
struct HIQuoteModel : Codable {
    let originalPremium : String?
    let discount : String?
    let netPremium_Filer : String?
    let netPremium_NonFiler : String?
    let quoteId : Int?
    let package : String?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        
        case originalPremium = "OriginalPremium"
        case discount = "Discount"
        case netPremium_Filer = "NetPremium_Filer"
        case netPremium_NonFiler = "NetPremium_NonFiler"
        case quoteId = "QuoteId"
        case package = "Package"
        case message = "Message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        originalPremium = try values.decodeIfPresent(String.self, forKey: .originalPremium)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        netPremium_Filer = try values.decodeIfPresent(String.self, forKey: .netPremium_Filer)
        netPremium_NonFiler = try values.decodeIfPresent(String.self, forKey: .netPremium_NonFiler)
        quoteId = try values.decodeIfPresent(Int.self, forKey: .quoteId)
        package = try values.decodeIfPresent(String.self, forKey: .package)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
    static func decodeJsonData(data: Data) -> [HIQuoteModel]?{
        let decodeObject = try? JSONDecoder().decode([HIQuoteModel].self, from: data)
        return decodeObject
    }
    
}
