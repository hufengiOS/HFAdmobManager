//
//  VSTableAdsCell.m
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/25.
//

#import "VSTableAdsCell.h"

static NSString *VSTableAdsCellCellID = @"VSTableAdsCellCellID";

@interface VSTableAdsCell ()


@end

@implementation VSTableAdsCell

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

#pragma mark - Public
+ (CGFloat)heightOfCell {
    return 44.;
}

#pragma mark - Private
/**
 创建视图
 */
- (void)p_createView {
    self.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.mainView];
}

/**
 设置布局
 */
- (void)p_addFrame {
    
}

#pragma mark - Actions

#pragma mark - Lazy
- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = UIColor.whiteColor;
        _mainView.layer.cornerRadius = 10;
        _mainView.layer.masksToBounds = YES;
        _mainView.frame = CGRectMake(15, 0, self.frame.size.width - 30, 148);
    }
    return _mainView;
}

@end

@implementation UITableView (VSTableAdsCell)

- (VSTableAdsCell *)createVSTableAdsCell {
    VSTableAdsCell *cell = [self dequeueReusableCellWithIdentifier:VSTableAdsCellCellID];
    if (cell == nil) {
        cell = [[VSTableAdsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VSTableAdsCellCellID];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return cell;
}

@end

