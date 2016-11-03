//
//  DetailView.swift
//  Lab4_v6
//
//  Created by Mai Dao on 10/30/16.
//  Copyright © 2016 Mai Dao. All rights reserved.
//

import UIKit

class DetailView: UIViewController {

    @IBOutlet var detailPhoto: UIImageView!
   
    @IBOutlet  var namePhoto: UILabel!
    
    @IBOutlet  var infoPhoto: UITextView!
    
    @IBOutlet  var infoCollectionView: UICollectionView!
    
    @IBOutlet  var loading: UIActivityIndicatorView!
    
    var detailImage = UIImage()
    var nameImage = String()
    var urlString : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   //     self.loading.startAnimating()
        detailPhoto.image = detailImage
        namePhoto.text = nameImage
    }

    func getInfoFlickrPhoto (id: String)
    {
        urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=ac8085afa1dad48165a624a579e774c4&format=json&nojsoncallback=1&photo_id=\(nameImage)"
        
        let encodedStringUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let infoUrl = URL(string: encodedStringUrl!)
        
        let jsonString = try? String(contentsOf: infoUrl!)
        
        let jsonData = jsonString?.data(using: .utf8)
        
        do {
            let object = try JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments)
            if let dictionary = object as? [String: AnyObject] {
                let infoPhto = dictionary["photo"] as? Any
            }
        } catch {
            // Handle Error
        }


        
        
        
    }


}
