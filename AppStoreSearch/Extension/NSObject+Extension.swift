//
//  NSObject+Extension.swift
//  AppStoreSearch
//
//  Created by N17430 on 19/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

extension NSObject{

    func loadURLImage(url: URL, completion: @escaping ((Data, UIImage) -> ())) {
        DispatchQueue.global().async { [weak self] in // strong circular retain 막기 위함
            if let data = try? Data(contentsOf: url) { // TODO: - 데이터 가져오는지 test
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(data, image)
                    }
                }
            }
        }
    }
    
//    func loadURLImage(url: URL, completion: @escaping ((Observable<DownloadableImage>, Data, UIImage) -> ())) {
//        DispatchQueue.global().async { [weak self] in // strong circular retain 막기 위함
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        let obs = Observable.of(image)
//                            .map { DownloadableImage.content(image: $0) }
//                            .startWith(.content(image: UIImage()))
//                        completion(obs, data, image)
//                    }
//                }
//            }
//        }
//        
//    }
    
}
