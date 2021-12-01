//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    
    //-----------------------
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "Secret", ofType: "plist") else {
                    fatalError("Couldn't find file 'Config.plist'.")
        }
     
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API-Key") as? String else {
                    fatalError("Couldn't find key 'API-Key' in 'Secret.plist'.")
            }
            return value
        }
    }
     
    private var apiKeySecret: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "Secret", ofType: "plist") else {
                    fatalError("Couldn't find file 'Config.plist'.")
        }
     
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API-Secret") as? String else {
                    fatalError("Couldn't find key 'API-Secret' in 'Secret.plist'.")
            }
            return value
        }
    }
     
    var swifter = Swifter(consumerKey: "dummy key", consumerSecret: "dummy Secret")
    
    //------------------------

    //let swifter = Swifter(consumerKey: "QQUM1jrh1qgDnjqg51eMogXMl", consumerSecret: "cPXoQsCyxfwmyjS1y59lmpWTLscfnkLMzeNO0wRBmzHrIf2Xl7")
    
    override func viewDidLoad() {
         
        swifter = Swifter(consumerKey: apiKey, consumerSecret: apiKeySecret)
        
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        

        
        swifter.searchTweet(using: "@Apple", success: { (results, metadata) in
            
            print(results)
        
        }) { (error) in
            print("There was an error with the Twitter API Request, \(error)")
        }
        
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

