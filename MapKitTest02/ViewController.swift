//
//  ViewController.swift
//  MapKitTest02
//
//  Created by D7703_15 on 2019. 9. 16..
//  Copyright © 2019년 bohyun. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    // 배열 선언
    var pins = [MKPointAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // MKMapViewDelegate와 UIViewController(self)
        mapView.delegate = self
        
        let path = Bundle.main.path(forResource: "MyData", ofType: "plist")
        print(path!)
        
        //화일의 내용 복사하기

        let contents = NSArray(contentsOfFile: path!)
        print(contents!)
        
        if let myItems = contents {
            for item in myItems {
                let latitude = (item as AnyObject).value(forKey: "latitude")
                let longitude = (item as AnyObject).value(forKey: "longitude")
                let title = (item as AnyObject).value(forKey: "title")
                let subtitle = (item as AnyObject).value(forKey: "subtitle")
                
                //위도, 경도 double로 형변환
                let myLat = (latitude as! NSString).doubleValue
                let myLng = (longitude as! NSString).doubleValue
                
                let pin = MKPointAnnotation()
                pin.coordinate.latitude = myLat
                pin.coordinate.longitude = myLng
                pin.title = title as? String
                pin.subtitle = subtitle as? String
                
                //pins 배열에. append
                pins.append(pin)
                
            }
        }
        else {
            print("오류")
        }
        mapView.showAnnotations(pins, animated: true)
        
        
        
        
        
        
        // 위도, 경도 설정 (DIT 35.165964, 129.072543)
        //let location = CLLocationCoordinate2D(latitude: 35.165964, longitude: 129.072543)
        
        // 반경 설정(숫자가 작을수록 세부적으로)
        //let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        
        // region 설정
        //let region = MKCoordinateRegion(center: location, span: span)
        
        // span과 region 같이 지정
        //let region = MKCoordinateRegion(center: location, latitudinalMeters: 300, longitudinalMeters: 300)
        
        // mapView 에 add
        //mapView.setRegion(region, animated: true)
        /*
        let pin1 = ViewPoint(coordinate: location, title: "동의과학대학교", subtitle: "We Are DIT")
        mapView.addAnnotation(pin1)
        let pin2 = ViewPoint(coordinate: CLLocationCoordinate2D(latitude: 35.1681824, longitude: 129.0556455), title: "부산 시민공원", subtitle: "부산의 랜크마크")
         mapView.addAnnotation(pin2)
        let pin3 = ViewPoint(coordinate: CLLocationCoordinate2D(latitude: 35.147919, longitude: 129.130123), title: "광안대교", subtitle: "부산의 랜드마크")
         mapView.addAnnotation(pin3)
        let pin4 = ViewPoint(coordinate: CLLocationCoordinate2D(latitude: 35.0517554, longitude: 129.0856113), title: "태종대", subtitle: "해변 전망대가 있는 고지대 공원")
         mapView.addAnnotation(pin4)
        */
        /*
        // pin꼽기
        let pin1 = MKPointAnnotation()
        pin1.coordinate = location
        pin1.title = "동의과학대학교"
        pin1.subtitle = "We Are DIT"
        //mapView.addAnnotation(pin1)
        pins.append(pin1)   //배열 pins에 pin1 넣기
        
        // 시민공원 pin꼽기 35.1681824, 129.0556455
        let pin2 = MKPointAnnotation()
        pin2.coordinate.latitude = 35.1681824
        pin2.coordinate.longitude = 129.0556455
        pin2.title = "부산 시민공원"
        pin2.subtitle = "부산의 랜크마크"
        //mapView.addAnnotation(pin2)
        pins.append(pin2)   //배열 pins에 pin2 넣기
        
        // 광안대교 pin꼽기 35.147919, 129.130123
        let pin3 = MKPointAnnotation()
        pin3.coordinate.latitude = 35.147919
        pin3.coordinate.longitude = 129.130123
        pin3.title = "광안대교"
        pin3.subtitle = "부산의 랜드마크"
        //mapView.addAnnotation(pin3)
        pins.append(pin3)   //배열 pins에 pin3 넣기
        
        // 태종대 pin꼽기 35.0517554, 129.0856113
        let pin4 = MKPointAnnotation()
        pin4.coordinate.latitude = 35.0517554
        pin4.coordinate.longitude = 129.0856113
        pin4.title = "태종대"
        pin4.subtitle = "해변 전망대가 있는 고지대 공원"
        //mapView.addAnnotation(pin4)
        pins.append(pin4)   //배열 pins에 pin4 넣기
        */
        // mapView의 모든 pin들을 나타냄(배열)
        // showAnnotations : 반경 지정 없이 모든 pin을 지도에 나타나게 함
    }
    
    // MapType 버튼 설정 (standard, hybrid, satellite)
    @IBAction func standardTypeButton(_ sender: Any) {
        mapView.mapType = MKMapType.standard
    }
    
    @IBAction func hybridTypeButton(_ sender: Any) {
        mapView.mapType = MKMapType.hybrid
    }
    
    @IBAction func satelliteTypeButton(_ sender: Any) {
        mapView.mapType = MKMapType.satellite
    }
    
 
    // MKMapViewDelegate 메소드
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // pin의 재활용
        let identifier = "RE"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        // 재활용할 pin이 없으면 pin 생성
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            //annotationView?.pinTintColor = UIColor.blue   // pin 색깔 변경
            annotationView?.animatesDrop = true
            
            // 오른쪽 : 상세정보 버튼
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
            // 왼쪽 : 이미지 넣기
            //let imgV = UIImageView(image: UIImage(named: "cat.jpg"))
            //imgV.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            //annotationView?.leftCalloutAccessoryView = imgV
            
        } else {
            annotationView!.annotation = annotation
        }
        
        // pin색깔 변경
        if annotation.title! == "동의과학대학교"  {
            annotationView?.pinTintColor = UIColor.red
            let imgV = UIImageView(image: UIImage(named: "dit.png"))
            imgV.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            annotationView?.leftCalloutAccessoryView = imgV
        } else if annotation.title! == "태종대" {
            annotationView?.pinTintColor = UIColor.green
            let imgV = UIImageView(image: UIImage(named: "dit.png"))
            imgV.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            annotationView?.leftCalloutAccessoryView = imgV
        }
            else if annotation.title! == "광안대교" {
            annotationView?.pinTintColor = UIColor.white
            let imgV = UIImageView(image: UIImage(named: "dit.png"))
            imgV.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            annotationView?.leftCalloutAccessoryView = imgV
        }
        else {
            annotationView?.pinTintColor = UIColor.yellow
            let imgV = UIImageView(image: UIImage(named: "dit.png"))
            imgV.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            annotationView?.leftCalloutAccessoryView = imgV
        }
        
        
        
        
        
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        // 알림창 객체 생성
        let alert = UIAlertController(title: ((view.annotation?.title)!), message: ((view.annotation?.subtitle)!), preferredStyle: .alert)
        // 확인 버튼
        let ok = UIAlertAction(title:"확인", style: .default)
        // 버튼을 컨트롤러에 등록
        alert.addAction(ok)
        // 알림창 실행
        self.present(alert, animated: false)
        
    }
}

