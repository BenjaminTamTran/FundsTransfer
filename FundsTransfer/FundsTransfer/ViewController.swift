//
//  ViewController.swift
//  FundsTransfer
//
//  Created by Tran Huu Tam on 1/10/15.
//  Copyright (c) 2015 BenjaminSoft. All rights reserved.
//

import UIKit
import AddressBookUI

class ViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
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
    @IBOutlet weak var contactEmailTextField: UITextField!
    @IBOutlet weak var leadingMainViewPaymentRConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthMainViewPaymentConstraints: NSLayoutConstraint!
    @IBOutlet weak var backgroundInnerPaymentView: UIView!
    @IBOutlet weak var backgroundPaymentView: UIView!
    @IBOutlet weak var leadingMainViewBankLRConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthMainViewBankLConstraints: NSLayoutConstraint!
    @IBOutlet weak var bankSelectedTxtField: UITextField!
    @IBOutlet weak var bankListTableView: UITableView!
    
    
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
    var dataBankListArr = NSMutableArray()
    let bankCellIdentifier = "bankCellIdentifier"
    var selectedBankName = ""
    
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
    
    @IBAction func openAddressBookButton(sender: AnyObject) {
        let picker = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        if picker.respondsToSelector(Selector("predicateForEnablingPerson")) {
            picker.predicateForEnablingPerson = NSPredicate(format: "emailAddresses.@count > 0")
        }
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func goBackAction(sender: AnyObject) {
        leadingMainViewPaymentRConstraint.constant = UIScreen.mainScreen().bounds.width
    }
    
    @IBAction func payNowAction(sender: AnyObject) {
        leadingMainViewPaymentRConstraint.constant = 0
    }
    
    @IBAction func openBankListAciton(sender: AnyObject) {
        leadingMainViewBankLRConstraint.constant = 0
    }
    
    @IBAction func closeBankListAction(sender: AnyObject) {
        leadingMainViewBankLRConstraint.constant = UIScreen.mainScreen().bounds.width
    }
    
    @IBAction func selectBankInfoAction(sender: AnyObject) {
        bankSelectedTxtField.text = selectedBankName
        leadingMainViewBankLRConstraint.constant = UIScreen.mainScreen().bounds.width
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
        
        backgroundPaymentView.layer.cornerRadius = 10
        backgroundPaymentView.layer.masksToBounds = true
        backgroundInnerPaymentView.layer.cornerRadius = 5
        backgroundInnerPaymentView.layer.masksToBounds = true
        
        bankListTableView.layer.cornerRadius = 10
        bankListTableView.layer.masksToBounds = true
        
        widthMainViewPaymentConstraints.constant = UIScreen.mainScreen().bounds.width
        leadingMainViewPaymentRConstraint.constant = UIScreen.mainScreen().bounds.width
        
        widthMainViewBankLConstraints.constant = UIScreen.mainScreen().bounds.width
        leadingMainViewBankLRConstraint.constant = UIScreen.mainScreen().bounds.width
        
        bankListTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: bankCellIdentifier)
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
                    self.dataBankListArr = dataBankDict!.objectForKey("Entry") as NSMutableArray
                    if self.dataBankListArr.count > 0 {
                        dispatch_async(dispatch_get_main_queue(),{
                            self.bankListTableView.reloadData()
                        })
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
    
    
    // MARK: ABPeoplePickerNavigationControllerDelegate's methods
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecordRef!) {
        let emails: ABMultiValueRef = ABRecordCopyValue(person, kABPersonEmailProperty).takeRetainedValue()
        if (ABMultiValueGetCount(emails) > 0) {
            let index = 0 as CFIndex
            let email = ABMultiValueCopyValueAtIndex(emails, index).takeRetainedValue() as String
            contactEmailTextField.text = email
        } else {
            Utility.showAlertWithMessage("No email address", title: titleWarning)
        }
    }
    
    
    // MARL: UITableViewDataSource's methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        println("dataBankListArr.count \(dataBankListArr.count)")
        return dataBankListArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(bankCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        var bankInfo = dataBankListArr.objectAtIndex(indexPath.row) as? NSDictionary
        if bankInfo != nil {
            cell.textLabel?.text = bankInfo?.objectForKey("Name") as? String
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        var bankInfo = dataBankListArr.objectAtIndex(indexPath.row) as? NSDictionary
        if bankInfo != nil {
            selectedBankName = bankInfo?.objectForKey("Name") as String
        }
    }
    
}

