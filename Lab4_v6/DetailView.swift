//
//  DetailView.swift
//  Lab4_v6
//
//  Created by Mai Dao on 10/30/16.
//  Copyright © 2016 Mai Dao. All rights reserved.
//

import UIKit

class DetailView: UIViewController {

    @IBOutlet weak var detailPhoto: UIImage!
   
    @IBOutlet weak var namePhoto: UILabel!
    
    @IBOutlet weak var infoPhoto: UITextView!
    
    @IBOutlet weak var infoCollectionView: UICollectionView!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loading.startAnimating()

    }

    func getInfoFlickrPhoto (id: String)
    {
//        let id: String!
//        let stringUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=ac8085afa1dad48165a624a579e774c4&format=json&nojsoncallback=1&photo_id=\(id)"
//        let encodedStringUrl = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        
//        let infoUrl = URL(string: encodedStringUrl!)
//        
//        let jsonString = try String(contentsOf: infoUrl!)
//        
//        let jsonData = jsonString.data(using: .utf8)
//        
//        let jsonJSON = try JSONSerialization.jsonObject(with: jsonData!, options: [])
//        
//        if let dictionary = jsonJSON as? [String: Any]
//        {
//            let infoPhoto = dictionary["photo"] as? Any
//        }
        
        
    }


}
