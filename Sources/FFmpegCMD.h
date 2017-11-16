//
//  FFmpegCMD.h
//  FFmpegMain
//
//  Created by yyf on 2017/2/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ProgressBlock)(int frameIndex);

@interface FFmpegCMD : NSObject


@property (copy, nullable) ProgressBlock progressBlock;

+ (instancetype _Nonnull )shared;

- (void) cmdprocess: (NSArray*_Nonnull) argvArray;
- (void) cmdprocess: (NSArray*_Nonnull) argvArray progress: (ProgressBlock _Nullable ) handler;


//- (void) setLogCallback: (AVLogFunc)logCallback;

- (void)setup ;

@end
