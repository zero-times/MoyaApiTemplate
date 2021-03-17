//
//  HoErrorNotificationer.swift
//  EastApi
//
//  Created by Hoa on 2020/7/17.
//  Copyright © 2021 Hoa. All rights reserved.
//

import Foundation
import HoUntils

public class HoErrorNotification: HoNotificationer {
   public enum HoNotification: String {
        /**
         *token验证异常
         */
        case tokenVerifyFaild
        
        /**
         *token已失效
         */
        case tokenExpired
        
        /**
         *禁止游客访问
         */
        case refuseGuest
   }
}
