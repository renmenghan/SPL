//
//  ColorMarco.h
//  SPL
//
//  Created by 任梦晗 on 2018/2/24.
//  Copyright © 2018年 任梦晗. All rights reserved.
//

#ifndef ColorMarco_h
#define ColorMarco_h

#import "ShortcutMacro.h"

// rgb取色
#define RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define RGB(r,g,b)          RGBA(r,g,b,1)

#define Color_Black                   RGB(0, 0, 0)

#define Color_White                   RGB(255, 255, 255)

#define Color_Gray(x)                 RGB(x, x, x)
#define Color_Gray3                   RGB(3, 3, 3)
#define Color_Gray17                  RGB(17, 17, 17)
#define Color_Gray26                  RGB(26, 26, 26)
#define Color_Gray32                  RGB(32, 32, 32)
#define Color_Gray42                  RGB(42, 42, 42)
#define Color_Gray51                  RGB(51, 51, 51)
#define Color_Gray58                  RGB(58, 58, 58)
#define Color_Gray66                  RGB(66, 66, 66)
#define Color_Gray74                  RGB(74, 74, 74)
#define Color_Gray85                  RGB(85, 85, 85)
#define Color_Gray92                  RGB(92, 92, 92)
#define Color_Gray100                 RGB(100, 100, 100)
#define Color_Gray113                 RGB(113, 113, 113)
#define Color_Gray125                 RGB(125, 125, 125)
#define Color_Gray130                 RGB(130, 130, 130)
#define Color_Gray140                 RGB(140, 140, 140)
#define Color_Gray146                 RGB(146, 146, 146)
#define Color_Gray148                 RGB(148, 148, 148)
#define Color_Gray153                 RGB(153, 153, 153)
#define Color_Gray166                 RGB(166, 166, 166)
#define Color_Gray169                 RGB(169, 169, 169)
#define Color_Gray170                 RGB(170, 170, 170)
#define Color_Gray182                 RGB(182, 182, 182)
#define Color_Gray187                 RGB(187, 187, 187)
#define Color_Gray194                 RGB(194, 194, 194)
#define Color_Gray196                 RGB(196, 196, 196)
#define Color_Gray204                 RGB(204, 204, 204)
#define Color_Gray209                 RGB(209, 209, 209)
#define Color_Gray216                 RGB(216, 216, 216)
#define Color_Gray224                 RGB(224, 224, 224)
#define Color_Gray230                 RGB(230, 230, 230)
#define Color_Gray233                 RGB(233, 233, 233)
#define Color_Gray238                 RGB(238, 238, 238)
#define Color_Gray240                 RGB(240, 240, 240)
#define Color_Gray242                 RGB(242, 242, 242)
#define Color_Gray245                 RGB(245, 245, 245)
#define Color_Gray250                 RGB(250, 250, 250)

#define Color_Red                     RGB(209, 30, 72)
#define Color_Red2                    RGB(212, 20, 36)
#define Color_Red3                    RGB(223, 43, 47)
#define Color_Red4                    RGB(247, 58, 70)
#define Color_Red5                    RGB(241, 62, 58)
#define Color_Red6                    RGB(236, 49, 45)
#define Color_Red7                    RGB(252, 19, 41)
#define Color_Red8                    RGB(242, 53, 86)
#define Color_Red9                    RGB(255, 45, 72)
#define Color_Red10                   RGB(254, 85, 46)
#define Color_Red11                   RGB(245, 87, 119)

#endif /* ColorMarco_h */
