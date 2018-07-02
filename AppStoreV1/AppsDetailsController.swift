//
//  AppsDetailsController.swift
//  AppStoreV1
//
//  Created by Sarthak Mishra on 24/06/18.
//  Copyright © 2018 Sarthak Mishra. All rights reserved.
//

import UIKit

class AppsDetailsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var app_id: Int?
    var appDetailArray: AppDetails?
    let headerCellID = "headerCellDetail"
    let screenShotID = "screenShotCell"
    let appDescID = "appDescID"
    let appSpecificsID = "spcrd"
    var selectedApp: App = App()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        AppDetails.getAppDetails(id_app: app_id!) { (appDetails) in
            
            self.appDetailArray = appDetails
            self.selectedApp =  App()
            self.selectedApp.Name = self.appDetailArray?.Name
            self.selectedApp.Price = self.appDetailArray?.Price
            self.selectedApp.Category = self.appDetailArray?.Category
            self.selectedApp.ImageName = self.appDetailArray?.ImageName
            self.collectionView?.reloadData()
        }
          collectionView?.backgroundColor = UIColor.white
          collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellID)
        
          collectionView?.register(ScreenShotsCell.self, forCellWithReuseIdentifier: screenShotID)
         collectionView?.register(AppDescriptio.self, forCellWithReuseIdentifier: appDescID)
        
        collectionView?.register(AppSpecificsCell.self, forCellWithReuseIdentifier: appSpecificsID)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellID, for: indexPath) as! HeaderCell
        cell.app = selectedApp
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        
        if indexPath.item == 1 {
            
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height + 30)
        }else if(indexPath.item == 2)
        {
            return CGSize(width: view.frame.width, height: 420)
        }
        
        return CGSize(width: view.frame.width, height: 170)
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if(indexPath.item == 1)
       {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appDescID, for: indexPath) as! AppDescriptio
        cell.textAttrib = descriptionAttributedText()
        return cell
        
       }else if(indexPath.item == 2)
       {
        print("Does come here!")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appSpecificsID, for: indexPath) as! AppSpecificsCell
        cell.appSingleDetailsArray = appDetailArray?.appInformation
        return cell
        
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenShotID, for: indexPath) as! ScreenShotsCell
        cell.screenshots = appDetailArray?.Screenshots
        return cell
    }
 
    fileprivate func descriptionAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "Description\n", attributes: [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range = NSMakeRange(0, attributedText.string.count)
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: range)
       if let desc = appDetailArray?.description {
            attributedText.append(NSAttributedString(string: desc, attributes: [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 11), NSAttributedStringKey.foregroundColor: UIColor.darkGray]))
        }
        
        return attributedText
    }
    
    



}

class HeaderCell: BaseClass{
    
    var app: App? {
        
        didSet{
            
            if let image =  app?.ImageName {
                imageView.image = UIImage(named: (image))
            appLabel.text = app?.Name
            if let price = app?.Price {
                buyButton.setTitle("Rs\(price)", for: UIControlState())
            }else{
                buyButton.setTitle("Free", for: UIControlState())
            }
            }
        }
    }
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let appLabel: UILabel = {
        
        let labelText = UILabel()
       labelText.font = UIFont.systemFont(ofSize: 16)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.text  = "Okay"
        return labelText
        
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Reviews", "Related"])
        sc.tintColor = UIColor.darkGray
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        return sc
    }()
    let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BUY", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let appDividerView: UIView = {
       
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.2)
        return view
        
    }()
    
    
    
    
    override func setUpViews() {
        
        super.setUpViews()
        addSubview(imageView)
        addSubview(appLabel)
        addSubview(segmentedControl)
        addSubview(buyButton)
        addSubview(appDividerView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0(100)]-8-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView,"v1":appLabel]))
    
       
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-14-[v0(100)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-14-[v0(20)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":appLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-40-[v0]-40-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":segmentedControl]))
     
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(34)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":segmentedControl]))

        
        addConstraintsWithFormat("H:[v0(60)]-14-|", views: buyButton)
        addConstraintsWithFormat("V:[v0(32)]-56-|", views: buyButton)
        
        addConstraintsWithFormat("H:|[v0]|", views: appDividerView)
        addConstraintsWithFormat("V:[v0(1)]|", views: appDividerView)

        
    }
    
    
}
extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}
class ScreenShotsCell: BaseClass, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
   
    var screenshots: [String]!{
        didSet{
            
            appsCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     print("This Came ")
        if let count = screenshots?.count {
            return count
        }
        return 0

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  appsCollectionView.dequeueReusableCell(withReuseIdentifier: appCellId, for: indexPath) as! ScreenShotsImage
        
        cell.singleImage = screenshots![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: frame.height - 18)
    }
    let appsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
    let appDividerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.2)
        return view
        
    }()
    
    let appCellId = "imagesID"
    override func setUpViews() {
        super.setUpViews()
       
        
        addSubview(appsCollectionView)
        addSubview(appDividerView)
        appsCollectionView.delegate = self
        appsCollectionView.dataSource = self
        
        appsCollectionView.register(ScreenShotsImage.self, forCellWithReuseIdentifier: appCellId)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
        
        addConstraintsWithFormat("H:|-14-[v0]|", views: appDividerView)
        
        addConstraintsWithFormat("V:|[v0][v1(1)]|", views: appsCollectionView, appDividerView)
        
        
        
    }
    
}

class AppDescriptio: BaseClass{
  
    var textAttrib: NSAttributedString? {
        
        didSet {
            
    textLabel.attributedText = textAttrib
            
        }
        
    }
    let headerLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Description"
        lab.textColor = UIColor.black
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    
    let textLabel: UITextView = {
        
        
        let label = UITextView()
        label.text = "Description"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    override func setUpViews() {
        super.setUpViews()
        
        addSubview(textLabel)
        addSubview(dividerLineView)
       
        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: textLabel)
        addConstraintsWithFormat("H:|-14-[v0]|", views: dividerLineView)
        
        addConstraintsWithFormat("V:|[v0]-5-[v1(1)]|", views: textLabel, dividerLineView)
        
    }
    
}
class ScreenShotsImage: BaseClass{
    
    var singleImage: String? {
        didSet{
            
            if  let image =  singleImage {
                
                imageView.image = UIImage(named: image)
            }
        }
        
    }
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        return iv
    }()
    
    
    
    override func setUpViews() {
        super.setUpViews()
        print("SooSxxxxx")
       addSubview(imageView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        
        
        
    }
}
class AppSpecificsCell: BaseClass, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var singleAppId: String  = "singleApp"
    var appSingleDetailsArray: [AppDetail]? {
    
        didSet {
    
            appDetailsCv.reloadData()
    
         }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appSingleDetailsArray?.count{
          return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width,height: 10)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = appDetailsCv.dequeueReusableCell(withReuseIdentifier: singleAppId, for: indexPath) as! singleAppDetail
        cell.SingleApp = appSingleDetailsArray?[indexPath.row]
        return cell

    }
    
    let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "Information"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let appDetailsCv: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
    
    
    override func setUpViews() {
        super.setUpViews()
        
        addSubview(appDetailsCv)
        addSubview(informationLabel)
        
        
        appDetailsCv.delegate = self
        appDetailsCv.dataSource = self
        
        appDetailsCv.register(singleAppDetail.self, forCellWithReuseIdentifier: singleAppId)
        
        
        addConstraintsWithFormat("H:|[v0]|", views: appDetailsCv)
        addConstraintsWithFormat("V:|[v0][v1]|", views: informationLabel,appDetailsCv)
        addConstraintsWithFormat("H:|-14-[v0]|", views: informationLabel)
        
        
    }
    
    
}
class singleAppDetail: BaseClass {
    
    
    var SingleApp: AppDetail! {
        
        didSet{
            
            
            categoryLabel.text = "\(SingleApp.Name!)"
            valueLabel.text = "\(SingleApp.Value!)"
        }
    }
    let categoryLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Description"
        lab.textColor = UIColor.gray
        lab.font = UIFont.systemFont(ofSize: 10)
        lab.textAlignment = .right
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    let valueLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Description"
        lab.textColor = UIColor.black
        
        lab.font = UIFont.systemFont(ofSize: 10)
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    
    override func setUpViews() {
        
        addSubview(categoryLabel)
        addSubview(valueLabel)

        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]-8-[v1(280)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":categoryLabel,"v1":valueLabel]))
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-14-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":categoryLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-14-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":valueLabel]))
        
        
        
        
        
    }
    
}
class BaseClass: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpViews()
    {
    
        
    
    }
    
}
