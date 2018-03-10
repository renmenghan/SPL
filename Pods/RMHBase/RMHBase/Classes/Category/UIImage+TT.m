//
//  UIImage+RMH.m
//  RMHBase_Example
//
//  Created by 任梦晗 on 2016/12/10.
//  Copyright © 2016年 renmenghan. All rights reserved.
//

#import "UIImage+TT.h"
#define IS_IOS8                     (SYSTEM_VERSION >= 8)

@implementation UIImage(TT)

+ (UIImage *)imageNamed:(NSString *)name module:(NSString *)moduleName
{
    UIImage *externalImage = [UIImage imageNamed:name];
    if (externalImage) {
        return externalImage;
    }
    
#ifdef __IPHONE_8_0
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0 //Minmun Target ios8+
    
    // get the top level 'bundle' which may actually be the framework
    NSBundle *mainBundle = [NSBundle bundleForClass:NSClassFromString(moduleName)];
    
    
    // Check to see if the resource bundle exists inside the top level bundle
    NSBundle * resourcesBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:moduleName ofType:@"budle"]];
    
    if (resourcesBundle == nil) {
        resourcesBundle = mainBundle;
    }
    
    UIImage *image = [UIImage imageNamed:name inBundle:resourcesBundle compatibleWithTraitCollection:nil];
#else //Minimum Target iOS7+
    UIImage *image;
    if (IS_IOS8) {
        NSBundle *mainBundle = [NSBundle bundleForClass:NSClassFromString(moduleName)];
        
        
        // Check to see if the resource bundle exists inside the top level bundle
        NSBundle * resourcesBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:moduleName ofType:@"budle"]];
        
        if (resourcesBundle == nil) {
            resourcesBundle = mainBundle;
        }
        
        image = [UIImage imageNamed:name inBundle:resourcesBundle compatibleWithTraitCollection:nil];
    }else {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@",moduleName,name]]
    }
    
#endif
#else //Maximum target iOS 7
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.bundle/%@",moduleName,imageName]];
#endif
    return image;
}

@end
