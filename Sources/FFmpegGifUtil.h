//
//  FFmpegGifUtil.h
//  FFmpegMain
//
//  Created by yyf on 2017/2/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FFmpegGIFQuality) {
    FFmpegGIFQualityLow,
    FFmpegGIFQualityHigh
};

@interface FFmpegGifUtil : NSObject

//视频转GIF，按照默认参数转
+ (void) video: (NSString*) videoPath toGif: (NSString*)gifPath;
//视频转GIF，图片质量低，文件体积反而大
+ (void) video: (NSString*) videoPath toQualityLowGif: (NSString*)gifPath imageWidth: (int)width framesPerSecond: (int)frames maxDuration: (int) duration;
//视频转GIF，图片质量高，文件体积小，使用palettegen，需要两个步骤生成
+ (void) video: (NSString*) videoPath toQualityHighGif: (NSString*)gifPath imageWidth: (int)width framesPerSecond: (int)frames maxDuration: (int) duration;

//视频转GIF，指定参数
+ (void) video: (NSString*) videoPath toGif: (NSString*)gifPath quality: (FFmpegGIFQuality)quality imageWidth: (int)width framesPerSecond: (int)frames maxDuration: (int) duration;
@end
