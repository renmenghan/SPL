//
//  Des.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/25.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Des : NSObject
+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;

@end
