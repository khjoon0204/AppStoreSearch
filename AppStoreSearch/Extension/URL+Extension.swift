//
//  URL+Extension.swift
//  AppStoreSearch
//
//  Created by N17430 on 20/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import Foundation
import UIKit

extension URL{
    func loadURLImage(completion: @escaping ((Data, UIImage) -> ())) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: self) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(data, image)
                    }
                }
            }
        }
    }
     
}
