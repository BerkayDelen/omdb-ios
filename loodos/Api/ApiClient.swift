//
//  ApiClient.swift
//  loodos
//
//  Created by Berkay Delen on 6.08.2020.
//

import Foundation
import Alamofire
import Firebase


class APIClient{

    ///Popular Movies - Home
    static func getPopularMovies(
        completion:@escaping (_ success:Bool,_ error:String,_ data:[MovieData]?)->Void) {


        let group = DispatchGroup()
        group.enter()

        var newMoviesData:[MovieData] = []
        for movie in Constants.Data.popularMovies {

            let url = "\(Constants.Api.baseURL)"

            let parameters: [String: Any] = [
                "i":movie.imdbID!,
                "apikey" : "\(Constants.Api.key)",
            ]

            print("-----------------")
            print("-------URL-------")
            print(url)
            print("----parameters---")
            print(parameters)
            print("-----------------")

            AF.request(url,method: .get,parameters: parameters).responseDecodable { (response: AFDataResponse<MovieData>) in
                do {
                    newMoviesData.append(try response.result.get())
                    if Constants.Data.popularMovies.count == newMoviesData.count{
                        group.leave()
                    }
                } catch {
                    print(error)
                }
            }
        }

        group.notify(queue: DispatchQueue.main) {
            completion(true,"",newMoviesData)
        }
    }

    ///New Movies - Home
    static func getNewMovies(
        completion:@escaping (_ success:Bool,_ error:String,_ data:[MovieData]?)->Void) {


        let group = DispatchGroup()
        group.enter()

        var newMoviesData:[MovieData] = []
        for movie in Constants.Data.newMovies {

            let url = "\(Constants.Api.baseURL)"

            let parameters: [String: Any] = [
                "i":movie.imdbID!,
                "apikey" : "\(Constants.Api.key)",
            ]

            print("-----------------")
            print("-------URL-------")
            print(url)
            print("----parameters---")
            print(parameters)
            print("-----------------")

            AF.request(url,method: .get,parameters: parameters).responseDecodable { (response: AFDataResponse<MovieData>) in
                do {
                    newMoviesData.append(try response.result.get())
                    if Constants.Data.newMovies.count == newMoviesData.count{
                        group.leave()
                    }
                } catch {
                    print(error)
                }
            }
        }

        group.notify(queue: DispatchQueue.main) {
            completion(true,"",newMoviesData)
        }
    }

    ///New Movies - Detail - Home
    static func getMovie(
        id:String,
        plot:Plot = .short,
        completion:@escaping (_ success:Bool,_ error:String,_ data:MovieData?)->Void) {


        let url = "\(Constants.Api.baseURL)"

        let parameters: [String: Any] = [
            "i":id,
            "plot":plot.rawValue,
            "apikey" : "\(Constants.Api.key)",
        ]

        print("-----------------")
        print("-------URL-------")
        print(url)
        print("----parameters---")
        print(parameters)
        print("-----------------")

        AF.request(url,method: .get,parameters: parameters).responseDecodable { (response: AFDataResponse<MovieData>) in
            do {
                completion(true,"",try response.result.get())
            } catch {
                print(error)
                completion(false,error.localizedDescription,nil)
            }
        }
    }

    ///Search Movies - Search
    static func getSearchMovies(
        page:Int = 1,
        searchText:String,
        completion:@escaping (_ success:Bool,_ error:String,_ data:SearchData?)->Void) {


        let url = "\(Constants.Api.baseURL)"

        let parameters: [String: Any] = [
            "page":page,
            "s":searchText,
            "apikey" : "\(Constants.Api.key)",
        ]

        print("-----------------")
        print("-------URL-------")
        print(url)
        print("----parameters---")
        print(parameters)
        print("-----------------")

        AF.request(url,method: .get,parameters: parameters).responseDecodable { (response: AFDataResponse<SearchData>) in
            do {
                completion(true,"",try response.result.get())
            } catch {
                print(error)
                completion(false,error.localizedDescription,nil)
            }
        }
    }

    ///Firebase Remote Configs - AppDelegate
    static func getRemoteConfig(completion:@escaping (_ success:Bool,_ error:String)->Void){

        var remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        print("Last Fetch -> \(remoteConfig.lastFetchTime)")
        remoteConfig.fetchAndActivate { (status, error) in

            if status != .error{
                let header_movie = remoteConfig["header_movie"].stringValue
                let jsonNewMovies = remoteConfig["new_movies"].dataValue
                let jsonPopularMovies = remoteConfig["popular_movies"].dataValue
                let splashScreenName = remoteConfig["splash_screen_name"].stringValue


                let respondeData = try! decodeArray(json: jsonNewMovies as! Data, asA: MovieData.self)
                let popularMovies = try! decodeArray(json: jsonPopularMovies as! Data, asA: MovieData.self)

                Constants.Data.newMovies = respondeData ?? []
                Constants.Data.popularMovies = popularMovies ?? []
                Constants.Data.headerMovie = header_movie!
                Constants.Data.splashScreenName = splashScreenName!

                print("Header movie -> \(header_movie)")
                print("Count -> \(Constants.Data.newMovies.count)")
                print("Last Fetch -> \(remoteConfig.lastFetchTime)")

                completion(true,"")
            }else{
                completion(false,error!.localizedDescription)
            }
        }
    }

    ///Firebase Analytics - Detail
    static func addFirebaseLog(logName:String,movie:MovieData){
        Analytics.logEvent(logName, parameters: [
            "imdbID": "\(movie.imdbID ?? "null")" as NSObject,
        ])
    }
}
