//
//  ImagePickerManger.h
//  FengYunDiYin_Student
//
//  Created by Chen on 16/8/6.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImagePickerManger : NSObject



//@property (copy, nonatomic) void(^completion)(NSArray *ImageArray, BOOL sendSucess);


+ (instancetype)handelImagePickerWithLimitNum:(NSInteger)limitNum withController:(UIViewController *)vc WithContent:(void(^)(NSArray *assets, BOOL sendSucess)) block;

@end
