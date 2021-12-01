//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = TweetSentimentModelMaker()
    
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
    // nothing to see here updated
    
    override func viewDidLoad() {
         
        swifter = Swifter(consumerKey: apiKey, consumerSecret: apiKeySecret)
        
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        

        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100,tweetMode: .extended, success: { (results, metadata) in
            print(results)
        }) { (error) in
            print("There was an error with the Twitter API Request, \(error)")
        }
        
        
        
//        swifter.searchTweet(using: <#T##String#>, geocode: <#T##String?#>, lang: <#T##String?#>, locale: <#T##String?#>, resultType:
//            <#T##String?#>, count: <#T##Int?#>, until: <#T##String?#>, sinceID: <#T##String?#>, maxID: <#T##String?#>, includeEntities: <#T##Bool?#>,
//        callback: <#T##String?#>, tweetMode: <#T##TweetMode#>, success: <#T##Swifter.SearchResultHandler?##Swifter.SearchResultHandler?##(JSON, _ searchMetadata: JSON) -> Void#>, failure: <#T##Swifter.FailureHandler##Swifter.FailureHandler##(_ error: Error) -> Void#>)
        
        
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

