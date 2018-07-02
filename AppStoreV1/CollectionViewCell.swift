//
//  CollectionViewCell.swift
//  AppStoreV1
//
//  Created by Sarthak Mishra on 21/06/18.
//  Copyright © 2018 Sarthak Mishra. All rights reserved.
//

import UIKit
class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
 
    var featuredAppsController: ViewController?
    var appCategory: Category? {
        
        didSet{
            
            if let name = appCategory?.name{
                
                titleCategoryLabel.text = name
            }
            appsCollectionView.reloadData()
            
        }
        
    }
    let appCellId = "appCellID"
    override init(frame: CGRect)
    {
        
        super.init(frame: frame)
        
        setUpViews()
        
    }
    let dividerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not initialized!")
    }
    let titleCategoryLabel: UILabel = {
        
        let lb = UILabel()
        lb.text = "Best new apps"
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
        
    }()
    let appsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
    
    func setUpViews()
    {
        
        backgroundColor = UIColor.clear
        
        addSubview(appsCollectionView)
        addSubview(dividerView)
        addSubview(titleCategoryLabel)
        
        
        appsCollectionView.delegate = self
        appsCollectionView.dataSource = self
        appsCollectionView.register(AppCell.self, forCellWithReuseIdentifier: appCellId)
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleCategoryLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v3(30)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView,"v1":dividerView,"v3":titleCategoryLabel]))
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategory?.apps.count {
            return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: frame.height-32)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appCellId, for: indexPath) as! AppCell //Right now created!
        cell.app = appCategory?.apps[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Clicked!! \(appCategory?.apps[indexPath.row].Name)")
        featuredAppsController?.showAppDetails(app: (appCategory?.apps[indexPath.row])!)
        
        
        
    }
    
    
}
class AppCell: UICollectionViewCell{
  
    
    
    
    
    override init(frame: CGRect)
    {
        
        super.init(frame: frame)
       
        self.setUpViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not initialized!")
    }
    
    
    var app: App?{
        
        didSet{
            
            if let name  =  app?.Name {
                
                appLabel.text = name
            }
            categoryLabel.text = app?.Category
            if let price = app?.Price{
                
                priceLabel.text = "Rs \(price)"
            }else{
                priceLabel.text = "Free"
            }
            
            if  let image =  app?.ImageName{
                
                imageApp.image = UIImage(named: image)
            }
            
            
        }
        
    }
    
    
    
    let imageApp: UIImageView = {
        let iv =  UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named:  "frozen")
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
        
        
    }()
    
    let appLabel: UILabel = {
        
        let lb = UILabel()
        lb.text = "Disney Build It: Frozen"
        lb.font = UIFont.systemFont(ofSize: 14)
       
        lb.numberOfLines = 2
        return lb
        
    }()
   
    let priceLabel: UILabel = {
        
        let lb = UILabel()
        lb.text = "Free"
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.numberOfLines = 2
        lb.textColor = UIColor.lightGray
        return lb
        
    }()
    
    
    
    let categoryLabel: UILabel = {
        
        let lb = UILabel()
        lb.text = "Entertainment"
        lb.font = UIFont.systemFont(ofSize: 13)
         lb.textColor = UIColor.darkGray
        lb.numberOfLines = 2
        return lb
        
    }()
    
    
    func setUpViews(){
        
        backgroundColor = UIColor.clear
        
        addSubview(imageApp)
        addSubview(appLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
        
        
        
        imageApp.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        appLabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 40)
        categoryLabel.frame = CGRect(x: 0, y: frame.width+38, width: frame.width, height: 20)
        priceLabel.frame = CGRect(x: 0, y: frame.width+52, width:frame.width, height: 20)
        
        
    }
    
}
