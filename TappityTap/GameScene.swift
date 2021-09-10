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
    var button1 = SKNode()
    var button2 = SKNode()
    var button3 = SKNode()
    
    let buttonLabel1 = SKLabelNode()
    let buttonLabel2 = SKLabelNode()
    let buttonLabel3 = SKLabelNode()
    let coinLabel = SKLabelNode()
    //let tapLabel = SKLabelNode()
    var systemMessageLabel = SKLabelNode()
    var timeLabel = SKLabelNode()
    var coins: Int = 0
    //var tapCount: Int = 0
    var timeCount: Int = 0
    #warning("SKMultilineLabel class does not allow to init the game")
    // SpriteKit SKLabels do not accept multiline strings. Substituting SKLabel for SKMultilineLabel: https://gist.github.com/craiggrummitt/03bfa93c07e247ee9358
    //let descriptionLabel: SKMultilineLabel = SKMultilineLabel(text:"", labelWidth: 0, pos: CGPoint(x: 0, y: 0))
    let descriptionLabel = SKLabelNode()
    var descriptions = [String:String]()
    
    let levelLabel = SKLabelNode()
    var currentLevel: Int = 0
    /* Decision-making structures -> Choices:
     - Generate $+ when away
     - Generate $+ from own taps
     - Save up for upgrade that gives $x
     - Purchase cheap upgrades for small $+
     */
    
    /// Initial Game Setup:
    func gameSetup(){
        
        // DEBUG:
        Debugger.debug(active: false, message: "Scene Size", item: scene!.size) // Scene size: Optional((750.0, 1334.0))
        Debugger.debug(active: false, message: "Frame Size", item: view?.frame.size) // Frame size: Optional((320.0, 480.0))
        Debugger.debug(active: false, message: "Bounds Size", item: view?.bounds.size) // Bounds size: Optional((320.0, 480.0))
        
        descriptions = Constants.descriptions
        //tapCount =0
        currentLevel = 0
        timeCount = 0
        coins = 100
        buttonLabel1.text = "Tap me 1!"
        buttonLabel2.text = "Tap me 2!"
        buttonLabel3.text = "Tap me 3!"
        //tapLabel.text = "\(tapCount)"
        coinLabel.text = "$\(coins)"
        timeLabel.text = "\(timeCount)"
        levelLabel.text = "Level: \(currentLevel)"
        
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        systemMessageLabel.isHidden = true
        systemMessageLabel.text = ""
        
        // MultiLineLabel:
        //descriptionLabel.text = "Level: 0 \nDescription: Lorem Ipsum "
        //descriptionLabel.labelWidth = Int(( self.frame.width / 3.0 ))
        
        
        startTimer()
        
    }
    
    func startTimer(){
        
        let wait = SKAction.wait(forDuration: 1.0)
        let run = SKAction.run( { self.counter() } )
        let sequence = SKAction.sequence([wait, run])

        timeLabel.run(SKAction.repeatForever(sequence))
    }
    
    func counter(){
        timeCount += 1 // +1 second every second
        //tapCount += 1 // +1 automatic tap every second
        coins += 1 // +1 coin every second
        // DEBUG
        //print(timeCount)
    }
    
    func checkIfLevelUp(){
        // Work in progress - Quick level up logic for debugging:
        if coins >= 110 && coins < 111 {
            currentLevel += 1
        } else if coins >= 120 && coins < 121 {
            currentLevel += 1
        }
    }
    
    override func didMove(to view: SKView) {
        
        gameSetup()
        
        /// BUTTON 1 logic - Sprite node that will act as a button:
        button1 = SKSpriteNode(color: UIColor.systemRed, size: CGSize(width: 100.00, height: 44.00))
        button1.position = CGPoint(x: -320, y: -320) // BottomLeft
        button1.zPosition = 1
        self.addChild(button1)
        
        /// BUTTON 2 logic - Sprite node that will act as a button:
        button2 = SKSpriteNode(color: UIColor.systemBlue, size: CGSize(width: 100.00, height: 44.00))
        button2.position = CGPoint(x: 0, y: -320) // BottomCenter
        button2.zPosition = 1
        self.addChild(button2)
        
        /// BUTTON 3 logic - Sprite node that will act as a button:
        button3 = SKSpriteNode(color: UIColor.systemGreen, size: CGSize(width: 100.00, height: 44.00))
        button3.position = CGPoint(x: 320, y: -320) // BottomRight
        button3.zPosition = 1
        self.addChild(button3)
        
        /// BUTTON 1 TEXT
        //buttonLabel1.position = CGPoint(x: button1.frame.midX, y: button1.frame.midY)
        buttonLabel1.verticalAlignmentMode = .center
        buttonLabel1.horizontalAlignmentMode = .center
        buttonLabel1.zPosition = 2
        buttonLabel1.fontSize = 20.0
        buttonLabel1.fontColor = UIColor.white
        button1.addChild(buttonLabel1)
        
        /// BUTTON 2 TEXT
        //buttonLabel2.position = CGPoint(x: button2.frame.midX, y: button2.frame.midY)
        buttonLabel2.verticalAlignmentMode = .center
        buttonLabel2.horizontalAlignmentMode = .center
        buttonLabel2.zPosition = 2
        buttonLabel2.fontSize = 20.0
        buttonLabel2.fontColor = UIColor.white
        button2.addChild(buttonLabel2)
        
        /// BUTTON 3 TEXT
        //buttonLabel3.position = CGPoint(x: button3.frame.midX, y: button3.frame.midY)
        buttonLabel3.verticalAlignmentMode = .center
        buttonLabel3.horizontalAlignmentMode = .center
        buttonLabel3.zPosition = 2
        buttonLabel3.fontSize = 20.0
        buttonLabel3.fontColor = UIColor.white
        button3.addChild(buttonLabel3)
        
        /// TAP Label logic:
        /// This is invisible at the moment, no need to show. Just sum the value to the total coin.
//        tapLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxX) // TopCenter
//        tapLabel.fontSize = 72.0
//        tapLabel.fontColor = UIColor.white
//        self.addChild(tapLabel)
        
        /// LEVEL:
        levelLabel.position = CGPoint(x: -200, y: 300) // Positioning here needs fixing, attached to label better
        levelLabel.fontSize = 20.0
        levelLabel.fontColor = UIColor.white
        self.addChild(levelLabel)
        
        /// DESCRIPTION logic:
        //descriptionLabel.labelWidth = Int(( self.frame.width / 3.0 ))
        //descriptionLabel.preferredMaxLayoutWidth = self.frame.width / 3.0
        descriptionLabel.preferredMaxLayoutWidth = 200
        descriptionLabel.position = CGPoint(x: -200, y: 480) // TopLeft
        descriptionLabel.fontSize = 32.0
        descriptionLabel.fontColor = UIColor.white
        self.addChild(descriptionLabel)
        
        /// COINS logic:
        coinLabel.position = CGPoint(x: 0, y: 480) // TopCenter
        coinLabel.fontSize = 64.0
        coinLabel.fontColor = UIColor.white
        self.addChild(coinLabel)
        
        /// SYSTEMMESSAGE logic:
        systemMessageLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY) // CenterTop
        systemMessageLabel.fontSize = 32.0
        systemMessageLabel.fontColor = UIColor.white
        self.addChild(systemMessageLabel)
        
        /// TIMER logic:
        //timeLabel.position = CGPoint(x: self.frame.minX, y: self.frame.maxY) // TopLeft
        //print("DEBUG: \(self.frame.minX) , \(self.frame.maxY)") // -375.0 , 667.0
        // TIL: The center of the screen is 0,0 in SpriteKit? Not the bottomleft corner?
        timeLabel.position = CGPoint(x: (320-50), y: 480) // TopRight
        timeLabel.fontSize = 32.0
        timeLabel.fontColor = UIColor.white
        self.addChild(timeLabel)

        
    }
    /// Called when the finger is no longer touching the screen (  lifted )
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // Assign the touch
            let touchLoc = touch.location(in: self)
            // Is the touch in the same place?
            if button1.contains(touchLoc) {
                
                descriptionLabel.text = descriptions["Item key 1"]!
                
                if coins >= 5 {
                    //tapCount += 1
                    //coins -= 5 // Removing this for the moment, tapping doesn't cost coins but the opposite:
                    coins += 1
                    //tapLabel.text = "\(tapCount)"
                    coinLabel.text = "$\(coins)"
                    // Debug:
                    //print(count)
                } else {
                    // Debug:
                    systemMessageLabel.isHidden = false
                    systemMessageLabel.text = "Not enough coins!!"
                    //print("Not enough coins")
                }

            }
            if button2.contains(touchLoc) {
                descriptionLabel.text = descriptions["Item key 2"]!
            }
            if button3.contains(touchLoc) {
                descriptionLabel.text = descriptions["Item key 3"]!
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        timeLabel.text = "\(timeCount)"
        //tapLabel.text = "$\(tapCount)"
        coinLabel.text = "$\(coins)"
        levelLabel.text = "\(currentLevel)"
        
        // Level up checker, temporary for debugging and testing:
        if coins < 130 {
            checkIfLevelUp()
        }
    }
}
