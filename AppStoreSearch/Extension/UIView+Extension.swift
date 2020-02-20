//
//  UIView+Extension.swift
//  AppStoreSearch
//
//  Created by N17430 on 20/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func pinToParent(){
        guard let p = self.superview else { return }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: p.topAnchor),
            self.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: p.bottomAnchor)])
    }
}
