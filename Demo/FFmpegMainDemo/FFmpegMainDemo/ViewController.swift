//
//  ViewController.swift
//  FFmpegMainDemo
//
//  Created by yyf on 2017/2/28.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit
//import FFmpegMain
import FFmpegMain

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.copyFileToDocment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func testQualityHigh() {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let inputFile = (documentsDirectory as NSString).appendingPathComponent("test.mp4")
        let outputFile = (documentsDirectory as NSString).appendingPathComponent("test_QualityHigh.gif")
        //let cmdArray = ["ffmpeg", "-i", inputFile, outputFile]
        print("test:000000000")
        FFmpegGifUtil.video(inputFile, toGif: outputFile)
        //FFmpegCMD.cmdprocess(cmdArray)
        print("test:1111111")
    }
    
    func testQualityLow() {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let inputFile = (documentsDirectory as NSString).appendingPathComponent("test.mp4")
        let outputFile = (documentsDirectory as NSString).appendingPathComponent("test_QualityLow.gif")
        //let cmdArray = ["ffmpeg", "-i", inputFile, outputFile]
        print("test:000000000")
        //FFmpegGifUtil.video(inputFile, toGif: outputFile)
        FFmpegGifUtil.video(inputFile, toQualityLowGif: outputFile, imageWidth: 320, framesPerSecond: 8, maxDuration: 20)
        //FFmpegCMD.cmdprocess(cmdArray)
        print("test:1111111")
    }

    @IBAction func onQualityHighBtnClicked(_ sender: Any) {
        self.testQualityHigh()
    }
    
    @IBAction func onQualityLowBtnClicked(_ sender: Any) {
        self.testQualityLow()
    }
    open let baseFilePath: String = {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }()

    func copyFileToDocment() {
        let bundlePath = (Bundle.main.bundlePath as NSString).appendingPathComponent("test.mp4")

        let destPath = (self.baseFilePath as NSString).appendingPathComponent("test.mp4")
        if FileManager.default.fileExists(atPath: destPath) {
            try! FileManager.default.removeItem(atPath: destPath)
        }
        try! FileManager.default.copyItem(atPath: bundlePath, toPath: destPath)
    }
}

