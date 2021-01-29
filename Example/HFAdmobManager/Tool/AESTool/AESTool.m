//
//  AESTool.m
//  HFCommonUtil
//
//  Created by hf on 2021/1/6.
//

#import "AESTool.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>


@implementation AESTool

#pragma mark - AES Encrypt/Decrypt

//确定密钥长度，这里选择 AES-128。
size_t const kKeySize = kCCKeySizeAES128;
+ (NSData * _Nonnull)encryptAESWithContentData:(NSData *)contentData
                                           key:(NSString *)encryptKey
                                        vector:(NSString *)encryptVec {
    
    NSUInteger dataLength = contentData.length;
    // 为结束符'\\0' +1
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [encryptKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [encryptVec dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,  //系统默认使用CBC，然后指明使用PKCS7Padding
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize];
        return data;
    }
    free(encryptedBytes);
    return nil;

}

+ (NSData * _Nonnull)encryptAES:(NSString *)content
                            key:(NSString *)encryptKey
                         vector:(NSString *)encryptVec {
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    return [self encryptAESWithContentData:contentData key:encryptKey vector:encryptVec];
}

+ (NSData * _Nonnull)decryptAES:(NSData *)content
                            key:(NSString *)key
                         vector:(NSString *)vector {
    // 把base64 String 转换成 Data
    NSUInteger dataLength = content.length;
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t decryptSize = dataLength + kCCBlockSizeAES128;
    void *decryptedBytes = malloc(decryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [vector dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          content.bytes,
                                          dataLength,
                                          decryptedBytes,
                                          decryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess)
    {
        NSData *data = [NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize];
        return data;
    }
    free(decryptedBytes);
    
    return nil;
}

@end
