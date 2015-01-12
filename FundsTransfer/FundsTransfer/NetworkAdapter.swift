//
//  NetworkAdapter.swift
//  FundsTransfer
//
//  Created by Tran Huu Tam on 1/10/15.
//  Copyright (c) 2015 BenjaminSoft. All rights reserved.
//

import Foundation
import UIKit

class NetworkAdapter: NSObject {
    
    // MARK: Class's constructors
    override init() {
        super.init()
    }
    
    // MARK: Class's public methods
    func callWSWithMethodGet(url: String, parameters: Dictionary<String,AnyObject>?, withCompletion completion:((response: HTTPResponse?, error: NSError?) -> Void)?) {
        var request = HTTPTask()
        addIndicator()
        request.GET(url, parameters: parameters, success: {(response: HTTPResponse?) -> Void in
//            println("response.statusCode \(response?.statusCode)")
//            var str = NSString(data: response?.responseObject as NSData, encoding: NSUTF8StringEncoding)
//            println("\(str)")
            self.removeIndicator()
            if response != nil {
                if response?.statusCode != nil {
                    if 200 <= response?.statusCode && response?.statusCode <= 299 {
                        if completion != nil {
                            completion!(response: response, error: nil)
                        }
                    }
                    else {
                        self.errorHandling(response!.statusCode!)
                    }
                }
                else {
                    dispatch_async(dispatch_get_main_queue(),{
                        Utility.showAlertWithMessage(somethingWrongMessage, title: titleWarning)
                    })
                }
            }
            else {
                dispatch_async(dispatch_get_main_queue(),{
                    Utility.showAlertWithMessage(somethingWrongMessage, title: titleWarning)
                })
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
                self.removeIndicator()
                Utility.showAlertWithMessage(connectionErrorMessage, title: titleWarning)
        })
    }
    
    func callWSWithMethodPost(url: String, parameters: Dictionary<String,AnyObject>?, withCompletion completion:((response: HTTPResponse?, error: NSError?) -> Void)?) {
        var request = HTTPTask()
        addIndicator()
        request.POST(url, parameters: parameters, success: {(response: HTTPResponse?) -> Void in
//            println("response.statusCode \(response?.statusCode)")
//            var str = NSString(data: response?.responseObject as NSData, encoding: NSUTF8StringEncoding)
//            println("\(str)")
            self.removeIndicator()
            if response != nil {
                if response?.statusCode != nil {
                    if 200 <= response?.statusCode && response?.statusCode <= 299 {
                        if completion != nil {
                            completion!(response: response, error: nil)
                        }
                    }
                    else {
                        self.errorHandling(response!.statusCode!)
                    }
                }
                else {
                    dispatch_async(dispatch_get_main_queue(),{
                        Utility.showAlertWithMessage(somethingWrongMessage, title: titleWarning)
                    })
                }
            }
            else {
                dispatch_async(dispatch_get_main_queue(),{
                    Utility.showAlertWithMessage(somethingWrongMessage, title: titleWarning)
                })
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
                self.removeIndicator()
                self.errorHandling(error.code)
        })
    }
    
    func errorHandling(errorCode: Int) {
        //following the document at http://en.wikipedia.org/wiki/List_of_HTTP_status_codes for details
        switch errorCode {
        case 400:
            Utility.showAlertWithMessage("Bad Request", title: titleWarning)
            break
        case 401:
            Utility.showAlertWithMessage("Unauthorized", title: titleWarning)
            break
        case 402:
            Utility.showAlertWithMessage("Payment Required", title: titleWarning)
            break
        case 403:
            Utility.showAlertWithMessage("Forbidden", title: titleWarning)
            break
        case 404:
            Utility.showAlertWithMessage("Not Found", title: titleWarning)
            break
        case 405:
            Utility.showAlertWithMessage("Method Not Allowed", title: titleWarning)
            break
        case 406:
            Utility.showAlertWithMessage("Not Acceptable", title: titleWarning)
            break
        case 407:
            Utility.showAlertWithMessage("Proxy Authentication Required", title: titleWarning)
            break
        case 408:
            Utility.showAlertWithMessage("Request Timeout", title: titleWarning)
            break
        case 409:
            Utility.showAlertWithMessage("Conflict", title: titleWarning)
            break
        case 410:
            Utility.showAlertWithMessage("Gone", title: titleWarning)
            break
        case 411 :
            Utility.showAlertWithMessage("Length Required", title: titleWarning)
            break
        case 412 :
            Utility.showAlertWithMessage("Precondition Failed", title: titleWarning)
            break
        case 413 :
            Utility.showAlertWithMessage("Request Entity Too Large", title: titleWarning)
            break
        case 414 :
            Utility.showAlertWithMessage("Request-URI Too Long", title: titleWarning)
            break
        case 415 :
            Utility.showAlertWithMessage("Unsupported Media Type", title: titleWarning)
            break
        case 416 :
            Utility.showAlertWithMessage("Requested Range Not Satisfiable", title: titleWarning)
            break
        case 417 :
            Utility.showAlertWithMessage("Expectation Failed", title: titleWarning)
            break
        case 418 :
            Utility.showAlertWithMessage("I'm a teapot", title: titleWarning)
            break
        case 419 :
            Utility.showAlertWithMessage("Authentication Timeout", title: titleWarning)
            break
        case 420 :
            Utility.showAlertWithMessage("Method Failure", title: titleWarning)
            break
        case 421 :
            Utility.showAlertWithMessage("Enhance Your Calm", title: titleWarning)
            break
        case 422 :
            Utility.showAlertWithMessage("Unprocessable Entity", title: titleWarning)
            break
        case 423 :
            Utility.showAlertWithMessage("Locked", title: titleWarning)
            break
        case 424 :
            Utility.showAlertWithMessage("Failed Dependency", title: titleWarning)
            break
        case 426 :
            Utility.showAlertWithMessage("Upgrade Required", title: titleWarning)
            break
        case 428 :
            Utility.showAlertWithMessage("Precondition Required", title: titleWarning)
            break
        case 429 :
            Utility.showAlertWithMessage("Too Many Requests", title: titleWarning)
            break
        case 431 :
            Utility.showAlertWithMessage("Request Header Fields Too Large", title: titleWarning)
            break
        case 440  :
            Utility.showAlertWithMessage("Login Timeout", title: titleWarning)
            break
        case 444:
            Utility.showAlertWithMessage("No Response", title: titleWarning)
            break
        case 449 :
            Utility.showAlertWithMessage("Retry With", title: titleWarning)
            break
        case 450 :
            Utility.showAlertWithMessage("Blocked by Windows Parental Controls", title: titleWarning)
            break
        case 451:
            Utility.showAlertWithMessage("Redirect", title: titleWarning)
            break
        case 494 :
            Utility.showAlertWithMessage("Request Header Too Large", title: titleWarning)
            break
        case 495 :
            Utility.showAlertWithMessage("Cert Error", title: titleWarning)
            break
        case 496 :
            Utility.showAlertWithMessage("No Cert", title: titleWarning)
            break
        case 497 :
            Utility.showAlertWithMessage("HTTP to HTTPS", title: titleWarning)
            break
        case 498 :
            Utility.showAlertWithMessage("Token expired/invalid", title: titleWarning)
            break
        case 499 :
            Utility.showAlertWithMessage("Client Closed Request", title: titleWarning)
            break
        case 499 :
            Utility.showAlertWithMessage("Token required", title: titleWarning)
            break
        case 500 :
            Utility.showAlertWithMessage("Internal Server Error", title: titleWarning)
            break
        case 501 :
            Utility.showAlertWithMessage("Not Implemented", title: titleWarning)
            break
        case 502 :
            Utility.showAlertWithMessage("Bad Gateway", title: titleWarning)
            break
        case 503 :
            Utility.showAlertWithMessage("Service Unavailable", title: titleWarning)
            break
        case 504 :
            Utility.showAlertWithMessage("Gateway Timeout", title: titleWarning)
            break
        case 505 :
            Utility.showAlertWithMessage("HTTP Version Not Supported", title: titleWarning)
            break
        case 506 :
            Utility.showAlertWithMessage("Variant Also Negotiates", title: titleWarning)
            break
        case 507 :
            Utility.showAlertWithMessage("Insufficient Storage", title: titleWarning)
            break
        case 508 :
            Utility.showAlertWithMessage("Loop Detected", title: titleWarning)
            break
        case 509 :
            Utility.showAlertWithMessage("Bandwidth Limit Exceeded", title: titleWarning)
            break
        case 510 :
            Utility.showAlertWithMessage("Not Extended", title: titleWarning)
            break
        case 511 :
            Utility.showAlertWithMessage("Network Authentication Required", title: titleWarning)
            break
        case 520 :
            Utility.showAlertWithMessage("Origin Error", title: titleWarning)
            break
        case 521 :
            Utility.showAlertWithMessage("Web server is down", title: titleWarning)
            break
        case 522 :
            Utility.showAlertWithMessage("Connection timed out", title: titleWarning)
            break
        case 523 :
            Utility.showAlertWithMessage("Proxy Declined Request", title: titleWarning)
            break
        case 524 :
            Utility.showAlertWithMessage("A timeout occurred", title: titleWarning)
            break
        case 598 :
            Utility.showAlertWithMessage("Network read timeout error", title: titleWarning)
            break
        case 599 :
            Utility.showAlertWithMessage("Network connect timeout error", title: titleWarning)
            break
        default:
            Utility.showAlertWithMessage(somethingWrongMessage, title: titleWarning)
        }
        
    }
    
    func addIndicator() {
        dispatch_async(dispatch_get_main_queue(),{
            var views = UIApplication.sharedApplication().keyWindow!.rootViewController!.view.subviews as NSArray
            for view in views {
                if view is UIView && view.tag == 1001 {
                    view.removeFromSuperview()
                }
                else if view is UIView {
                    var v = view as UIView
                    v.userInteractionEnabled = false
                }
            }
            var indicatorView = UIView(frame: CGRectMake(0, 0, 150, 150))
            UIApplication.sharedApplication().keyWindow?.rootViewController?.view.addSubview(indicatorView)
            indicatorView.tag = 1001
            indicatorView.backgroundColor = UIColor.clearColor()
            indicatorView.center = UIApplication.sharedApplication().keyWindow!.rootViewController!.view!.center
            
            //gray background
            var backGround = UIView(frame: CGRectMake(0, 0, 150, 150))
            backGround.backgroundColor = UIColor.blackColor()
            backGround.alpha = 0.6
            backGround.layer.cornerRadius = 10.0
            backGround.layer.masksToBounds = true
            indicatorView.addSubview(backGround)
            
            //indicator
            var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
            activityIndicator.alpha = 1.0
            activityIndicator.frame = CGRectMake(50, 50, 50, 50)
            activityIndicator.backgroundColor = UIColor.clearColor()
            activityIndicator.hidesWhenStopped = false
            indicatorView.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            //label
            var label = UILabel(frame: CGRectMake(40, 110, 100, 20))
            label.text = "Loading..."
            label.textColor = UIColor.whiteColor()
            indicatorView.addSubview(label)
        })
    }
    
    func removeIndicator() {
        dispatch_async(dispatch_get_main_queue(),{
            var views = UIApplication.sharedApplication().keyWindow!.rootViewController!.view.subviews as NSArray
            for view in views {
                if view is UIView && view.tag == 1001 {
                    view.removeFromSuperview()
                }
                else if view is UIView {
                    var v = view as UIView
                    v.userInteractionEnabled = true
                }
            }
        })
    }
}
