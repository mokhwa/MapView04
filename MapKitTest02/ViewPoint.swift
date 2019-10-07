//
//  ViewPoint.swift
//  MapKitTest02
//
//  Created by D7703_22 on 2019. 10. 7..
//  Copyright © 2019년 BlueScreen. All rights reserved.
//

import UIKit
import MapKit

class ViewPoint: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
