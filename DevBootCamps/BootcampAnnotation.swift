//
//  BootcampAnnotation.swift
//  DevBootCamps
//
//  Created by 蔡智斌 on 16/3/30.
//  Copyright © 2016年 NeoChoi. All rights reserved.
//

import Foundation
import MapKit

class BootcampAnnotation : NSObject, MKAnnotation{
    var coordinate = CLLocationCoordinate2D()
    init(coordinate : CLLocationCoordinate2D){
        self.coordinate = coordinate
        }
}
