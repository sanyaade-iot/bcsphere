/*
 Copyright 2013-2014 JUMA Technology
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "DebugView.h"
#import "EventName.h"

@implementation DebugView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self viewOn];
    }
    return self;
}

- (void)viewOn{
    self.backgroundColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        self.debugTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 20) style:(UITableViewStylePlain)];
    }else{
        self.debugTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:(UITableViewStylePlain)];
    }
    self.debugTableView.delegate = self;
    self.debugTableView.dataSource = self;
    [self.debugTableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    self.debugTableView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.debugTableView];
    
    self.information = [[NSMutableArray alloc] init];
    UISwipeGestureRecognizer* recognizerOtherRight;
    recognizerOtherRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    recognizerOtherRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:recognizerOtherRight];
    
    UISwipeGestureRecognizer* recognizerOtherLeft;
    recognizerOtherLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf)];
    recognizerOtherLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:recognizerOtherLeft];
}

- (void)refresh:(NSMutableArray *)information{
    self.information = information;
    [self.debugTableView reloadData];
    [self.debugTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[information count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

- (void)back{
    [[NSNotificationCenter defaultCenter] postNotificationName:DEBUGBACK object:nil];
}

- (void)removeSelf{
    [[NSNotificationCenter defaultCenter] postNotificationName:DEBUGREMOVE object:nil];
}

#pragma mark - tableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.information.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *abc = @"null";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:abc];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:abc];
        
    }
    cell.textLabel.text = [self.information objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor greenColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    [cell.textLabel setHighlighted:NO];
    if ([[UIScreen mainScreen] bounds].size.width > 400) {
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:20.0f];
    }else{
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:11.0f];
    }    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    backView.backgroundColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
    cell.backgroundView = backView;
    return cell;
    
}

#pragma mark - tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}


@end
