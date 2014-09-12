//
//  MasterViewController.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 11/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "HomeViewController.h"

#import "DetailViewController.h"

@interface HomeViewController ()
	@property (nonatomic,strong) UIImageView *titleView;

@end

@implementation HomeViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}


-(void)viewWillAppear:(BOOL)animated {
//
//	UINavigationBar *navBar = self.navigationController.navigationBar;
//	UIImage *image = [UIImage imageNamed:@"logo-axa-glass.png"];
//	[navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
	
	
	//self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-axa-glass.png"]];

	
	UIImage *image = [UIImage imageNamed:@"logo-axa-glass_marge.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	self.titleView = imageView;

	[self.navigationController.navigationBar addSubview:imageView];
	
}

- (void)viewWillDisappear:(BOOL)animated {
	[UIView animateWithDuration:0.4 animations:^{
		[self.titleView removeFromSuperview];
	}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	
	// Do any additional setup after loading the view, typically from a nib.
	//self.navigationItem.leftBarButtonItem = self.editButtonItem;

	//UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
	//self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = _objects[indexPath.row];
//        [[segue destinationViewController] setDetailItem:object];
//    }
//}

@end
