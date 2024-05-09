//
//  ViewController.swift
//  Scrolling Views
//
//  Created by lab on 1/16/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForKeyboardNotifications() //call keyboard scrolling code
    }
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Code below is to adjust the constraints of the scroll view so that the
    //scroll view can scroll further when the keyboard is shown in order to
    //display every piece of information on the page
    
    func  registerForKeyboardNotifications (){
        NotificationCenter.default.addObserver(self,
        selector:#selector(keyboardWasShown(_:)),
        name: UIResponder.keyboardDidShowNotification,
        object: nil)
        NotificationCenter.default.addObserver(self,
        selector:#selector(keyboardWillBeHidden(_:)), name:
        UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
        guard let info = notification.userInfo,
        let keyboardFrameValue =
        info[UIResponder.keyboardFrameBeginUserInfoKey]
        as? NSValue else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = UIEdgeInsets (top: 0.0, left: 0.0, bottom:
        keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification){
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    //end keyboard scrolling code
}

