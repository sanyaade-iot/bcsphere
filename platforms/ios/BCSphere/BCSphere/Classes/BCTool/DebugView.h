//
//  DebugView.h
//  BCSphere
//
//  Created by NPHD on 14-5-12.
//
//

#import <UIKit/UIKit.h>
#import "BCBluetooth.h"

@interface DebugView : UIView<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UITextField *searchTextField;

}
@property (strong,nonatomic) NSMutableArray *information;
@property (strong,nonatomic) UITableView *debugTableView;

- (void)refresh:(NSMutableArray *)information;
@end
