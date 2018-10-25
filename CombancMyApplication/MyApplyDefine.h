//
//  CustomCellDefine.h
//  ApplyDemo
//
//  Created by Golden on 2018/9/7.
//  Copyright © 2018年 Golden. All rights reserved.
//

#ifndef CustomCellDefine_h
#define CustomCellDefine_h

#define K_CellLeft   getWidth(15)
#define K_CellRight  getWidth(12)
#define K_CellHeight getHeight(44)

#define K_CellStarsWidth getWidth(6)
#define K_CellNamelblLeft getWidth(4)
#define K_CellNamelblTop  getHeight(14)
#define K_CellRightImgWidth getWidth(14)

#define K_CellLimitTop getHeight(5)
#define K_CellImageGroupTop getHeight(40)

#pragma mark - 视图坐标
#define K_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define K_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//3.5寸 4/4s @2x
#define K_PHONE_4_SCREEN_WIDTH (320.f)
#define K_PHONE_4_SCREEN_HEIGHT (480.f)
//4寸   5/5s/5c @2x
#define K_PHONE_5_SCREEN_WIDTH (320.f)
#define K_PHONE_5_SCREEN_HEIGHT (568.f)
//4.7寸 6/6s/7/8 @2x
#define K_PHONE_6_SCREEN_WIDTH (375.0f)
#define K_PHONE_6_SCREEN_HEIGHT (667.0f)
//5.5寸 6+/6s+/7+/8+ @3x
#define K_PHONE_7p_SCREEN_WIDTH (414.f)
#define K_PHONE_7p_SCREEN_HEIGHT (736.f)
//5.8寸 x @3x
#define K_PHONE_X_SCREEN_WIDTH (375.f)
#define K_PHONE_X_SCREEN_HEIGHT (812.f)

#define K_DEPENDED_SCREEN_WIDTH K_PHONE_6_SCREEN_WIDTH
#define K_DEPENDED_SCREEN_HEIGHT K_PHONE_6_SCREEN_HEIGHT
#define getWidth(w) ((float)w / K_DEPENDED_SCREEN_WIDTH * K_SCREEN_WIDTH)
#define getHeight(h) ((float)h / K_DEPENDED_SCREEN_HEIGHT * K_SCREEN_HEIGHT)

#endif /* CustomCellDefine_h */
