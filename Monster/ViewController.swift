//
//  ViewController.swift
//  Monster
//
//  Created by Lalit on 2016-01-12.
//  Copyright © 2016 Bagga. All rights reserved.
//

import UIKit
import AVFoundation

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
    
    var backMusic : AVAudioPlayer!
    var sfxBite : AVAudioPlayer!
    var sfxDeath : AVAudioPlayer!
    var sfxSkull : AVAudioPlayer!
    var sfxHeart : AVAudioPlayer!
    
    var currentLives = 0
    var monsterHappy = false
    var currentItem : UInt32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImg.dropTarget = Monster
        heartImg.dropTarget = Monster
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        firstLifeImage.alpha = DIM_ALPHA
        secondLifeImage.alpha = DIM_ALPHA
        thirdLifeImage.alpha = DIM_ALPHA
        startTimer()
        
        let path = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")
        let soundURL = NSURL(fileURLWithPath: path!)
        do{
            try backMusic = AVAudioPlayer(contentsOfURL: soundURL)
            backMusic.prepareToPlay()
            backMusic.play()
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
             try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
             try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
             try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
             sfxBite.prepareToPlay()
             sfxDeath.prepareToPlay()
             sfxHeart.prepareToPlay()
             sfxSkull.prepareToPlay()
        }
        catch let err as NSError{
            print(err.debugDescription)
        }
       
        
        
        
    }
    func startTimer(){
        if timer != nil{
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    func changeGameState(){
        if !monsterHappy{
        currentLives++
        sfxSkull.play()
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
        let rand = arc4random_uniform(2)
        if rand == 0{
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
        }else if rand == 1{
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
        }
        currentItem = rand
        monsterHappy = false
    }
    
    func gameOver(){
        timer.invalidate()
        //MonsterImg.playDeathAnimation()
        Monster.playDeathAnimation()
        sfxDeath.play()
    }
    func itemDroppedOnCharacter(notify: AnyObject)
    {
        print("Item Drpped")
        monsterHappy = true
        startTimer()
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        if currentItem == 0{
        sfxHeart.play()
        }else {
            sfxBite.play()
        }
    }
  
}

