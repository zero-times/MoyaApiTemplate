//
//  BaseApi.swift
//  EastApi
//
//  Created by Hoa on 2020/5/15.
//  Copyright © 2020 Hoa. All rights reserved.

import Foundation

public protocol BaseApi {
    
    var requestParams: [String: Any]? {
        get
    }
    
    var url: String? {
        get
    }
    
    var httpMethod: String? { get }
    
    var headerParams: [String: Any]? {
        get
    }
}

