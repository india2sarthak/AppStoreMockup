//
//  ViewController.swift
//  AppStoreV1
//
//  Created by Sarthak Mishra on 21/06/18.
//  Copyright © 2018 Sarthak Mishra. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    let cellID = "cellId"
    let largeCellID = "largeCellId"
    let headerCelldId = "headerCellID"
    var appCategories: FeaturedApps?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Category.getAppStoreData { (appCategories) -> () in
          
            self.appCategories = appCategories
            self.collectionView?.reloadData()
        }
       
      navigationItem.title = "Featured"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellID) //Add the identifier to the
        
         collectionView?.register(LargeAppCategory.self, forCellWithReuseIdentifier: largeCellID) //Add the identifier to
         collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCelldId)
        
    }
  
    func showAppDetails(app: App)
    {
        let flowLayout = UICollectionViewFlowLayout()
        let appsDetailsVC = AppsDetailsController(collectionViewLayout: flowLayout)
        appsDetailsVC.app_id = app.Id
        navigationController?.pushViewController(appsDetailsVC, animated: true)
        
        
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if let count = appCategories?.categories?.count{
                return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    if(indexPath.row==2)
        {
            
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellID, for: indexPath) as! LargeAppCategory
            cell.appCategory = appCategories?.categories?[indexPath.row]
            return cell
        
        }
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell //Right
        cell.appCategory = appCategories?.categories?[indexPath.row]
        cell.featuredAppsController = self
        return cell
        
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
       
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCelldId, for:indexPath) as! Header
      
        cell.appCategory = appCategories?.bannerCategory
    
        return cell
    
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(indexPath.row==2){
            return CGSize(width: view.frame.width, height: 160)
            
        }else{
        return CGSize(width: view.frame.width, height: 230)
        }
    }

}
class LargeAppCategory: CategoryCell {
    
    let appCellIdBig = "appCellBig"
    override func setUpViews() {
        super.setUpViews()
        
        appsCollectionView.register(AppCellBig.self, forCellWithReuseIdentifier: appCellIdBig)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appCellIdBig, for: indexPath) as! AppCellBig
        cell.app = appCategory?.apps[indexPath.row]
        return cell


    }
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200,height: frame.height-32)
    }
   
    class AppCellBig: AppCell{
        
        override func setUpViews() {
            
            imageApp.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageApp)
           
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageApp]))
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageApp]))
            
        }
        
    }
    
    
    
}

class Header: CategoryCell{
    
    let bannerCellID = "bannerCellId"
    override func setUpViews() {
        
        
        appsCollectionView.dataSource = self
        appsCollectionView.delegate = self
        
        appsCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: bannerCellID)
        addSubview(appsCollectionView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = appsCollectionView.dequeueReusableCell(withReuseIdentifier: bannerCellID, for: indexPath) as!  AppCell
        cell.app = appCategory?.apps[indexPath.row]
        return cell
    
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: frame.width / 2 + 50, height: frame.height)
    
    }
    
    class BannerCell: AppCell{
        
        override func setUpViews() {
           
            imageApp.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
            imageApp.layer.borderWidth = 0.5
            imageApp.layer.cornerRadius = 0
            imageApp.layer.masksToBounds = true
            imageApp.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageApp)
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageApp]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageApp]))
            
            
            
        
        }
    }
}


