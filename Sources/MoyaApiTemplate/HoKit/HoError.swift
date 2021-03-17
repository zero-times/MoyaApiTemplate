//
//  HoError.swift
//  EastApi
//
//  Created by Hoa on 2020/4/19.
//  Copyright © 2020 Hoa. All rights reserved.
//

import Foundation
import HoUntils

public class HoError {
    
    private var error: String?
    public init(_ error: String?) {
        self.error = error
    }
    
    public init(_ data: Data) {
        self.jsonData = data
    }
    
    private var jsonData: Data!
    
    public func DebugLog(_ baseApi: BaseApi? = nil) {
        
        if isEnableDebugLogVC {
            let debugVC = HoDebugViewController.rootVC(jsonData, header: baseApi?.headerParams, requestParams: baseApi?.requestParams, requestUrl: baseApi?.url, method: baseApi?.httpMethod, title: debugVCTitle)
            if let topVC = debugVC.topViewController as? HoDebugViewController {
                topVC.jsonData = jsonData
            }
            
            if let jsonData = jsonData, let stringValue = String(data: jsonData, encoding: .utf8) {
                Log(stringValue)
            }
            
            DispatchQueue.main.async {
                HoController.current().present(debugVC, animated: true, completion: nil)
            }
        }
    }
    
    public var isEnableDebugLogVC: Bool {
        get {
            if ApiEnvironment.current == .release {
                return false
            }
            else {
                return true
            }
        }
    }
    
    public var debugVCTitle: String {
        get {
            if ApiEnvironment.current == .debug {
                return "测试版:异常信息"
            }
            else if ApiEnvironment.current == .developer {
                return "开发版[Baby Baby Baby ohh~]"
            }
            else {
                return "通用DEBUG:异常信息"
            }
        }
    }
}
