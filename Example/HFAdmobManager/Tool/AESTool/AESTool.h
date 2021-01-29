//
//  AESTool.h
//  HFCommonUtil
//
//  Created by hf on 2021/1/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AESTool : NSObject

#pragma mark - AES Encrypt加密/Decrypt解密
+ (NSData * _Nonnull)encryptAESWithContentData:(NSData *)contentData
                                           key:(NSString *)encryptKey
                                        vector:(NSString *)encryptVec;

+ (NSData * _Nonnull)encryptAES:(NSString *)content
                            key:(NSString *)encryptKey
                         vector:(NSString *)encryptVec;

+ (NSData * _Nonnull)decryptAES:(NSData *)content
                            key:(NSString *)key
                         vector:(NSString *)vector;

@end

NS_ASSUME_NONNULL_END
