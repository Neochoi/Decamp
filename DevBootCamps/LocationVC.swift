//
//  SecondViewController.swift
//  DevBootCamps
//
//  Created by 蔡智斌 on 16/3/28.
//  Copyright © 2016年 NeoChoi. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController ,UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate{
    
    let locationManage = CLLocationManager()
    
    let addresses = ["东莞市，凤岗镇"]
    
    let regionRadius : CLLocationDistance = 1000//显示半径
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var map:MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        for add in addresses{
            getPlacemarkFromAddress(add)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()//返回位置
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
func locationAuthStatus(){//在Info.plist里面要添加NSLocationWhenInUseUsageDescription在后面的value里面输入提示的文字要允许才能访问
        if  CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse{//系统是否允许与需求是否一致
            map.showsUserLocation = true//如果一致就返回位置
        }else{
            locationManage.requestWhenInUseAuthorization()//如果不一致就询问是否允许
        }
    }
    
    func centerMapOnLocation(location : CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2 )
        
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {//更新用户地址
        if let loc = userLocation.location{
            centerMapOnLocation(loc)
        }
    }
    
    func getPlacemarkFromAddress(address: String){
        CLGeocoder().geocodeAddressString(address){(placemarks:[CLPlacemark]?,error: NSError?) -> Void in
            if let marks = placemarks where marks.count > 0{
                if let loc = marks[0].location{
                    self.createAnnotationForLocation(loc)
                }
            }
        }
    }
        
        func createAnnotationForLocation(location: CLLocation){
            let bootcamp = BootcampAnnotation(coordinate: location.coordinate)
            map.addAnnotation(bootcamp)
        }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(BootcampAnnotation){
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoView.pinTintColor = UIColor.yellowColor()
            annoView.animatesDrop = true
            return annoView
            
        }else if annotation.isKindOfClass(MKUserLocation){
            return nil
        }
        return nil
    }
    
    


}

