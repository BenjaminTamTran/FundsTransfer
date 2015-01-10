//
//  Utility.swift
//  FundsTransfer
//
//  Created by Tran Huu Tam on 1/10/15.
//  Copyright (c) 2015 BenjaminSoft. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    class func showAlertWithMessage(message: String) {
        dispatch_async(dispatch_get_main_queue(),{
            var alert = UIAlertView(title: titleError, message: message, delegate: nil, cancelButtonTitle: titleOKBtn)
            alert.show()
        })
    }
    
    class func showAlertWithMessage(message: String, title: String) {
        dispatch_async(dispatch_get_main_queue(),{
            var alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: titleOKBtn)
            alert.show()
        })
    }
}