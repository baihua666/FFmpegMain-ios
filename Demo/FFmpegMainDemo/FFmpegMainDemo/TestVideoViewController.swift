//
//  TestVideoViewController.swift
//  FFmpegMainDemo
//
//  Created by yyf on 2017/11/28.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit
import FFmpegMain

class TestVideoViewController: TestViewController {
    @IBOutlet weak var logLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.copyFilsToDocment()
    }
    
    deinit {
        print("TestVideoViewController deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //将BUNDLE里面的文件拷贝到文档中
    func copyFilsToDocment() {
        
        let bundlePath = (Bundle.main.bundlePath as NSString).appendingPathComponent(fileBundleDirName)
        
        
        if FileManager.default.fileExists(atPath: destPath) {
            try! FileManager.default.removeItem(atPath: destPath)
        }
        try! FileManager.default.copyItem(atPath: bundlePath, toPath: destPath)
    }
    
    @IBAction func onVideoFilterBtnClicked(_ sender: Any) {
        //        self.testVideoFilter()
        self.testCmd()
    }
    
    func showFrameLog(frame: Int32) {
        let logText = "frame:\(frame)"
        print(logText)
        DispatchQueue.main.sync {
            self.logLabel.text = logText
        }
        
    }
    
    func testCmd() {
        //        let cmdArray = ["ffmpeg", "-t", "1", "-i", filePath(fileName: "resource1.mp4"), filePath(fileName: "output.mp4")]
        let input = (baseFilePath as NSString).appendingPathComponent("demo.mp4")
        let cmdArray = ["ffmpeg", "-y", "-i", input, "-vcodec", "libx264", "-q:v", "1", filePath(fileName: "output.mp4")]
        
        self.doFFmpegProcess(action: { (Void) in
            FFmpegCMD.shared().cmdprocess(cmdArray) { frame in
                self.showFrameLog(frame: frame)
                
            }
        }) { (isSuccessed, duration) in
            self.showFFmpegResult(isSuccessed: isSuccessed, duration: duration)
        }
    }
    

    //    ffmpeg -y -i resource1.mp4 -t 6.65 -i resource2.mp4 -t 10 -i bgm.m4a -t 10 -i color1.mp4 -t 10 -i alpha1.mp4 -i watermark_square.png -filter_complex "[0:v]crop=720:720:0:280[v0];[1:v]crop=720:720:0:280[v1];[v0][v1]concat=n=2:v=1:a=0[vc0];[4:v]lut=a=r*1[v4];[3:v][v4]alphamerge[3vv4];[vc0][3vv4]overlay[v200];[v200][5:v]overlay=x=(main_w-overlay_w):y=(main_h-overlay_h)[ov1]" -map [ov1] -map 2 -q:v 1 -preset ultrafast output.mp4
    func testVideoFilter() {
        let cmdArray = ["ffmpeg", "-i", filePath(fileName: "resource1.mp4"), "-t", "6.65", "-i", filePath(fileName: "resource2.mp4"), "-t", "10", "-i", filePath(fileName: "bgm.m4a"), "-t", "10", "-i", filePath(fileName: "color1.mp4"), "-t", "10", "-i", filePath(fileName: "alpha1.mp4"), "-i", filePath(fileName: "watermark_square.png"), "-filter_complex", "[0:v]crop=720:720:0:280[v0];[1:v]crop=720:720:0:280[v1];[v0][v1]concat=n=2:v=1:a=0[vc0];[4:v]lut=a=r*1[v4];[3:v][v4]alphamerge[3vv4];[vc0][3vv4]overlay[v200];[v200][5:v]overlay=x=(main_w-overlay_w):y=(main_h-overlay_h)[ov1]", "-map", "[ov1]", "-map", "2", "-q:v", "1", filePath(fileName: "output.mp4")]
        
        self.doFFmpegProcess(action: { (Void) in
            FFmpegCMD.shared().cmdprocess(cmdArray) { frame in
                print("frame:\(frame)")
            }
        }) { (isSuccessed, duration) in
            self.showFFmpegResult(isSuccessed: isSuccessed, duration: duration)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
