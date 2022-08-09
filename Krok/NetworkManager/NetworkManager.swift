
import Foundation
import UIKit
import Alamofire
import SwiftyJSON

final class NetworkManager {
    static let shared = NetworkManager()
}

extension NetworkManager {
    public func getCitiesListRequest(completion: @escaping (Result<[CityList], Error>) -> Void) {
        AF.request("https://krokapp.by/api/get_cities/11/", method: .get).responseJSON { result in
            switch result.result {
            case .success(let value):
                let json = JSON(value)
                var cities: [CityList] = []
                guard let cityArray = json.array
                else {
                    completion(.failure(NetworkErrors.FailedToFetchData))
                    return
                    
                }
                for city in cityArray {
                    guard let id = city["id"].int ,
                          let name = city["name"].string,
                          let image = city["logo"].string,
                          let lang = city["lang"].int
                    else {
                        completion(.failure(NetworkErrors.FailedToFetchData))
                        return }
                    cities.append(CityList(id: id, name: name, logo: image, lang: lang))
                }
                completion(.success(cities))
            case .failure(_):
                completion(.failure(NetworkErrors.FailedToFetchData))
            }
        }
    }
    
    
    
    public func getPlacesListRequest(of city: Int, completion: @escaping (Result<[PlacesList], Error>) -> Void) {
        AF.request("http://krokapp.by/api/get_points/11/", method: .get).responseJSON { result in
            switch result.result {
            case .success(let value):
                let json = JSON(value)
                var places: [PlacesList] = []
                guard let placesArray = json.array
                else {
                    completion(.failure(NetworkErrors.FailedToFetchData))
                    return
                    
                }
                for place in placesArray {
                    guard let id = place["id"].int ,
                          let placeName = place["name"].string?.trimHTMLTags(),
                          let text = place["text"].string?.trimHTMLTags(),
                          let logo = place["logo"].string,
                          let photo = place["photo"].string,
                          let cityId = place["city_id"].int,
                          let lang = place["lang"].int,
                          let creationDate = place["creation_date"].string,
                          let visible = place["visible"].bool,
                          let sound = place["sound"].string
                    else {
                        completion(.failure(NetworkErrors.FailedToFetchData))
                        return }
                    places.append(PlacesList(id: id, name: placeName, text: text, logo: logo, photo: photo, city_id: cityId, lang: lang, creation_date: creationDate, visible: visible, sound: sound))
                }
                completion(.success(places))
            case .failure(_):
                completion(.failure(NetworkErrors.FailedToFetchData))
            }
        }
    }
    
    
    //    public func getPlacesDetailes(of city: Int, completion: @escaping (Result<PlacesList, Error>) -> Void) {
    //        AF.request("http://krokapp.by/api/get_points/11/", method: .get).responseJSON { result in
    //            switch result.result {
    //            case .success(let value):
    //                let json = JSON(value)
    //
    //                    guard let id = json["id"].int ,
    //                          let placeName = json["name"].string,
    //                          let text = json["text"].string?.trimHTMLTags(),
    //                          let logo = json["logo"].string,
    //                          let photo = json["photo"].string,
    //                        let cityId = json["city_id"].int,
    //                            let lang = json["lang"].int,
    //                          let creationDate = json["creation_date"].string,
    //                          let visible = json["visible"].bool
    //                    else {
    //                        completion(.failure(NetworkErrors.FailedToFetchData))
    //                        return }
    //
    //                completion(.success (PlacesList(id: id, name: placeName, text: text, logo: logo, photo: photo, city_id: cityId, lang: lang, creation_date: creationDate, visible: visible)))
    //            case .failure(_):
    //                completion(.failure(NetworkErrors.FailedToFetchData))
    //            }
    //        }
    //    }
    
}

public enum NetworkErrors: Error {
    case FailedToFetchData
    
}
