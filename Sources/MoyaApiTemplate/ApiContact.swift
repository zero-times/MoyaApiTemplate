//
//  ApiContact.swift
//  EastApi
//
//  Created by Hoa on 2020/5/4.
//  Copyright © 2020 Hoa. All rights reserved.
//

import Foundation

/**
 * Api Host 配置文件
 */
public enum ApiEnvironment: String {
    
    /**
     *开发环境
     *仅联机调试生效 配置Run 环境变量
    * Sechme -> Run -> Arguments -> Envionment Variables -> Add Name: DEVELOPER Value: http://192.168.x.x
     */
    case developer = "https://#"
    
    /**
     *测试环境
     *Other Swift Flags 配置 -D DEBUG
     */
    case debug = "https://debug.com"
    
    /**
     *生产环境
     *去掉Other Swift Flags 配置 -D DEBUG
     */
    case release = "https://release.com"
    
    static var current: ApiEnvironment {
        get {
            let dic = ProcessInfo.processInfo.environment
            if let developer = dic["DEVELOPER"] {
                developerURL = developer
                return .developer
            }
            #if DEBUG
                return .debug
            #else
                return .release
            #endif
        }
    }
    static var developerURL = ApiEnvironment.developer.rawValue
}

public var HOST: String {
    get {
        if ApiEnvironment.current == .developer {
            return ApiEnvironment.developerURL
        }
        else {
            return ApiEnvironment.current.rawValue
        }
    }
}

public var IMAGE_HOST: String {
    get {
        if ApiEnvironment.current == .release {
            return "https://image.release.com/"
        }
        else {
            return "https://image.com/"
        }
    }
}

public let API_VERSION = "/v1"

/**
 * Extension Key
 */
public var APPID: String {
    get {
        if ApiEnvironment.current == .release {
            return "4120201112088880"
        }
        else {
            return "6268614460592122"
        }
    }
}

public var SIGN_KEY: String {
    get {
        if ApiEnvironment.current == .release {
            return "KQNTRENAACUOSCMHSAMVBANWGASLGIJIAKQNNZFMONEIXOZIPQMSINVVEROGPZJT"
        }
        else {
            return "UZPBJWBPVWRWBXUKCBEXYJDGSISSVYZCBVTJRTGLUMGVRKMSDDTPGVWSKUOQACVW"
        }
    }
}
