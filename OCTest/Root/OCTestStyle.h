//
//  OCTestStyle.h
//  OCTest
//
//  Created by Apple on 2021/3/29.
//  Copyright © 2021 XIAOHUI. All rights reserved.
//

#ifndef OCTestStyle_h
#define OCTestStyle_h

// 十六进制格式
#define OTHexA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                            green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                             blue:((float)(rgbValue & 0xFF))/255.0 \
                                            alpha:a]
#define OTHex(rgbValue)     SBHexA(rgbValue, 1.0)

// self的强、弱引用
#define OTWeakSelf   __weak typeof(self) weakSelf = self
#define OTStrongSelf __strong typeof(weakSelf) strongSelf = weakSelf

#endif /* OCTestStyle_h */
