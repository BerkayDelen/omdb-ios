//
//  File.swift
//  loodos
//
//  Created by Berkay Delen on 6.08.2020.
//


import UIKit
import Foundation
import Kingfisher

class Utils{
}


///Click-All
func generateClick(target: Any, selector:Selector,view:UIView){

    var subclass = view as? UIControl
    //UIControl

    //view.addTarget(
    if subclass != nil{
        subclass!.addTarget(target, action: selector, for: .touchUpInside)
    }else{
        let tap = UITapGestureRecognizer(target: target, action: selector)

        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
}



func convertDateFormater(_ date: String,format:String = "yyyy-MM-dd") -> String
{
    print(date)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: date)
    dateFormatter.dateFormat = format
    return  dateFormatter.string(from: date!)

}

func unixDateConverter(time: String,timeStamp: Bool? = false,format:String = "dd/MM/yyyy HH:mm") -> String {

    var format_return = format
    var strDate = "undefined"





    if var unixTime = TimeInterval(time) {
        if timeStamp == true{
            //   unixTime = unixTime/1000
        }
        unixTime = unixTime/1000




        let date2 = Date(timeIntervalSince1970: unixTime)

        let dateFormatter2 = DateFormatter()
        dateFormatter2.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter2.locale = NSLocale.current
        dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        let strDate2 = dateFormatter2.string(from: date2)



        let now_date = Date()
        let now_data_format = dateFormatter2.string(from: now_date)
        if strDate2.split(separator: " ")[0] != now_data_format.split(separator: " ")[0]{
            format_return = "dd/MM/yyyy HH:mm"
        }

        let date = Date(timeIntervalSince1970: unixTime)


        let dateFormatter = DateFormatter()
        var timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET

        timezone = "GMT+3:00"
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        //dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = format_return //Specify your format that you want
        strDate = dateFormatter.string(from: date)
    }else{
        //strDate = "-"
        //var unixTime  = toDate





        let date2 = toDate(Int64(time) ?? 0/1000)

        let dateFormatter2 = DateFormatter()
        dateFormatter2.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter2.locale = NSLocale.current
        dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        let strDate2 = dateFormatter2.string(from: date2!)



        let now_date = Date()
        let now_data_format = dateFormatter2.string(from: now_date)
        if strDate2.split(separator: " ")[0] != now_data_format.split(separator: " ")[0]{
            format_return = "dd/MM/yyyy HH:mm"
        }

        let date = toDate(Int64(time) ?? 0/1000)


        let dateFormatter = DateFormatter()
        var timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET

        timezone = "GMT+3:00"
        dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
        //dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = format_return //Specify your format that you want
        strDate = dateFormatter.string(from: date!)

    }

    return strDate
}
func toDate(_ timestamp: Any?) -> Date? {
    if let any = timestamp {
        if let str = any as? NSString {
            return Date(timeIntervalSince1970: str.doubleValue)
        } else if let str = any as? NSNumber {
            return Date(timeIntervalSince1970: str.doubleValue)
        }
    }
    return nil
}

func openView(vc:UIViewController,withIdentifier:String,contentView:UIView) {


    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var controller: UIViewController = storyboard.instantiateViewController(withIdentifier: withIdentifier) as UIViewController

    vc.embed(controller, inView: contentView)


}


func decode<T: Decodable>(json: Data, asA thing: T.Type) -> T? {
    return try? JSONDecoder().decode(thing, from: json)
}

func decodeArray<T: Decodable>(json: Data, asA thing: T.Type) -> [T] {
    return decode(json: json, asA: [T].self) ?? []
}



