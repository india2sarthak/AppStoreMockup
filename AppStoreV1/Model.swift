//
//  Model.swift
//  AppStoreV1
//
//  Created by Sarthak Mishra on 21/06/18.
//  Copyright © 2018 Sarthak Mishra. All rights reserved.
//

import UIKit
import Foundation

class FeaturedApps: Decodable {
    
    var bannerCategory: Category?
    var categories: [Category]?
}
class Category:  Decodable {
    
    
    var name: String?
    var apps = [App]()
    var type: String?
    
    static func getAppStoreData(completionHandler: @escaping (FeaturedApps) -> ()) {
        
    
     var appCategories = [Category]()
        let url = "https://api.letsbuildthatapp.com/appstore/featured"
    let api_url = URL(string: url)
        print("Comes IN")
        URLSession.shared.dataTask(with: api_url!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                
            }
            
            do {
                
                let modeled = try JSONDecoder().decode(FeaturedApps.self, from:data!)
               
                
                for appc in modeled.categories!
                {
                    let singleCategory = Category()
                    singleCategory.name = appc.name
                    singleCategory.type = appc.type
                    
                    var appsInc = [App]()
                    for app in appc.apps
                    {
                        
                         let singleApp = App()
                        singleApp.Category = app.Category
                        singleApp.Price = app.Price
                        singleApp.Id = app.Id
                        singleApp.Name = app.Name
                        singleApp.ImageName = app.ImageName
                        appsInc.append(singleApp)
                    
                    }
                    
                    singleCategory.apps = appsInc
                    
                    appCategories.append(singleCategory)
                
                    
                  

                }
                
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(modeled)
                })
                
                

                
                

 
              
            } catch let err {
                print(err)
            }
            
        }) .resume()
       
    
    }
    
    static func returnAppCategories() -> [Category] {
        
    
        var sampleApp: Category = Category()
        var aps = [App]()
        
        let frozenApp: App = App()
        frozenApp.Name = "Disney Build it: Frozen"
        frozenApp.Category = "Entertainment"
        frozenApp.Price = CGFloat(3.65)
        frozenApp.ImageName = "frozen"
        
        let bestNewGamesCategory = Category()
        bestNewGamesCategory.name = "Best New Games"
        
        var bestNewGamesApps = [App]()
        
        let telepaintApp = App()
        telepaintApp.Name = "Telepaint"
        telepaintApp.Category = "Games"
        telepaintApp.ImageName = "telepaint"
        telepaintApp.Price = CGFloat(2.99)
        
        bestNewGamesApps.append(telepaintApp)
        
        bestNewGamesCategory.apps = bestNewGamesApps
        aps.append(frozenApp)
        
     
      sampleApp.name = "Best new apps"
     sampleApp.apps = aps
        
        return [sampleApp,bestNewGamesCategory]
        
    }
    
}
class App: Decodable {
   
    var Name: String?
    var Category: String?
    var ImageName: String?
    var Id: Int?
    var Price: CGFloat?
}

class AppDetails: Decodable{
    
    var Name: String?
    var Category: String?
    var ImageName: String?
    var Id: CGFloat?
    var Price: CGFloat?
    var Screenshots =  [String]()
    var description: String?
    var appInformation = [AppDetail]()
    
    static func getAppDetails(id_app: Int,completionHandler: @escaping (AppDetails) -> ()) {
        
        let url = "https://api.letsbuildthatapp.com/appstore/appdetail?id=\(id_app)"
        print(url)
        let api_url = URL(string: url)
        
        print("Comes IN")
        URLSession.shared.dataTask(with: api_url!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                
            }

            do {
                
                let modeled = try JSONDecoder().decode(AppDetails.self, from:data!)
               print(modeled)
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(modeled)
                })
      
                
            } catch let err {
                print(err)
            }
            
        }) .resume()
    
    
    }
        
    
    
}
class AppDetail: Decodable{
    
    var Name: String?
    var Value: String?
    
    
}
