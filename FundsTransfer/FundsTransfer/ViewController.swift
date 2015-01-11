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
    @IBOutlet weak var transferInfoView: UIView!
    @IBOutlet weak var transferInfoBGView: UIView!
    @IBOutlet weak var bankInfoView: UIView!
    @IBOutlet weak var bankInfoBGView: UIView!
    @IBOutlet weak var hideKeyboardButton: UIButton!
    @IBOutlet weak var transferAreaTopConstraint: NSLayoutConstraint!
    
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
    
    @IBAction func hideKeyBoardAction(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    // MARK: Class's private methods
    func initialize() {
        
    }
    
    func visualize() {
        accountInfoView.layer.cornerRadius = 10
        accountInfoView.layer.masksToBounds = true
        
        transferInfoView.layer.cornerRadius = 10
        transferInfoView.layer.masksToBounds = true
        transferInfoBGView.layer.cornerRadius = 5
        transferInfoBGView.layer.masksToBounds = true
        
        bankInfoView.layer.cornerRadius = 10
        bankInfoView.layer.masksToBounds = true
        bankInfoBGView.layer.cornerRadius = 5
        bankInfoBGView.layer.masksToBounds = true
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
        networkAdapter.callWSWithMethodGet(bankListAction, parameters: nil) { (response: HTTPResponse?, error: NSError?) -> Void in
            if response?.responseObject != nil {
                var jsonDic = NSJSONSerialization.JSONObjectWithData(response!.responseObject as NSData, options: .MutableLeaves, error: nil) as NSDictionary
                var dataBankDict: NSDictionary? = jsonDic.objectForKey("Entries") as? NSDictionary
                if (dataBankDict != nil) {
                    var dataBankListArr: NSArray? = dataBankDict!.objectForKey("Entry") as? NSArray
                    for bankInfo in dataBankListArr! {
                        var bankIn = bankInfo as NSDictionary
                    }
                }
            }
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        hideKeyboardButton.hidden = false
        transferAreaTopConstraint.constant = 90
    }
    
    func keyboardWillHide(notification: NSNotification) {
        hideKeyboardButton.hidden = true
        transferAreaTopConstraint.constant = 215
    }
    
}

