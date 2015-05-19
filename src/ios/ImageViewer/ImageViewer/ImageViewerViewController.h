//
//  ImageViewerViewController.h
//  ImageViewer
//
//  Created by Damien Solimando on 17/05/15.
//  Copyright (c) 2015 Solidx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewerViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property NSString *urlString;

- (IBAction)onDoubleTap:(id)sender;
- (IBAction)onSwipe:(id)sender;

@end
