//
//  TIQuoteModel.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 24/12/2018.
//  Copyright © 2018 TPLHolding. All rights reserved.
//

import Foundation
struct TIQuoteModel : Codable {
    let quote_Id : Int?
    let customerName : String?
    let netPremium_Filer : String?
    let netPremium_NonFiler : String?
    let discount : String?
    let originalPremium : String?
    let package : String?
    
    enum CodingKeys: String, CodingKey {
        case quote_Id = "Quote_Id"
        case customerName = "CustomerName"
        case netPremium_Filer = "NetPremium_Filer"
        case netPremium_NonFiler = "NetPremium_NonFiler"
        case discount = "Discount"
        case originalPremium = "OriginalPremium"
        case package = "Package"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quote_Id = try values.decodeIfPresent(Int.self, forKey: .quote_Id)
        customerName = try values.decodeIfPresent(String.self, forKey: .customerName)
        netPremium_Filer = try values.decodeIfPresent(String.self, forKey: .netPremium_Filer)
        netPremium_NonFiler = try values.decodeIfPresent(String.self, forKey: .netPremium_NonFiler)
        discount = try values.decodeIfPresent(String.self, forKey: .discount)
        originalPremium = try values.decodeIfPresent(String.self, forKey: .originalPremium)
        package = try values.decodeIfPresent(String.self, forKey: .package)
    }
    
    static func decodeJsonData(data: Data) -> [TIQuoteModel]? {
        let decodedObject = try? JSONDecoder().decode([TIQuoteModel].self, from: data)
        return decodedObject
    }
    
    
}
