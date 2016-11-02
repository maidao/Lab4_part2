//
//  CollectionView.swift
//  Lab4_v6
//
//  Created by Mai Dao on 10/29/16.
//  Copyright © 2016 Mai Dao. All rights reserved.
//

import UIKit

class CollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var keyWords: String!
    var photosArray = [FlickrPhoto]()
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    @IBOutlet weak var myActive: UIActivityIndicatorView!
    var currentPage = 1
    var perPage = 50
    var currentKeyword = "Bird"
    var previousPhotosArray = [UIImage]()
    var indexDetail = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        self.myActive.startAnimating()
        if let searchCondition:String = keyWords{
            getIdFlickrPhotos(keyword:searchCondition)
        }
        
        handleNotification()
    }
    
    func handleNotification()
    {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("photoDownloaded"), object:
            nil, queue: nil) { notification in
            let photo = notification.object as! FlickrPhoto
            print("received \(photo.id) -- num \(photo.num)")
            self.photosCollectionView.reloadItems(at: [IndexPath(row: photo.num, section: 0)])
            self.myActive.isHidden = true
            self.myActive.stopAnimating()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollection", for: indexPath) as! ACell
       // cell.addSubviews()
        DispatchQueue.main.async(execute:
        {
            if let image = self.photosArray[indexPath.row].image
            {
                cell.imageView.image = image
                self.previousPhotosArray.append(image)
                self.indexDetail.append(indexPath.row)
                
            }
        })
        
        if (cell.imageView.layer.animationKeys() == nil)
        {
            let transitions = [kCATransitionFromLeft,kCATransitionFromRight,kCATransitionFromTop,kCATransitionFromBottom]
            let transition = CATransition()
            transition.type = kCATransitionMoveIn
            transition.subtype = transitions[Int(arc4random_uniform(UInt32(transitions.count)))]
            cell.imageView.layer.add(transition, forKey:nil)
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
//    {
//        
////        DispatchQueue.main.async(execute:
////            {
////                if let image = self.photosArray[indexPath.row].image
////                {
////                    self.previousPhotosArray.append(image)
////                    print(self.previousPhotosArray)
////                    
////                }
////        })
////            
////        
//
//        
//    }
    

    
    
    func getIdFlickrPhotos(keyword: String) {
        
        do
        {
            let stringUrl = "https://flickr.com/services/rest/?method=flickr.photos.search&api_key=ac8085afa1dad48165a624a579e774c4&format=json&nojsoncallback=1&text=\(keyword)&per_page=\(perPage)&page=1"
            
            let encodedStringUrl = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            let myurl = URL(string: encodedStringUrl!)
            
            let jsonString = try String(contentsOf: myurl!)
            
            let jsonData = jsonString.data(using: .utf8)
            
            let jsonJSON = try JSONSerialization.jsonObject(with: jsonData!, options: [])
            
            
            
            if let dictionary = jsonJSON as? [String: Any]
            {
                if let photos = dictionary["photos"] as? [String: Any]
                {
                    if let photo = photos["photo"] as? [[String: AnyObject]]{
                        
                        for(i, p) in photo.enumerated(){
                            
                            let myPhoto:FlickrPhoto = FlickrPhoto()
                            
                            if let id = p["id"] as? String{
                                myPhoto.id = id
                            }
                            if let farm = p["farm"] as? Int{
                                myPhoto.farm = farm
                            }
                            if let server = p["server"] as? String{
                                myPhoto.server = server
                            }
                            if let secret = p["secret"] as? String{
                                myPhoto.secret = secret
                            }
                            myPhoto.num = i
                            photosArray.append(myPhoto)
                        }
                        
                    }
                }
                
            }
            
            if(photosArray.count > 0)
            {
                for p in photosArray {
                    p.getImage()
                }
                
            }
            
            photosCollectionView.reloadData()
        }
        catch
        {
            print("Error getting url content")
        }
        
    }
    
    func searchFlickr(tag: Int)
    {
        for photo in photosArray
        {
            DispatchQueue.global(qos: .background).async
            {
                photo.getImage()
                
                if (self.photosArray.count == self.perPage)
                {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10)
                    {
                        self.currentPage = self.currentPage + 1
                        self.searchFlickr(tag: self.currentPage)
                    }
                
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
            performSegue(withIdentifier: "ShowDetailPhoto", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        assert(sender as? UICollectionViewCell != nil, "sender is not a collection view")
        
        if (segue.identifier == "ShowDetailPhoto")
        {
       
            let indexPath = sender
            let detailView = segue.destination as? DetailView
            detailView?.detailPhoto = self.previousPhotosArray[indexPath]
        }
        else
        {
            print ("Error sender is not a cell or cell is not in collectionView")
        }
    }
    
    
    

}

