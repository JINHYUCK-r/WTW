//
//  file.swift
//  WTW
//
//  Created by 류진혁 on 2020/08/11.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import Foundation

struct WeatherManager {
    
let url = "http://api.openweathermap.org/data/2.5/weather?q="
let appId = "&appid=92863a6e6b49757727ca29249892156c"

    func fetchWeather(cityName : String){
    let urlString = "\(url)\(cityName)\(appId)"
    print(urlString)
}
}
