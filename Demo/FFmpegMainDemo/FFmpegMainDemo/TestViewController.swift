//
//  TestViewController.swift
//  FFmpegMainDemo
//
//  Created by yyf on 2017/11/28.
//  Copyright © 2017年 leo. All rights reserved.
//

import UIKit

import FFmpegMain



class TestViewController: UIViewController {
    
    //文件夹在BUNDLE中的名字
    lazy var fileBundleDirName = "Files"
    lazy var baseFilePath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    lazy var destPath = (self.baseFilePath as NSString).appendingPathComponent(self.fileBundleDirName)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filePath(fileName: String) -> String {
        return (destPath as NSString).appendingPathComponent(fileName)
    }
    
    func doFFmpegProcess(action: @escaping () -> Void, completion: @escaping (Bool, Double) -> Void) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
