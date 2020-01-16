    //
    //  ViewController.swift
    //  Images
    //
    //  Created by Yuanlun (Alan) on 12/6/19.
    //  Copyright © 2019 Yuanlun (Alan). All rights reserved/
    //

    import UIKit

    class ViewController: UIViewController {

        var index:Int? = 0
        var quoteArray = ["Cat 1", "Cat 2", "Cat 3", "Cat 4", "Cat 5"]
        var filenameArray = ["Unknown.jpeg", "Unknown-1.jpeg", "Unknown-2.jpeg", "Unknown-3.jpeg", "Unknown-4.jpeg"]
        var show = [true, true, true, true, true]
        var noImageShowing = true
        var fullscreen = false
        var looping = false
        var imageBig: UIImageView!
        let data = UserDefaults.standard
        

        
        let defaults = UserDefaults.standard
        
        @IBOutlet weak var ImageHandler: UIImageView!
        
        @IBOutlet weak var Label: UILabel!
        
        var time = Timer()
        
        
        
        
        @IBAction func loop(_ sender: UIButton) {
            looping = true
            time = Timer.scheduledTimer(timeInterval: TimeInterval(1.0), target: self, selector: #selector(Action), userInfo: nil, repeats: true)
            data.set(looping, forKey: "SavedLooping")
            
        }
        
        func loop() {
            looping = true
            time = Timer.scheduledTimer(timeInterval: TimeInterval(1.0), target: self, selector: #selector(Action), userInfo: nil, repeats: true)
            data.set(looping, forKey: "SavedLooping")
        }

        @IBAction func tapped(_ sender: UITapGestureRecognizer) {
            guard sender.view != nil else {
                return
            }
            
            guard  ImageHandler.image != nil else {
                return
            }
            
            if sender.state == .ended {
                fullscreen = true
                
                imageBig = UIImageView(image: ImageHandler.image)
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(back(_:)))
                
                makeFullScreen(imageBig)
                imageBig.addGestureRecognizer(tap)
                self.view.addSubview(imageBig)
                
                data.set(fullscreen, forKey: "SavedFullscreen")
            }
            
        }
        
        func tapped() {
            
            imageBig = UIImageView(image: ImageHandler.image)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(back(_:)))
            
            makeFullScreen(imageBig)
            imageBig.addGestureRecognizer(tap)
            self.view.addSubview(imageBig)
        }
        
        func makeFullScreen(_ image: UIImageView) {
            image.frame = UIScreen.main.bounds
            image.contentMode = .scaleAspectFit
            image.backgroundColor = .black
            image.isUserInteractionEnabled = true

        }
        
        @objc func back(_ sender: UITapGestureRecognizer) {
            if sender.state == .ended {
                fullscreen = false
                sender.view?.removeFromSuperview()
                index!-=1
                showImage()
                data.set(fullscreen, forKey: "SavedFullscreen")
                data.set(index, forKey: "SavedIndex")
            }
        }
        
        @IBAction func changeImages(_ sender: UIButton) {
            noImageShowing = false
            showImage()
            index!+=1
            data.set(index, forKey: "SavedIndex")
        }
        @IBAction func randomImages(_ sender: UIButton) {
            noImageShowing = false
            index = Int.random(in: 0...4)
            showImage()
            index!+=1
            data.set(index, forKey: "SavedIndex")
        }
        
        func showImage() {
            guard show.firstIndex(of: true) != nil
                else{
                    return
            }
            
            if index! < 0 {
                index = 0
            }
            
            if index! > quoteArray.count - 1{
                index = show.firstIndex(of: true)!
                }
            
            while show[index!] == false{
                if index! > quoteArray.count - 2{
                    index = show.firstIndex(of: true)!
                } else {
                    index!+=1
                }
            }
            
            if fullscreen && looping {
                imageBig.image = UIImage(named: filenameArray[index!])
            } else {
                ImageHandler.image = UIImage(named: filenameArray[index!])
            }
            
            Label.text = quoteArray[index!]
            data.set(index, forKey: "SavedIndex")
        }
        
        
        @IBAction func hideImages(_ sender: UIButton) {
            guard show.firstIndex(of: true) != nil
                else{
                    return
            }
            guard noImageShowing == false
                else{
                    return
            }
            
            show[index! - 1] = false
            showImage();
            
            if show.firstIndex(of: true) == nil {
                ImageHandler.image = UIImage(named: "")
                Label.text = ""
            }
            index!+=1
            data.set(show, forKey: "SavedHidden")
            data.set(index, forKey: "SavedIndex")
        }
        
        @IBAction func showHiddenImages(_ sender: UIButton) {
            guard noImageShowing == false
                else {
                    return
            }
            if show.firstIndex(of: true) == nil || index! < 0{
                index! = 0
            } else {
                index!-=1
            }
            for n in 0...4  {
                show[n] = true
            }
            showImage()
            index!+=1
            data.set(show, forKey: "SavedHidden")
            data.set(index, forKey: "SavedIndex")
        }
        
        
        @objc func Action() {
            noImageShowing = false
            showImage()
            index!+=1
            data.set(index, forKey: "SavedIndex")
        }
        
        @IBAction func stopAction(_ sender: UIButton) {
            time.invalidate()
            looping = false
            data.set(looping, forKey: "SavedLooping")
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            let array = data.array(forKey: "SavedHidden")
            
            show = array as? [Bool] ?? [true, true, true, true, true]
            
            looping = data.bool(forKey: "SavedLooping") ?? false
            
            fullscreen = data.bool(forKey: "SavedFullscreen") ?? false
            
            index = data.integer(forKey: "SavedIndex") - 1 ?? 0

            
            if looping {
                loop()
            }
            
            if fullscreen {
                tapped()
            }
            
            showImage()
            
        }
        
        


    }
