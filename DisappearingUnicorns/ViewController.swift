//
//  ViewController.swift
//  DisappearingUnicorns
//
//  Created by Chris Chau on 2019-09-24.
//  Copyright © 2019 Chris Chau. All rights reserved.
//

import UIKit
import Foundation
import UIKit


class ViewController: UIViewController {

   
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var pointsLabel: UILabel!
    
    var gameButtons = [UIButton]()
    var gamePoints = 0
    var state: gameState?
    var timer : Timer?
    var currentButton : UIButton!
    
    enum gameState {
        
        case gameover
        case playing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Hiding points label
        pointsLabel.isHidden = true
        gameButtons = [goodButton, badButton]
        
        setupFreshGameState()
        print("... GameState loaded")
    }

    // Action muthod for whenever button is pressed
    @IBAction func startPressed(_ sender: Any) {
        startNewGame()
        print("Start pressed")
    }
    
    @IBAction func goodPressed(_ sender: Any) {
        gamePoints = gamePoints + 1
        updatePointsLabel(gamePoints)
        goodButton.isHidden = true
        timer?.invalidate()
        oneGameRound()
        print("Good pressed")
    }
    
    @IBAction func badPressed(_ sender: Any) {
        badButton.isHidden = true
        timer?.invalidate()
        gameOver()
    }
    
    @IBAction func leaderboardPressed(_ sender: Any) {
        print("Leaderboard pressed")
    }
    // Game Helper Functions added in at 15:00

    func displayRandomButton(){
        for myButton in gameButtons{
            myButton.isHidden = true
        }
        let buttonIndex = Int.random(in: 0..<gameButtons.count)
        currentButton = gameButtons[buttonIndex]
        currentButton.center = CGPoint(x: randomXCoordinate(), y: randomYCoordinate())
        currentButton.isHidden = false
    }

    func gameOver() {
        state = gameState.gameover
        pointsLabel.textColor = .brown
        setupFreshGameState()
        
        let gameData = GameData()
        gameData.savePoints(gamePoints, for: "Chris")
    }

    func setupFreshGameState() {
        startGameButton.isHidden = false
        leaderboardButton.isHidden = false
        
        for mybutton in gameButtons {
            mybutton.isHidden = true
        }
        pointsLabel.alpha = 0.15
        currentButton = goodButton
        state = gameState.playing
        
    }
    func randCGFloat(_ min: CGFloat, _ max: CGFloat) -> CGFloat{
        return CGFloat.random(in: min..<max)
    }

    func randomXCoordinate() -> CGFloat {
        let left = view.safeAreaInsets.left + currentButton.bounds.width
        let right = view.bounds.width - view.safeAreaInsets.right - currentButton.bounds.width
        return randCGFloat(left, right)
    }
    func randomYCoordinate() -> CGFloat {
        let top = view.safeAreaInsets.top + currentButton.bounds.height
        let bottom = view.bounds.height - view.safeAreaInsets.bottom - currentButton.bounds.height
        return randCGFloat(top,bottom)
    }
    func updatePointsLabel(_ newValue: Int) {
        pointsLabel.text = "\(newValue)"
    }


    // Game logic
    
    
    func startNewGame() {
        startGameButton.isHidden = true
        leaderboardButton.isHidden = true
        gamePoints = 0
        updatePointsLabel(gamePoints)
        pointsLabel.textColor = .magenta
        pointsLabel.isHidden = false
        oneGameRound()
    }
    
    func oneGameRound() {
        updatePointsLabel(gamePoints)
        displayRandomButton()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            if self.state == gameState.playing {
                if self.currentButton == self.goodButton {
                    self.gameOver()
                    print("gameover")
                } else {
                    self.oneGameRound()
                }
            }
        }
        
    }
    
    
}

