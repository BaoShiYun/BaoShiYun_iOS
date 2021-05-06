//
//  BSYDownloadDefine.h
//  BSYunVod
//
//  Created by zddMac on 2020/10/26.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef BSYDownloadDefine_h
#define BSYDownloadDefine_h


/**
 下载状态
 */
typedef NS_ENUM(NSUInteger, BSYDownloadState) {
    
    /**
     * 未下载或已删除
     */
    BSYDownloadStateNone,
    
    /**
     * 等待下载
     */
    BSYDownloadStateReadying,
    
    /**
     * 正在下载
     */
    BSYDownloadStateRunning,
    
    /**
     * 下载暂停
     */
    BSYDownloadStateSuspended,
    
    /**
     * 下载完成
     */
    BSYDownloadStateCompleted,
    
    /**
     * 下载失败
     */
    BSYDownloadStateFailed
};


/**
 下载文件类型
 */
typedef NS_ENUM(NSUInteger, BSYDownloadType) {
    /**
     * 视频
     */
    BSYDownloadTypeVideo,
};







#endif /* BSYDownloadDefine_h */
