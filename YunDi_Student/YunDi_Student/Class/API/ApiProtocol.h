//
//  ApiProtocol.h
//  GeneralStructure
//
//  Created by King on 14-5-9.
//  Copyright (c) 2014年 Elroy. All rights reserved.
//

#define ImageKey    @"ImageData"//上传图片 图片对应的key

#import "AFNetworking.h"
//#import "QuestMethodName.h"
#import "BaseModel.h"

typedef void (^RequestSuccessBlock) (id object);
typedef void (^RequestfaildBlock) (BaseModel *object);

@protocol ApiProtocol <NSObject>
/**
 *	@brief
 *
 *  @since  ver 1.0.0
 *  @since
 *
 *  @param  WaitAnimation    请求等待控件是否需要关闭
 *	@param 	CompletionHandler  请求完成后处理 block
 *	@param 	errorHandler  请求失败 错误处理 block
 *
 *	@param 	Start  起始页
 *	@param 	Count  每页个数
 *
 *	@return	请求队列管理
 */

@optional


@end