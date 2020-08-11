//
//  WeatherData.swift
//  WTW
//
//  Created by 류진혁 on 2020/08/11.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import Foundation

struct WeatherData:Decodable {  //Decodable : parse를쓰기위해 해주어야하는 형태
    let name : String
    let weather : [Weather]
    let main : Main
}
struct Weather:Decodable {
    let id : Int
    let description : String
}
struct Main:Decodable {
    let temp : Double
}
