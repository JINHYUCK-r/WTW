//
//  file.swift
//  WTW
//
//  Created by 류진혁 on 2020/08/11.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didWeatherUpdate(weatherManager: WeatherManager, weather: WeatherModel)
    
}

struct WeatherManager {
    //API 불러와서 사용
let url = "https://api.openweathermap.org/data/2.5/weather?q="
let appId = "&appid=92863a6e6b49757727ca29249892156c&units=metric" //units=metric은 섭씨로 표현
    var delegate : WeatherManagerDelegate?
    
    //데이터불러오기
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
            //3. fech data , 데이터를 저장
            let task = session.dataTask(with: url) {(data:Data?, response:URLResponse?, error:Error?) in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    
                    if let weather = self.parseJSON(weatherData: safeData){
                        //딜리게이트 만들어서 정보저장
                    self.delegate?.didWeatherUpdate(weatherManager: self, weather: weather)
                    }
                }
            }
            //4. start session, 저장된 데이터 시작
            task.resume()
        }
    }
    //API의 JSON형식의 데이터를 변환
    func parseJSON(weatherData:Data) -> WeatherModel?{
        let decoder = JSONDecoder() //decoder json의 데이터를 해독
        do{
            let decodeedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodeedData.main.temp
            let name = decodeedData.name
            let id = decodeedData.weather[0].id
            let condition = decodeedData.weather[0].description
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp,condition: condition )
            return weather
            
        }catch{
            print(error)
            //리턴타입이 존재하기때문에 써주어야함
            return nil
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

