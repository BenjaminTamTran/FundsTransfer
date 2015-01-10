//
//  Config.swift
//  FundsTransfer
//
//  Created by Tran Huu Tam on 1/11/15.
//  Copyright (c) 2015 BenjaminSoft. All rights reserved.
//

import Foundation
import UIKit

let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
let baseURL = "https://121.52.68.28:8243/cftest/0.0.1"
let bankListAction = "\(baseURL)/GetBankList"
let accountInfoAction = "\(baseURL)/GetAccountBalance"
let initTransferAction = "\(baseURL)/InitTransfer"
