//
//  ViewController.swift
//  Monster
//
//  Created by Lalit on 2016-01-12.
//  Copyright © 2016 Bagga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Monster: MonsterImg!
    @IBOutlet weak var heartImg: DragImage!
    @IBOutlet weak var foodImg: DragImage!
    @IBOutlet weak var firstLifeImage: UIImageView!
    @IBOutlet weak var secondLifeImage: UIImageView!
    @IBOutlet weak var thirdLifeImage: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2        //Property of graphics
    let OPAQUE : CGFloat = 1.0
    let MAX_LIVES = 3
    var timer : NSTimer!
    
    var currentLives = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImg.dropTarget = Monster
        heartImg.dropTarget = Monster
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        firstLifeImage.alpha = DIM_ALPHA
        secondLifeImage.alpha = DIM_ALPHA
        thirdLifeImage.alpha = DIM_ALPHA
        startTimer()
    }
    func startTimer(){
        if timer != nil{
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    func changeGameState()
    {
        currentLives++
        if currentLives == 1{
            firstLifeImage.alpha = OPAQUE
            secondLifeImage.alpha = DIM_ALPHA
            
        }
        else if currentLives == 2 {
            secondLifeImage.alpha = OPAQUE
            thirdLifeImage.alpha = DIM_ALPHA
        }
        else if currentLives == 3 {
            thirdLifeImage .alpha = OPAQUE
        }
        else{
            firstLifeImage.alpha = DIM_ALPHA
            secondLifeImage.alpha = DIM_ALPHA
            thirdLifeImage.alpha = DIM_ALPHA
        }
        if currentLives >= MAX_LIVES{
            timer.invalidate()
            gameOver()
        }
    }
    
    func gameOver(){
        timer.invalidate()
        //MonsterImg.playDeathAnimation()
        Monster.playDeathAnimation()
    }
    func itemDroppedOnCharacter(notify: AnyObject)
    {
        print("Item Drpped")
    }
  
}

