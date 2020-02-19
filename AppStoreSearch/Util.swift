//
//  Util.swift
//  AppStoreSearch
//
//  Created by N17430 on 17/02/2020.
//  Copyright © 2020 hjoon. All rights reserved.
//

import Foundation

// MARK: - Error
/// handler 용 type 정의
typealias CoreDataErrorCompletionHandler = (CoreDataError) -> Void
typealias ApiErrorCompletionHandler = (ApiError) -> Void

enum CoreDataError: Error
{
    case CannotFetch(String)
    case CannotCreate(String)
    case CannotUpdate(String)
    case CannotDelete(String)
    
}

enum ApiError: Error
{
    case parseJSON(String)
    case fetchSearch(String)
}


// MARK: - Util
func isStr( _ val: Any?) -> String{
    if let v = val as? String{return v}
    if let v = val as? NSNumber{return "\(v.intValue)"}
    return ""
}

func isInt( _ val: Any?) -> Int{
    if let v = val as? NSNumber{return v.intValue}
    return -1
}
