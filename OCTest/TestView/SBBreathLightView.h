//
//  SBBreathLightView.h
//  OCTest

//  呼吸灯

//  Created by Apple on 2021/3/29.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBBreathLightView : UIView

@property (nonatomic, copy) void (^clickHandler)(void);

@end

NS_ASSUME_NONNULL_END
