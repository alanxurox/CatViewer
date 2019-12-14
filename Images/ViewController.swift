    //
    //  ViewController.swift
    //  Images
    //
    //  Created by Yuanlun (Alan) on 12/6/19.
    //  Copyright © 2019 Yuanlun (Alan). All rights reserved.
    //

    import UIKit

    class ViewController: UIViewController {

        var index = 0
        var quoteArray = ["Cat 1", "Cat 2", "Cat 3", "Cat 4", "Cat 5"]
        var filenameArray = ["Unknown.jpeg", "Unknown-1.jpeg", "Unknown-2.jpeg", "Unknown-3.jpeg", "Unknown-4.jpeg"]
        var show = [true, true, true, true, true]
        
        @IBOutlet weak var ImageHandler: UIImageView!
        
        @IBOutlet weak var Label: UILabel!

        @IBAction func changeImages(_ sender: UIButton) {
            showImage()
            index+=1
        }
        @IBAction func randomImages(_ sender: UIButton) {
            index = Int.random(in: 0...4)
            showImage()
        }
        
        func showImage() {
            
            if index > quoteArray.count - 1{
                index = show.firstIndex(of: true)!
                }
            
            while show[index] == false{
                if index > quoteArray.count - 2{
                    index = show.firstIndex(of: true)!
                    if index == nil {
                        break
                    }
                } else {
                    index+=1
                }
            }
            
            ImageHandler.image = UIImage(named: filenameArray[index])
            Label.text = quoteArray[index]

        }
        
        
        @IBAction func hideImages(_ sender: UIButton) {
            show[index - 1] = false
            showImage();
            index+=1
        }
        
        @IBAction func showHiddenImages(_ sender: UIButton) {
            for n in 0...4  {
                show[n] = true
            }
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }


    }
    
    //                switch n {
    //                    case 0:
    //                        ImageHandler.image = UIImage(named: filenameArray[0])
    //                        Label.text = quoteArray[0]
    //                        index+=1
    //                    case 1:
    //                        ImageHandler.image = UIImage(named: filenameArray[1])
    //                        Label.text = quoteArray[1]
    //                        index+=1
    //                    case 2:
    //                        ImageHandler.image = UIImage(named: filenameArray[2])
    //                        Label.text = quoteArray[2]
    //                        index+=1
    //                    case 3:
    //                        ImageHandler.image = UIImage(named: filenameArray[3])
    //                        Label.text = quoteArray[3]
    //                        index+=1
    //                    case 4:
    //                        ImageHandler.image = UIImage(named: filenameArray[4])
    //                        Label.text = quoteArray[4]
    //                        index = 0
    //                    default: break
    //                }

