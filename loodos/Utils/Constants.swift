//
//  Constants.swift
//  loodos
//
//  Created by Berkay Delen on 6.08.2020.
//

import UIKit
import Foundation



class Constants {
    struct Colors{
        
        static var gray = UIColor(hexString: "#808285")
        static var darkGray = UIColor(hexString: "#6D6E71")
        static var softGray = UIColor(hexString: "#939598")

        static var black = UIColor(hexString: "#000000")
        static var black0 = UIColor(hexString: "#000000",alpha: 0)
        static var black25 = UIColor(hexString: "#000000",alpha: 0.25)
        static var black50 = UIColor(hexString: "#000000",alpha: 0.5)

        static var red = UIColor(hexString: "#E20338")
        static var green = UIColor(hexString: "#5BFF62")

        static var mainColor = UIColor(hexString: "3bafbf")

        static var transparent = UIColor(hexString: "#939598",alpha: 0)
        
        
    }
    struct Api {
        static let baseURL = "http://www.omdbapi.com"

        static let key = "7ca2cc6"
        
    }

    struct Data {

        static var newMovies: [MovieData] {
            get {
                return UserDefaults.standard.structArrayData(MovieData.self, forKey: "newMovies") ?? []
            }
            set {
                UserDefaults.standard.setStructArray(newValue, forKey: "newMovies")
            }
        }

        static var popularMovies: [MovieData] {
            get {
                return UserDefaults.standard.structArrayData(MovieData.self, forKey: "popularMovies") ?? []
            }
            set {
                UserDefaults.standard.setStructArray(newValue, forKey: "popularMovies")
            }
        }

        static var headerMovie: String {
            get {
                return UserDefaults.standard.string(forKey: "headerMovie") ?? ""
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "headerMovie")
            }
        }

        static var splashScreenName: String {
            get {
                return UserDefaults.standard.string(forKey: "splashScreenName") ?? ""
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "splashScreenName")
            }
        }
    }
}
