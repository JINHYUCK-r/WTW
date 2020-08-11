//
//  ViewController.swift
//  WTW
//
//  Created by 류진혁 on 2020/08/04.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var condition: UILabel!
    
    
    @IBOutlet weak var degree: UILabel!
    
    
    @IBOutlet weak var citynameText: UITextField!
    
    var weatherManager = WeatherManager()
    
    
    
     override func viewDidLoad() {
            super.viewDidLoad()
        citynameText.delegate = self
        // 키보드에 따라서 화면이 위로 올라가는 코드 1번
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        weatherManager.fetchWeather(cityName : "Taege" )
    }
    
// 2번
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
//3번
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           citynameText.endEditing(true)
           return true
       }
       
       @IBAction func reserchBtn(_ sender: UIButton) {
           citynameText.endEditing(true)
       }
}


