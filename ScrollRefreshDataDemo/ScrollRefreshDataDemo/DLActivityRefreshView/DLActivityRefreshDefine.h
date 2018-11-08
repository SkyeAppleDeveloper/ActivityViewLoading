//
//  DLActivityRefreshDefine.h
//  ScrollRefreshDataDemo
//
//  Created by Kai Shi on 2018/11/7.
//  Copyright © 2018 Kai Shi. All rights reserved.
//

#ifndef DLActivityRefreshDefine_h
#define DLActivityRefreshDefine_h

//往下拉最大的唯一距离开始调用刷新
#define DraggingMaxOffsetToLoading      100.0f

//ScrollView 初始Offset值
#define ScrollViewInitOffsetValue       0.0f

//loading view旋转倍数
#define LoadingViewTransformMultiple    5.0f

//loading view加载超时时间
#define LoadingTimeOut                  30

NSString *const DLActivityRefreshKeyPathContentOffset = @"contentOffset";
NSString *const DLActivityRefreshKeyPathPanState = @"state";




#endif /* DLActivityRefreshDefine_h */
