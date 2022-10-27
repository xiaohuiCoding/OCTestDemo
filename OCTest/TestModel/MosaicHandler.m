//
//  MosaicHandler.m
//  OCTest

//  图片打马赛克

//  Created by apple on 2022/10/26.
//  Copyright © 2022 XIAOHUI. All rights reserved.
//

#import "MosaicHandler.h"

/*
 马赛克的原理：
 通过放大马赛克图片，可以看到一个个单色的小正方形。所以马赛克其实也就是把某一点的色值填充了它一定范围内的一个正方形，这样看起来就会模糊，但整体还是有一定原来的样子。如图，一张图片可以认为是9*9个色值组成的位图，进行马赛克转换就变成：
 123456789   113355779
 123456789   113355779
 123456789   113355779
 123456789   113355779
 123456789   113355779
 123456789   113355779
 123456789   113355779
 123456789   113355779
 123456789   113355779
 可知，就是把某一位的色值向右向下填充一个2*2的正方形。
 */
@implementation MosaicHandler

#define kBitsPerComponent (8)
#define kBitsPerPixel (32)
#define kPixelChannelCount (4)

/*
 转换成马赛克，level代表一个点转为多少level*level的正方形
 其实主要代码就是里面那层做的马赛克转换，前后都是为了获取bitmapdata和把bitmapdata再还原为图像。
 */
+ (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level
{
    //获取BitmapData
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imgRef = orginImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  kBitsPerComponent,        //每个颜色值8bit
                                                  width*kPixelChannelCount, //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit
                                                  colorSpace,
                                                  kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    unsigned char *bitmapData = CGBitmapContextGetData (context);
    
    //这里把BitmapData进行马赛克转换,就是用一个点的颜色填充一个level*level的正方形
    unsigned char pixel[kPixelChannelCount] = {0};
    NSUInteger index,preIndex;
    for (NSUInteger i = 0; i < height - 1 ; i++) {
        for (NSUInteger j = 0; j < width - 1; j++) {
            index = i * width + j;
            if (i % level == 0) {
                if (j % level == 0) {
                    memcpy(pixel, bitmapData + kPixelChannelCount*index, kPixelChannelCount);
                }else{
                    memcpy(bitmapData + kPixelChannelCount*index, pixel, kPixelChannelCount);
                }
            } else {
                preIndex = (i-1)*width +j;
                memcpy(bitmapData + kPixelChannelCount*index, bitmapData + kPixelChannelCount*preIndex, kPixelChannelCount);
            }
        }
    }

    NSInteger dataLength = width*height* kPixelChannelCount;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData, dataLength, NULL);
        
    //创建要输出的图像
    CGImageRef mosaicImageRef = CGImageCreate(width, height,
                                        kBitsPerComponent,
                                        kBitsPerPixel,
                                        width*kPixelChannelCount ,
                                        colorSpace,
//                                        kCGImageAlphaPremultipliedLast,
                                        CGImageGetBitmapInfo(imgRef), // 更改
                                        provider,
                                        NULL, NO,
                                        kCGRenderingIntentDefault);
     CGContextRef outputContext = CGBitmapContextCreate(nil,
                                                 width,
                                                 height,
                                                 kBitsPerComponent,
                                                 width*kPixelChannelCount,
                                                 colorSpace,
                                                kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(outputContext, CGRectMake(0.0f, 0.0f, width, height), mosaicImageRef);
    CGImageRef resultImageRef = CGBitmapContextCreateImage(outputContext);
    UIImage *resultImage = nil;
    if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
        float scale = [[UIScreen mainScreen] scale];
        resultImage = [UIImage imageWithCGImage:resultImageRef scale:scale orientation:UIImageOrientationUp];
    } else {
        resultImage = [UIImage imageWithCGImage:resultImageRef];
    }
    //释放
    if(resultImageRef){
        CFRelease(resultImageRef);
    }
    if(mosaicImageRef){
        CFRelease(mosaicImageRef);
    }
    if(colorSpace){
        CGColorSpaceRelease(colorSpace);
    }
    if(provider){
        CGDataProviderRelease(provider);
    }
    if(context){
        CGContextRelease(context);
    }
    if(outputContext){
        CGContextRelease(outputContext);
    }
    return resultImage;

}

@end
