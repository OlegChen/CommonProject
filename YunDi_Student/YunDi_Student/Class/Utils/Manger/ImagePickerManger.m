//
//  ImagePickerManger.m
//  FengYunDiYin_Student
//
//  Created by Chen on 16/8/6.
//  Copyright © 2016年 Chen. All rights reserved.
//
#import "ImagePickerManger.h"

#import "QBImagePickerController.h"
#import "Navigation.h"



@interface ImagePickerManger ()<QBImagePickerControllerDelegate>


@property (nonatomic ,strong )  QBImagePickerController * ImagePickvc;


@property (copy, nonatomic) void(^completion)(NSArray *ImageArray, BOOL sendSucess); //sendSucess: no 未选择图片或无数据

@property (nonatomic ,assign) NSInteger LimitNum;

@property (nonatomic ,strong) UIViewController  *vc;



@end


@implementation ImagePickerManger

+ (instancetype)Manager{
    static ImagePickerManger *ImagePicker_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        ImagePicker_manager = [[self alloc] init];
    });
    return ImagePicker_manager;
}



+ (instancetype)handelImagePickerWithLimitNum:(NSInteger)limitNum withController:(UIViewController *)vc WithContent:(void(^)(NSArray *assets, BOOL sendSucess)) block{
    
    ImagePickerManger *manager = [self Manager];
    
    manager.vc = vc;
    manager.LimitNum = limitNum;
    manager.completion = block;
    
    
    [manager showPickervc];
    
    
    return manager;

}

- (void)showPickervc{

    _ImagePickvc.mediaType = QBImagePickerMediaTypeImage;
    _ImagePickvc.delegate = self;
    _ImagePickvc.allowsMultipleSelection = YES;
    _ImagePickvc.showsNumberOfSelectedAssets = YES;
    _ImagePickvc.maximumNumberOfSelection = self.LimitNum;
    Navigation *navigationController = [[Navigation alloc] initWithRootViewController:_ImagePickvc];
    [self.vc presentViewController:navigationController animated:YES completion:NULL];

    
}

- (instancetype)init{

    self = [super init];
    
    if (self) {
        
        //        相册  < 判断 相册可用 >
//        if (![Helper checkPhotoLibraryAuthorizationStatus]) {
//            return;
//        }
        self.ImagePickvc = [[QBImagePickerController alloc] init];
        
    }

    return self;
}

//- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(PHAsset *)asset{
//
//    [self.vc dismissViewControllerAnimated:YES completion:NULL];
//
//}

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets{

    
    if (assets.count > 0) {
        
        self.completion(assets , YES);

    }else{
    
        self.completion(assets , NO);

    }
    
    
    [self.vc dismissViewControllerAnimated:YES completion:NULL];


}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{

    [self.vc dismissViewControllerAnimated:YES completion:NULL];

}

//- (void)getImageFromPHAsset:(PHAsset *)asset Complete:(Result)result {
//    __block NSData *data;
//    PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
//    if (asset.mediaType == PHAssetMediaTypeImage) {
//        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//        options.version = PHImageRequestOptionsVersionCurrent;
//        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
//        options.synchronous = YES;
//        [[PHImageManager defaultManager] requestImageDataForAsset:asset
//                                                          options:options
//                                                    resultHandler:
//         ^(NSData *imageData,
//           NSString *dataUTI,
//           UIImageOrientation orientation,
//           NSDictionary *info) {
//             data = [NSData dataWithData:imageData];
//         }];
//    }
//    
//    if (result) {
//        if (data.length <= 0) {
//            result(nil, nil);
//        } else {
//            result(data, resource.originalFilename);
//        }
//    }
//}
//
@end
