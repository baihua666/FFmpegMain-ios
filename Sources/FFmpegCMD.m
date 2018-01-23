//
//  FFmpegCMD.m
//  FFmpegMain
//
//  Created by yyf on 2017/2/28.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "FFmpegCMD.h"
#import "ffmpeg.h"

//typedef void (^ProgressBlock)(void* a0, int count, const char* a1, va_list args);

@interface FFmpegCMD() {
    
}
@end

@implementation FFmpegCMD



+ (instancetype)shared {
    static FFmpegCMD *sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) cmdprocess: (NSArray*_Nonnull) argvArray {
    [self cmdprocess:argvArray progress:nil];
}

- (void) interruptCMDProcess {
    if (!self.isProcessing) {
        return;
    }
    ffmpeg_main_interrupt();
    self.isProcessing = NO;
}

- (void) cmdprocess: (NSArray*_Nonnull) argvArray progress: (ProgressBlock _Nullable ) handler {
    self.isProcessing = YES;
    self.progressBlock = handler;
    int argc = (int)argvArray.count;
    char** argv=(char**)malloc(sizeof(char*)*argc);
    for(int i=0; i<argc; i++)
    {
        argv[i] = (char*)malloc(sizeof(char)*1024);
        strcpy(argv[i],[[argvArray objectAtIndex:i] UTF8String]);
    }
    //执行指令
    ffmpeg_main(argc,argv);
    
    for(int i=0; i<argc; i++)
    {
        free(argv[i]);
    }
    free(argv);
    self.progressBlock = nil;
    
    self.isProcessing = NO;
}

- (void) onLogCallback:(void *)ptr level: (int) level msg: (NSString *)msg {
    if (self.progressBlock == nil) {
        return;
    }
//    NSLog(@"onLogCallback,%d,%@", level, msg);
    NSString *pattern = @"frame=(\\s*)(\\d+)";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray<NSTextCheckingResult *> *result = [regex matchesInString:msg options:0 range:NSMakeRange(0, msg.length)];
    if (result && [result count] == 1) {
        for (int i = 0; i<result.count; i++) {
            NSTextCheckingResult *res = result[i];
            NSString *frameString = [msg substringWithRange:res.range];
            
            NSString *prefixToRemove = @"frame=";
            if ([frameString hasPrefix:prefixToRemove]) {
                frameString = [frameString substringFromIndex:[prefixToRemove length]];
            }
            
            
            int frame = frameString.intValue;
            //NSLog(@"str == %@, %d", frameString, frame);

            self.progressBlock(frame);
            
        }
    }
}


void log_callback(void *ptr, int level, const char *fmt, va_list vl)
{
    //vfprintf(stdout, fmt, vl);
    NSString *format = [[NSString alloc] initWithUTF8String:fmt];
    NSString *msg = [[NSString alloc] initWithFormat:format arguments:vl];
    [[FFmpegCMD shared] onLogCallback:ptr level:level msg:msg];
}

- (void) setup {
    av_log_set_callback(log_callback);
}

@end
