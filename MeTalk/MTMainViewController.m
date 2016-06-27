//
//  MTMainViewController.m
//  MeTalk
//
//  Created by yu chung hyun on 2016. 4. 15..
//  Copyright © 2016년 yu chung hyun. All rights reserved.
//

#import "MTMainViewController.h"

#import "MeTalk-swift.h"

typedef enum {
    MTViewTypeRecorder,
    MTViewTypeHistory,
} MTViewType;


@interface MTMainViewController ()
{
 
    MTViewType _viewType;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightButton;
@property(nonatomic) MTViewType viewType;
@property(nonatomic,strong) UIViewController *currentChildViewController;
@end

@implementation MTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewType = MTViewTypeRecorder;
    
//    [self.navigationController.navigationBar setHidden:YES];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBtnRight:(id)sender
{
    if(self.viewType == MTViewTypeHistory)
    {
        self.viewType = MTViewTypeRecorder;
    } else
    {
        self.viewType = MTViewTypeHistory;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


- (void)setViewType:(MTViewType)viewType
{
    _viewType = viewType;
    if(viewType == MTViewTypeRecorder)
    {
        [self _showRecorder];
    } else
    {
        [self _showHistory];
    }
}

- (void) _showRecorder
{
    MTRecordViewController *vc = [[MTRecordViewController alloc] initWithNibName:@"MTRecordViewController" bundle:nil];
    [self _transitionChildViewController:vc];
    
    //change image barbuttonItem after changing childviewcontroller
    [self.rightButton setImage:[UIImage imageNamed:@"newsfeed_red"]];
}

- (void) _showHistory
{
    MTHistoryViewController *vc = [[MTHistoryViewController alloc] initWithNibName:@"MTHistoryViewController" bundle:nil];
    [self _transitionChildViewController:vc];
    
    //change image barbuttonItem after changing childviewcontroller
    [self.rightButton setImage:[UIImage imageNamed:@"micIcon"]];
    
}




- (void) _transitionChildViewController:(UIViewController*)newVC
{
    //if currentChildViewController exist, remove it first before add.
    if(self.currentChildViewController)
    {
        [self.currentChildViewController willMoveToParentViewController:self];
        [self.currentChildViewController removeFromParentViewController];
        [self.currentChildViewController.view removeFromSuperview];
        self.currentChildViewController = nil;
    }
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addChildViewController:newVC];
    newVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:newVC.view];
    [newVC didMoveToParentViewController:self];
    
    UIView *childView = newVC.view;
    NSDictionary *views = NSDictionaryOfVariableBindings(childView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[childView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[childView]-|" options:0 metrics:nil views:views]];
    self.currentChildViewController = newVC;
    
    [self.view setNeedsDisplay];
}

@end
