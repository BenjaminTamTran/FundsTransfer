//
//  ViewController.swift
//  FundsTransfer
//
//  Created by Tran Huu Tam on 1/10/15.
//  Copyright (c) 2015 BenjaminSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: UI's elements
    
    @IBOutlet weak var accountInfoView: UIView!
    @IBOutlet weak var balanceAmountLabel: UILabel!
    @IBOutlet weak var leftAmountLabel: UILabel!
    
    // MARK: Class's constructors
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initialize()
    }

    
    // MARK: Class's properties
    var networkAdapter = NetworkAdapter()
    
    // MARK: View's lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.visualize()
        self.localize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    // MARK: View's memory handler
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: View's orientation handler
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue + UIInterfaceOrientationMask.PortraitUpsideDown.rawValue)
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        super.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
    }
    
    
    // MARK: View's transition event handler
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
    // MARK: View's Actions
    
    
    
    // MARK: Class's private methods
    func initialize() {
        
    }
    
    func visualize() {
        accountInfoView.layer.cornerRadius = 10
        accountInfoView.layer.masksToBounds = true
    }
    
    func localize() {
        
    }
    
    func fetchData() {
        //Get Account info
        networkAdapter.callWSWithMethodGet(accountInfoAction, parameters: nil) { (response: HTTPResponse?, error: NSError?) -> Void in
            if response?.responseObject != nil {
                var jsonDic = NSJSONSerialization.JSONObjectWithData(response!.responseObject as NSData, options: .MutableLeaves, error: nil) as NSDictionary
                var accountDict: NSDictionary? = jsonDic.objectForKey("AcctInfo") as? NSDictionary
                var limitDict: NSDictionary? = jsonDic.objectForKey("LimitInfo") as? NSDictionary
                if accountDict != nil &&  limitDict != nil {
                    var amountString = Utility.amountInRpFormat(accountDict!.objectForKey("BalanceAmount") as String)
                    var limitString = Utility.amountInRpFormat(limitDict!.objectForKey("RemainingLimit") as String)
                    dispatch_async(dispatch_get_main_queue(),{
                        self.balanceAmountLabel.text = amountString
                        self.leftAmountLabel.text = limitString
                    })
                }
                
            }
        }
        //Get Bank list
//        networkAdapter.callWSWithMethodGet(bankListAction, parameters: nil) { (response: HTTPResponse?, error: NSError?) -> Void in
//            if response?.responseObject != nil {
//                var jsonDic = NSJSONSerialization.JSONObjectWithData(response!.responseObject as NSData, options: .MutableLeaves, error: nil) as NSDictionary
//                var dataBankDict: NSDictionary? = jsonDic.objectForKey("Entries") as? NSDictionary
//                if (dataBankDict != nil) {
//                    var dataBankListArr: NSArray? = dataBankDict!.objectForKey("Entry") as? NSArray
//                    for bankInfo in dataBankListArr! {
//                        var bankIn = bankInfo as NSDictionary
//                    }
//                }
//            }
//        }
    }
    
}

