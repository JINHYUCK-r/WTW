//
//  file.swift
//  WTW
//
//  Created by 류진혁 on 2020/08/11.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import Foundation

struct WeatherManager {
    
let url = "https://api.openweathermap.org/data/2.5/weather?q="
let appId = "&appid=92863a6e6b49757727ca29249892156c&units=metric" //units=metric은 섭씨로 표현

    func fetchWeather(cityName : String){
    let urlString = "\(url)\(cityName)\(appId)"
    performRequest(urlString: urlString)
}
    
    //1번. session 만들기
    //1.create url
    func performRequest(urlString : String){
        if let url = URL(string: urlString){
            //2. creat session
            let session = URLSession(configuration: .default)
            //3. fech data
            let task = session.dataTask(with: url) {(data:Data?, response:URLResponse?, error:Error?) in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    self.parseJSON(weatherData: safeData)
                }
            }
            //4. start sesiion
            task.resume()
        }
    }
    func parseJSON(weatherData:Data){
        let decoder = JSONDecoder()
        do{
             let decodeedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodeedData.main.temp)
            print(decodeedData.name)
            print(decodeedData.weather[0].id)
            print(decodeedData.weather[0].description)
        }catch{
            print(error)
        }
       
        
    }
        
        
        
    }
    /* fetch data로 클로저 하지않고 따로 함수를 만들었을때 이렇게 됨. 이것은 위에 datatask에 넣어서 클로저로 사용
    {(data:Data?, response:URLResponse?, error:Error?) in
        if error != nil{
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
        */

