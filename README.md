# FFmpegMain-ios

change ffmpeg cmd code to interface for iso, use ffmpeg as a cmd tool.
ffmpeg version 3.4 with libx264
add custom configure mp4 to gif reduce lib file size
objective-c and swift support

cmd example 


    let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let inputFile = (documentsDirectory as NSString).appendingPathComponent("test.mp4")
    let outputFile = (documentsDirectory as NSString).appendingPathComponent("test_QualityHigh.gif")
    let cmdArray = ["ffmpeg", "-i", inputFile, outputFile]
    FFmpegCMD.shared().cmdprocess(cmdArray) { frame in
                print("frame:\(frame)")
            }


video to gif example 


    func testQualityHigh() {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let inputFile = (documentsDirectory as NSString).appendingPathComponent("test.mp4")
        let outputFile = (documentsDirectory as NSString).appendingPathComponent("test_QualityHigh.gif")
        FFmpegGifUtil.video(inputFile, toGif: outputFile)
    }
    
 
    ffmpeg build
    https://github.com/kewlbear/FFmpeg-iOS-build-script
    
    x264 build
    https://github.com/kewlbear/x264-ios


