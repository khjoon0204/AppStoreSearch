//
//  Search.swift
//  AppStoreSearch
//
//  Created by N17430 on 17/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import Foundation
import RxSwift
import struct Foundation.URL

struct Search {
    let result:[String:Any] // results 에서 아이템 하나

    static func parseJSON(_ json: [String:Any]) throws -> [Search] {
        guard let res = json["results"] as? [[String:Any]] else { return [] }
        return res.map { r -> Search in
            return Search(result: r)
        }
    }
}
