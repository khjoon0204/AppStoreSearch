//
//  Util.swift
//  AppStoreSearch
//
//  Created by N17430 on 17/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import Foundation

enum CoreDataError: Error
{
  case CannotFetch(String)
  case CannotCreate(String)
  case CannotUpdate(String)
  case CannotDelete(String)
}

enum ApiError: Error
{ // TODO: 함수명으로 수정
  case parseJSON(String)
  case fetchSearch(String)
  case CannotUpdate(String)
  case CannotDelete(String)
}

func isNil( _ val: Any?) -> String{
    if let v = val as? String{return v}
    if let v = val as? NSNumber{return "\(v.intValue)"}
    return ""
}
