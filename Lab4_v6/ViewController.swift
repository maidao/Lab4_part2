//
//  ViewController.swift
//  Lab4_v6
//
//  Created by Mai Dao on 10/29/16.
//  Copyright © 2016 Mai Dao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var searchKeyWord: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchKeyWord.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchKeyWord.resignFirstResponder()
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowCollectionView")
        {
            let collectionView = segue.destination as? CollectionView
            collectionView?.keyWords = searchKeyWord.text
        }
    }

}

