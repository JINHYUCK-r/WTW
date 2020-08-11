//
//  WeatherModel.swift
//  WTW
//
//  Created by 류진혁 on 2020/08/11.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import Foundation

//API의 정보를 필요한 형식으로 뽑아오기
struct WeatherModel {
    let conditionID : Int
    let cityName : String
    let temperature : Double
    let condition : String
    
    
    var temperatureString:String{
        return String(format: "%.2f", temperature)
    }
    
    var conditionName : String{
    switch conditionID  {
    case 200...232:
        return "cloud.bolt"
    case 300...321:
        return "cloud.drizzle"
    case 500...531:
        return "cloud.rain.fill"
    case 600...622:
        return "cloud.snow"
    case 701...781:
        return "smoke"
    case 800:
        return "sun.max"
    default:
        return "cloud"
    }
}
}
