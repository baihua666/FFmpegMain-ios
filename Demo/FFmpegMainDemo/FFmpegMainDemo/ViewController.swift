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

//文件夹在BUNDLE中的名字
private let fileBundleDirName = "Files"
private let baseFilePath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

private let destPath = (baseFilePath as NSString).appendingPathComponent(fileBundleDirName)

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.copyFilsToDocment()
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
    
    func filePath(fileName: String) -> String {
        return (destPath as NSString).appendingPathComponent(fileName)
    }
    
    func testCmd() {
        let cmdArray = ["ffmpeg", "-t", "1", "-i", filePath(fileName: "resource1.mp4"), filePath(fileName: "output.mp4")]
        
        self.doFFmpegProcess(action: { (Void) in
            FFmpegCMD.cmdprocess(cmdArray)
        }) { (isSuccessed, duration) in
            self.showFFmpegResult(isSuccessed: isSuccessed, duration: duration)
        }
    }
    
//    ffmpeg -y -i resource1.mp4 -t 6.65 -i resource2.mp4 -t 10 -i bgm.m4a -t 10 -i color1.mp4 -t 10 -i alpha1.mp4 -i watermark_square.png -filter_complex "[0:v]crop=720:720:0:280[v0];[1:v]crop=720:720:0:280[v1];[v0][v1]concat=n=2:v=1:a=0[vc0];[4:v]lut=a=r*1[v4];[3:v][v4]alphamerge[3vv4];[vc0][3vv4]overlay[v200];[v200][5:v]overlay=x=(main_w-overlay_w):y=(main_h-overlay_h)[ov1]" -map [ov1] -map 2 -q:v 1 -preset ultrafast output.mp4
    func testVideoFilter() {
        let cmdArray = ["ffmpeg", "-i", filePath(fileName: "resource1.mp4"), "-t", "6.65", "-i", filePath(fileName: "resource2.mp4"), "-t", "10", "-i", filePath(fileName: "bgm.m4a"), "-t", "10", "-i", filePath(fileName: "color1.mp4"), "-t", "10", "-i", filePath(fileName: "alpha1.mp4"), "-i", filePath(fileName: "watermark_square.png"), "-filter_complex", "[0:v]crop=720:720:0:280[v0];[1:v]crop=720:720:0:280[v1];[v0][v1]concat=n=2:v=1:a=0[vc0];[4:v]lut=a=r*1[v4];[3:v][v4]alphamerge[3vv4];[vc0][3vv4]overlay[v200];[v200][5:v]overlay=x=(main_w-overlay_w):y=(main_h-overlay_h)[ov1]", "-map", "[ov1]", "-map", "2", "-q:v", "1", filePath(fileName: "output.mp4")]
        
        self.doFFmpegProcess(action: { (Void) in
            FFmpegCMD.cmdprocess(cmdArray)
        }) { (isSuccessed, duration) in
            self.showFFmpegResult(isSuccessed: isSuccessed, duration: duration)
        }
    }
    
    func doFFmpegProcess(action: @escaping (Void) -> Void, completion: @escaping (Bool, Double) -> Void) {
        let startTime = Date()
        DispatchQueue.global().async {
            action()
            
            let duration = 0 - startTime.timeIntervalSinceNow
            DispatchQueue.main.sync {
                completion(true, duration)
            }
        }
        
    }
    
    func showFFmpegResult(isSuccessed: Bool, duration: Double) {
        let alert = UIAlertController(title: isSuccessed ? "successed" : "failed", message: String(format: "duration:%.2f", duration), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func onQualityHighBtnClicked(_ sender: Any) {
        self.testQualityHigh()
    }
    
    @IBAction func onQualityLowBtnClicked(_ sender: Any) {
        self.testQualityLow()
    }
    
    @IBAction func onVideoFilterBtnClicked(_ sender: Any) {
        self.testVideoFilter()
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
    
    //将BUNDLE里面的文件拷贝到文档中，保持接口一致，每次版本更新执行一次
    func copyFilsToDocment() {
        
        let bundlePath = (Bundle.main.bundlePath as NSString).appendingPathComponent(fileBundleDirName)

        
        if FileManager.default.fileExists(atPath: destPath) {
            try! FileManager.default.removeItem(atPath: destPath)
        }
        try! FileManager.default.copyItem(atPath: bundlePath, toPath: destPath)
    }
}

