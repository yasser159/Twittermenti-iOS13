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
import SwiftyJSON
//import IQKeyboardManagerSwift



class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let tweetCount = 100
    
    let sentimentClassifier = TweetSentimentModelMaker()
    
    
    //____________________________


    //____________________________
    
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
                    fatalError("Couldn't find file 'Secret.plist'.")
        }
     
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API-Secret") as? String else {
                    fatalError("Couldn't find key 'API-Secret' in 'Secret.plist'.")
            }
            return value
        }
    }
     
    var swifter = Swifter(consumerKey: "dummy key", consumerSecret: "dummy Secret")
    override func viewDidLoad() {
        swifter = Swifter(consumerKey: apiKey, consumerSecret: apiKeySecret)
        
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
    }

    @IBAction func predictPressed(_ sender: Any) {
fetchTweet()
    
    }
    
    func fetchTweet(){
        
        if let searchText = textField.text {
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended, success: { (results, metadata) in
            
                var tweets = [TweetSentimentModelMakerInput]()
                
                for i in 0..<self.tweetCount {
                    if let tweet = results[i]["full_text"].string {
                        let tweetForClassification = TweetSentimentModelMakerInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }
                
                self.makePrediction(With: tweets)
                
                //print(tweet)
                //            if let tweet = results[0]["full_text"].string {
                //                print(tweet)}
                //print(results)
            }) { (error) in
                print("There was an error with the Twitter API Request, \(error)")
            }
            
            //        let prediction = try! sentimentClassifier.prediction(text: "@Apple is the best company!")
            //        print(prediction.label)
        }
    }
    
    func makePrediction(With tweets: [TweetSentimentModelMakerInput]){
        do {
            let predictions = try self.sentimentClassifier.predictions(inputs:tweets)
            
            var sentimentScore = 0
            
            for pred in predictions {
                let sentiment = pred.label
                
                if sentiment == "Pos" {
                    sentimentScore += 1
                } else if sentiment == "Neg"{
                    sentimentScore -= 1
                }
                //print(pred.label)
            }
            
            updateUI(with: sentimentScore)
            
        } catch {
            print("There was an error with making a prediction, \(error)")
        }    }
    
    func updateUI(with sentimentScore: Int){
        
        if sentimentScore > 20 {
            self.sentimentLabel.text = "😍"
        } else if sentimentScore > 10 {
            self.sentimentLabel.text = "😀"
        } else if sentimentScore > 0 {
           self.sentimentLabel.text = "🙂"
        } else if sentimentScore == 0 {
            self.sentimentLabel.text = "😐"
       } else if sentimentScore > -10 {
           self.sentimentLabel.text = "😕"
       } else if sentimentScore > -20 {
          self.sentimentLabel.text = "😡"
      } else  {
          self.sentimentLabel.text = "🤮"
      }
        
    }
    
}

//        swifter.searchTweet(using: <#T##String#>, geocode: <#T##String?#>, lang: <#T##String?#>, locale: <#T##String?#>, resultType:
//        <#T##String?#>, count: <#T##Int?#>, until: <#T##String?#>, sinceID: <#T##String?#>, maxID: <#T##String?#>, includeEntities: <#T##Bool?#>,
//        callback: <#T##String?#>, tweetMode: <#T##TweetMode#>, success: <#T##Swifter.SearchResultHandler?##Swifter.SearchResultHandler?##(JSON, _ searchMetadata: JSON) -> Void#>, failure: <#T##Swifter.FailureHandler##Swifter.FailureHandler##(_ error: Error) -> Void#>)
