//
//  GameScene.swift
//  TappityTap
//
//  Created by Gabriel Maldonado Almendra on 9/9/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    /// Core loop based on a button: Tap as fast as you can:
    var button = SKNode()
    let buttonLabel = SKLabelNode()
    let coinLabel = SKLabelNode()
    let tapLabel = SKLabelNode()
    var systemMessageLabel = SKLabelNode()
    var coins: Int = 0
    var tapCount: Int = 0
    
    /* Decision-making structures -> Choices:
     - Generate $+ when away
     - Generate $+ from own taps
     - Save up for upgrade that gives $x
     - Purchase cheap upgrades for small $+
     */
    
    /// Initial Game Setup:
    func gameSetup(){
        tapCount = 0
        coins = 100
        buttonLabel.text = "Tap me!"
        tapLabel.text = "\(tapCount)"
        coinLabel.text = "\(coins)"
        
        systemMessageLabel.isHidden = true
        systemMessageLabel.text = ""
        
    }
    
    override func didMove(to view: SKView) {
        
        gameSetup()
        /// BUTTON logic - Sprite node that will act as a button:
        button = SKSpriteNode(color: UIColor.systemRed, size: CGSize(width: 100.00, height: 44.00))
        button.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(button)
        #warning("buttonLabel needs fixing and to appear properly with the button sprite")
        buttonLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY) // CenterCenter
        buttonLabel.fontSize = 32.0
        buttonLabel.fontColor = UIColor.white
        self.addChild(buttonLabel)
        
        /// TAP Label logic:
        tapLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxX) // TopCenter
        tapLabel.fontSize = 72.0
        tapLabel.fontColor = UIColor.white
        self.addChild(tapLabel)
        
        /// COINS logic:
        coinLabel.position = CGPoint(x: self.frame.midX, y: self.frame.minX) // BottomCenter
        coinLabel.fontSize = 72.0
        coinLabel.fontColor = UIColor.white
        self.addChild(coinLabel)
        
        /// SYSTEMMESSAGE logic:
        systemMessageLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxX) // CenterTop
        systemMessageLabel.fontSize = 72.0
        systemMessageLabel.fontColor = UIColor.white
        self.addChild(systemMessageLabel)
        
    }
    /// Called when the finger is no longer touching the screen (  lifted )
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // Assign the touch
            let touchLoc = touch.location(in: self)
            // Is the touch in the same place?
            if button.contains(touchLoc) {
                
                if coins >= 5 {
                    tapCount += 1
                    coins -= 5
                    tapLabel.text = "\(tapCount)"
                    coinLabel.text = "\(coins)"
                    // Debug:
                    //print(count)
                } else {
                    // Debug:
                    systemMessageLabel.isHidden = false
                    systemMessageLabel.text = "Not enough coins!!"
                    //print("Not enough coins")
                }

            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
    
    }
}
