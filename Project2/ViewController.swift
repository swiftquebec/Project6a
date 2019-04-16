//
//  ViewController.swift
//  Project2
//
//  Created by Gregory Leck on 2019-04-15.
//  Copyright © 2019 Gregory Leck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numberQuestionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        // Add borders to buttons
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        // UIColor has a lightGray property
        // But to add to borderColor (which belongs to CALayer),
        // lightGray is converted to a cgColor (which sits at the
        // same level as CALayer).
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        // Pass nil to satisfy the parameter requirements.
        askQuestion(action: nil)
    }
    
    // UIAlertAction parameter necessary given that askQuestion()
    // is called in UIAlertController closure.
    func askQuestion(action: UIAlertAction!) {
        
        // automagically shuffle the array of countries
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        modifyTitle()
        
        numberQuestionsAsked += 1
    }
    
    func modifyTitle() {
    // title modified to display correct answer uppercased
    title = "\(countries[correctAnswer].uppercased()) -- Score: \(score)"
    }
    
    func resetGame(action: UIAlertAction!) {
        score = 0
        numberQuestionsAsked = 0
        askQuestion(action: nil)
    }

    // All three buttons are attached to the same IBAction but have different tags (0...2)
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong. That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        modifyTitle()
        
        if numberQuestionsAsked == 10 {
            // Pop-up of AlertController
            // Note: Can choose .alert or .actionSheet for preferred style
            let ac = UIAlertController(title: title, message: "Your FINAL score is \(score)", preferredStyle: .alert)
            // Add button to the AlertController (i.e., UIAlertAction)
            // "handler" is looking for a closure (code that is executed when button is tapped.
            // We want the game to continue when tapped so we pass in the askQuestion method
            // (NB: xcode want askQuestion() to accept a UIAction parameter)
            ac.addAction(UIAlertAction(title: "Play Again?", style: .default, handler: resetGame))
            // Then present the UIAlertController
            present(ac, animated: true)
        } else {
            // Pop-up of AlertController
            // Note: Can choose .alert or .actionSheet for preferred style
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            // Add button to the AlertController (i.e., UIAlertAction)
            // "handler" is looking for a closure (code that is executed when button is tapped.
            // We want the game to continue when tapped so we pass in the askQuestion method
            // (NB: xcode want askQuestion() to accept a UIAction parameter)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            // Then present the UIAlertController
            present(ac, animated: true)
        }
    }
}
