//
//  FFmpegCMD.m
//  FFmpegMain
//
//  Created by yyf on 2017/2/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "FFmpegCMD.h"
#import "ffmpeg.h"

@implementation FFmpegCMD


+ (void) cmdprocess: (NSArray*) argvArray {
    int argc = (int)argvArray.count;
    char** argv=(char**)malloc(sizeof(char*)*argc);
    for(int i=0;i<argc;i++)
    {
        argv[i]=(char*)malloc(sizeof(char)*1024);
        strcpy(argv[i],[[argvArray objectAtIndex:i] UTF8String]);
    }
    //执行指令
    ffmpeg_main(argc,argv);
}


@end
