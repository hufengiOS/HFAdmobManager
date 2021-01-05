//
//  VSTableAdsCell.h
//  VPN-SpeedPro
//
//  Created by hf on 2020/11/25.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface VSTableAdsCell : UITableViewCell

@property (nonatomic, strong) UIView *mainView;

@end


@interface UITableView (VSTableAdsCell)

- (VSTableAdsCell *)createVSTableAdsCell;
@end

NS_ASSUME_NONNULL_END
