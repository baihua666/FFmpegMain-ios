# FFmpegMain-ios

cmd example 


    let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let inputFile = (documentsDirectory as NSString).appendingPathComponent("test.mp4")
    let outputFile = (documentsDirectory as NSString).appendingPathComponent("test_QualityHigh.gif")
    let cmdArray = ["ffmpeg", "-i", inputFile, outputFile]
    FFmpegCMD.cmdprocess(cmdArray)


video to gif example 


    func testQualityHigh() {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let inputFile = (documentsDirectory as NSString).appendingPathComponent("test.mp4")
        let outputFile = (documentsDirectory as NSString).appendingPathComponent("test_QualityHigh.gif")
        FFmpegGifUtil.video(inputFile, toGif: outputFile)
        FFmpegCMD.cmdprocess(cmdArray)
    }

