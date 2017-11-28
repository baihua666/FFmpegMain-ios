//
//  ViewController.swift
//  FFmpegMainDemo
//
//  Created by yyf on 2017/2/28.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit
import FFmpegMain


class TestGifViewController: TestViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    deinit {
        print("TestGifViewController deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func testQualityHigh() {
        let inputFile = self.filePath(fileName: "test.mp4")
        let outputFile = self.filePath(fileName: "test_QualityHigh.gif")
        self.doFFmpegProcess(action: { (Void) in
            FFmpegGifUtil.video(inputFile, toGif: outputFile)
        }) { (isSuccessed, duration) in
            self.showFFmpegResult(isSuccessed: isSuccessed, duration: duration)
        }
    }
    
    func testQualityLow() {
        let inputFile = self.filePath(fileName: "test.mp4")
        let outputFile = self.filePath(fileName: "test_QualityLow.gif")
        self.doFFmpegProcess(action: { (Void) in
            FFmpegGifUtil.video(inputFile, toQualityLowGif: outputFile, imageWidth: 320, framesPerSecond: 8, maxDuration: 20)
        }) { (isSuccessed, duration) in
            self.showFFmpegResult(isSuccessed: isSuccessed, duration: duration)
        }
    }
    

    

    

    
    

    @IBAction func onQualityHighBtnClicked(_ sender: Any) {
        self.testQualityHigh()
    }
    
    @IBAction func onQualityLowBtnClicked(_ sender: Any) {
        self.testQualityLow()
    }
    

    

//    func copyFileToDocment() {
//        let bundlePath = (Bundle.main.bundlePath as NSString).appendingPathComponent("test.mp4")
//
//        let destPath = (self.baseFilePath as NSString).appendingPathComponent("test.mp4")
//        if FileManager.default.fileExists(atPath: destPath) {
//            try! FileManager.default.removeItem(atPath: destPath)
//        }
//        try! FileManager.default.copyItem(atPath: bundlePath, toPath: destPath)
//    }
    
    
}

