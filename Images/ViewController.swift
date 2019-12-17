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
        
        @IBOutlet weak var ImageHandler: UIImageView!
        
        @IBOutlet weak var Label: UILabel!

        @IBAction func changeImages(_ sender: UIButton) {
            showImage()
            index!+=1
        }
        @IBAction func randomImages(_ sender: UIButton) {
            index = Int.random(in: 0...4)
            showImage()
        }
        
        func showImage() {
            guard show.firstIndex(of: true) != nil
                else{
                    return
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
            
            ImageHandler.image = UIImage(named: filenameArray[index!])
            Label.text = quoteArray[index!]

        }
        
        
        @IBAction func hideImages(_ sender: UIButton) {
            guard show.firstIndex(of: true) != nil
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
        }
        
        @IBAction func showHiddenImages(_ sender: UIButton) {
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
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }


    }
