//
//  MoyaApiTemplateApi.swift
//  EastApi
//
//  Created by Hoa on 2021/3/17.
//  Copyright © 2020 Hoa. All rights reserved.


import Foundation


import Foundation
import Moya
import UIKit
import HoUntils

public enum MoyaApiTemplateApi {
    
    /**
     * 登录
     */
    case login(params: [String: Any])

}
extension EastApi: TargetType {

    private var BaseURL: String {
        return HOST
    }
    
    public var baseURL: URL {
        return URL.init(string: BaseURL)!
    }
    
    var version: String {
        return API_VERSION
    }
    
    var suffix: String {
        switch self {
        case .login     : return "/login"
        }
    }
    
    public var path:String{
        return "/api\(version)\(suffix)"
    }
    
    public var headers: [String: String]? {
        let headerParams = [
            "content-type": "application/json",
        ]
        return headerParams
    }
    
    // 请求的参数
    var parameters: [String: Any]? {
        switch self {
        case
            let .login(params)
        : return params
        }
    }
    
    ///请求方式
    public var method: Moya.Method {
        switch self {
        case .login
            : return .post
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .login:
            return JSONEncoding.default
        }
    }
    
    /// Provides stub data for use in testing.
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    // MARK:task type
    public var task: Task {
        switch self {
//        case let .uploadFileToOss(_, type, files):
//            
//            guard let typeData = "\(type)".data(using: .utf8) else {
//                return .requestPlain
//            }
//            let typeFormData = MultipartFormData(provider: .data(typeData), name: "type")
//            
//            switch type {
//            case .image:
//                
//                var formDatas = files.enumerated().map {
//                    MultipartFormData(provider: .data($0.element), name: "files[\($0.offset)]", fileName: "\($0.offset).png", mimeType: "image/jpeg")
//                }
//                
//                formDatas.append(contentsOf: [typeFormData])
//                return .uploadMultipart(formDatas)
//            
//            case .video, .audio:
//                
//                var formDatas = files.enumerated().map {
//                    MultipartFormData(provider: .data($0.element), name: "files[\($0.offset)]", fileName: "\($0.offset).mp4", mimeType: "video/*")
//                }
//                
//                formDatas.append(contentsOf: [typeFormData])
//                return .uploadMultipart(formDatas)
//            }
//            
//        case .getUserLabel
//            : return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.default)
      
        case .login
            : return .requestParameters(parameters: parameters ?? [:], encoding: JSONEncoding.default)
        }
    }
}
extension EastApi: BaseApi {
    
    public var requestParams: [String : Any]? {
        parameters
    }
    
    public var url: String? {
        get {
            baseURL.absoluteString + path
        }
    }
    
    public var httpMethod: String? {
        get {
            self.method.rawValue
        }
    }
    
    public var headerParams: [String : Any]? {
        headers
    }
}
