//
//  FFmpegGifUtil.m
//  FFmpegMain
//
//  Created by yyf on 2017/2/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "FFmpegGifUtil.h"
#import "FFmpegCMD.h"

@implementation FFmpegGifUtil

//+ (void) video: (NSString*) videoPath toGif: (NSString*)gifPath {
//    //NSArray * cmdArray = @[@"ffmpeg", @"-i", videoPath, gifPath];
//    //[FFmpegCMD cmdprocess:cmdArray];
//    [FFmpegGifUtil video:videoPath toGif:gifPath imageWidth:320 framesPerSecond:8 maxDuration:30];
//}
//
//+ (void) video: (NSString*) videoPath toGif: (NSString*)gifPath imageWidth: (int)width framesPerSecond: (int)frames   maxDuration: (int) duration {
//    NSArray * cmdArray = @[@"ffmpeg", @"-t", [NSString stringWithFormat:@"%d", duration], @"-i", videoPath, @"-vf", [NSString stringWithFormat:@"fps=%d,scale=%d:-1:flags=lanczos", frames, width], @"-gifflags", @"-transdiff", @"-y", gifPath];
//    [FFmpegCMD cmdprocess:cmdArray];
//}


//视频转GIF，按照默认参数转
+ (void) video: (NSString*) videoPath toGif: (NSString*)gifPath {
    [FFmpegGifUtil video:videoPath toQualityHighGif:gifPath imageWidth:320 framesPerSecond:8 maxDuration:20];
}

//视频转GIF，图片质量低，文件体积小
+ (void) video: (NSString*) videoPath toQualityLowGif: (NSString*)gifPath imageWidth: (int)width framesPerSecond: (int)frames maxDuration: (int) duration {
    NSArray * cmdArray = @[@"ffmpeg", @"-t", [NSString stringWithFormat:@"%d", duration], @"-i", videoPath, @"-vf", [NSString stringWithFormat:@"fps=%d,scale=%d:-1:flags=lanczos", frames, width], @"-gifflags", @"-transdiff", @"-y", gifPath];
    [[FFmpegCMD shared] cmdprocess:cmdArray];
}

//视频转GIF，图片质量高，文件体积大
+ (void) video: (NSString*) videoPath toQualityHighGif: (NSString*)gifPath imageWidth: (int)width framesPerSecond: (int)frames maxDuration: (int) duration {
    NSString *dir = [gifPath stringByDeletingLastPathComponent];
    NSString *paletteFilePath = [dir stringByAppendingPathComponent:@"palette.png"];
    
    NSArray * paletteCmdArray = @[@"ffmpeg", @"-t", [NSString stringWithFormat:@"%d", duration], @"-i", videoPath, @"-vf", [NSString stringWithFormat:@"fps=%d,scale=%d:-1:flags=lanczos,palettegen", frames, width], @"-y", paletteFilePath];
    [[FFmpegCMD shared] cmdprocess:paletteCmdArray];
    
    NSArray * convertCmdArray = @[@"ffmpeg", @"-t", [NSString stringWithFormat:@"%d", duration], @"-i", videoPath, @"-i", paletteFilePath, @"-filter_complex", [NSString stringWithFormat:@"fps=%d,scale=%d:-1:flags=lanczos[x];[x][1:v]paletteuse", frames, width], @"-y", gifPath];
    [[FFmpegCMD shared] cmdprocess:convertCmdArray];
}

//视频转GIF，指定参数
+ (void) video: (NSString*) videoPath toGif: (NSString*)gifPath quality: (FFmpegGIFQuality)quality imageWidth: (int)width      framesPerSecond: (int)frames maxDuration: (int) duration {
    if (quality == FFmpegGIFQualityLow) {
        [FFmpegGifUtil video:videoPath toQualityLowGif:gifPath imageWidth:width framesPerSecond:frames maxDuration:duration];
    }
    else {
        [FFmpegGifUtil video:videoPath toQualityHighGif:gifPath imageWidth:width framesPerSecond:frames maxDuration:duration];
    }
}
@end
