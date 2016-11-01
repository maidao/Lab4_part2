//
//  FlickrPhoto.swift
//  Lab4_v6
//
//  Created by Mai Dao on 10/29/16.
//  Copyright © 2016 Mai Dao. All rights reserved.
//

import Foundation
import UIKit

class FlickrPhoto {
    var id: String!
    var server: String!
    var secret: String!
    var farm : Int!
    var image : UIImage!
    var num: Int!
    
    init() {
        
    }
    
    init(id:String, secret:String, server:String, farm:Int, num:Int)
    {
        self.id = id
        self.secret = secret
        self.server = server
        self.farm = farm
        self.num = num
    }
    
    func getImage()
    {
        DispatchQueue.global(qos: .background).async
        {
            do
            {
                let stringUrl = "https://farm\(self.farm!).static.flickr.com/\(self.server!)/\(self.id!)_\(self.secret!).jpg"
                print("downloading num \(self.num!) at \(stringUrl)")
                try self.image = UIImage(data: Data(contentsOf: URL(string: stringUrl)!))
            }
            catch
                
            {
                print("error downloading image")
            }
            DispatchQueue.main.async
            {
                NotificationCenter.default.post(name: NSNotification.Name("photoDownloaded"), object: self)
            }
        }
        
    }
}
