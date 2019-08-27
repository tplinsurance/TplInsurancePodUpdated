//
//  InsuranceProposalModel.swift
//  TPLInsurance
//
//  Created by Tahir Raza on 12/03/2019.
//  Copyright © 2019 TPLHolding. All rights reserved.
//

import Foundation
struct InsuranceProposalModel: Decodable{
    
    var OrderID: String?
    var Result: String?
    var Premium: String?
    
    static func decodeJsonData(data: Data) -> [InsuranceProposalModel]? {
        let decodedObject = try? JSONDecoder().decode([InsuranceProposalModel].self, from: data)
        return decodedObject
    }
    
}
