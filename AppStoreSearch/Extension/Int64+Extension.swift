//
//  Int64+Extension.swift
//  AppStoreSearch
//
//  Created by N17430 on 20/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import Foundation
extension Int64{
    func toMB() -> String{
        let fileSizeWithUnit = ByteCountFormatter.string(fromByteCount: self, countStyle: .file)
        return fileSizeWithUnit
    }
}
