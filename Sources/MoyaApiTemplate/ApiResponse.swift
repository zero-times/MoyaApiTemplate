 //
//  ApiResponse.swift
//  EastApi
//
//  Created by Hoa on 2020/5/4.
//  Copyright © 2020 Hoa. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

public enum ApiResponseCode: Int {
    
    /**
     *成功回调
     */
    case success = 0
    
    /**
     *token验证异常
     */
    case tokenVerifyFaild = 7
    
    /**
     *token已失效
     */
    case tokenExpired = 8
    
    /**
     *禁止游客访问
     */
    case refuseGuest = 88
    
}


public class ApiResponse {
    
    var result: Result<Moya.Response, MoyaError>! = nil
    var baseApi: BaseApi?
    
    public init(result: Result<Moya.Response, MoyaError>!, baseApi: BaseApi) {
        self.result = result
        self.baseApi = baseApi
    }
    
    /**
     *data: String
     */
    public var stringValue: String? {
        get {
            switch result {
            case let .success(res):
                if
                    let responseData = try? JSON(data: res.data),
                    let stringValue = responseData["data"].string
                {
                    return stringValue
                }
                else {
                    HoError(res.data).DebugLog(baseApi)
                }
            default: break
            }
            return nil
        }
    }
    
    /**
     *data: String
     */
    public var responseDictionaryObject: [String: Any]? {
        get {
            switch result {
            case let .success(res):
                if
                    let responseData = try? JSON(data: res.data),
                    let dictionaryObject = responseData.dictionaryObject
                {
                    return dictionaryObject
                }
                else {
                    HoError(res.data).DebugLog(baseApi)
                }
            default: break
            }
            return nil
        }
    }
    
    /**
     *data: Int
     */
    public var intValue: Int? {
        get {
            switch result {
            case let .success(res):
                if
                    let responseData = try? JSON(data: res.data),
                    let intValue = responseData["code"].int
                {
                    return intValue
                }
                else {
                    HoError(res.data).DebugLog(baseApi)
                }
            default: break
            }
            return nil
        }
    }
    
    /**
     *提示信息
     */
    public var message: String? {
        get {
            switch result {
            case let .success(res):
                if
                    let responseData = try? JSON(data: res.data),
                    let message = responseData["message"].string
                {
                    return message
                }
                else {
                    HoError(res.data).DebugLog(baseApi)
                }
            default: break
            }
            return nil
        }
    }
    
    /**
     *提示code
     */
    public var code: Int? {
        get {
            switch result {
            case let .success(res):
                if
                    let responseData = try? JSON(data: res.data),
                    let code = responseData["code"].int
                {
                    return code
                }
                else {
                    HoError(res.data).DebugLog(baseApi)
                }
            default: break
            }
            return nil
        }
    }
    
    /**
     *成功 code == 0
     */
    public var success: Bool {
        get {
            switch result {
            case let .success(res):
                if
                    let responseData = try? JSON(data: res.data),
                    let code = responseData["code"].int,
                    let responseCode = ApiResponseCode.init(rawValue: code)
                {
                    switch responseCode {
                    case .success: return true
                    case .refuseGuest:
                        DispatchQueue.main.async {
                            HoErrorNotification.post(notification: .refuseGuest)
                        }
                        return false
                    case .tokenExpired:
                        DispatchQueue.main.async {
                            HoErrorNotification.post(notification: .tokenExpired)
                        }
                        return false
                    case .tokenVerifyFaild:
                        DispatchQueue.main.async {
                            HoErrorNotification.post(notification: .tokenVerifyFaild)
                        }
                        return false
                    }
                }
                else {
                    HoError(res.data).DebugLog(baseApi)
                    return false
                }
            case let .failure(err):
                HoError(err.errorDescription ?? "").DebugLog(baseApi)
                return false
            case .none:
                return false
            }
        }
    }
    
    /**
     *字典对象
     */
    public var dictionaryObject: [String: Any]? {
        get {
            switch result {
            case let .success(res):
                if success, let responseData = try? JSON(data: res.data)
                {
                    if let dictionaryObject = responseData["data"].dictionaryObject {
                        return dictionaryObject
                    }
                }
            default: break
            }
            return nil
        }
    }
    
    /**
     *字典对象
     */
    public var dictionary: [String: JSON]? {
        get {
            switch result {
            case let .success(res):
                if success, let responseData = try? JSON(data: res.data)
                {
                    if let dictionaryObject = responseData["data"].dictionary {
                        return dictionaryObject
                    }
                }
            default: break
            }
            return nil
        }
    }
    
    /**
     *数组对象
     */
    public var arrayObject: [Any]?  {
        get {
            switch result {
            case let .success(res):
                if success, let responseData = try? JSON(data: res.data)
                {
                    if let arrayObject = responseData["data"].arrayObject {
                        return arrayObject
                    }
                }
            default: break
            }
            return nil
        }
    }
    
    /**
     *字符串
     */
    public var stringObject: String? {
       get {
            switch result {
            case let .success(res):
                 HoError(res.data).DebugLog(baseApi)
            default: break
            }
            return nil
        }
    }
    
}
