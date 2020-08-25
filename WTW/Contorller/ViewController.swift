//
//  ViewController.swift
//  WTW
//
//  Created by 류진혁 on 2020/08/04.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var degree: UILabel!
    @IBOutlet weak var citynameText: UITextField!
    @IBOutlet weak var myTypeWriterLabel: CLTypingLabel!
    
    var weatherManager = WeatherManager()
    
     override func viewDidLoad() {
            super.viewDidLoad()
        weatherManager.delegate=self
        citynameText.delegate = self
        myTypeWriterLabel.text = "날씨보여줍니다!!"
        
        // 키보드에 따라서 화면이 위로 올라가는 코드 1번
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
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
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = citynameText.text{
            weatherManager.fetchWeather(cityName: cityName)
        }
        citynameText.text=""
    }
}
    
//WeatherManager에서 만든 딜리게이트와 저정된 정보를 뷰컨트롤에서 사용
extension ViewController : WeatherManagerDelegate{
    func didWeatherUpdate(weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.sync {
            self.iconImage.image = UIImage(systemName: weather.conditionName)
            self.location.text=weather.cityName
            self.degree.text=weather.temperatureString
            self.condition.text=weather.condition
        }
    }
    
    
}



