//
//  Objects.swift
//  Krok
//
//  Created by Aliaksandr Miatnikau on 28.07.22.
//

import Foundation


struct CityList {
    var id: Int
    var name: String
    var logo: String
    var lang: Int
}

struct PlacesList {
   
    var id: Int
    var name: String
    var text: String
    var logo: String
    var photo: String
    var city_id: Int
    var lang: Int
    var creation_date: String
    var visible: Bool
    var sound: String
    

    
//    var creation_date: String
//    var visible: Bool
   
    
//    var sound: String
//    var lat: Double
//    var lng: Double
}
