//
//  ImageViewerViewController.h
//  ImageViewer
//
//  Created by Damien Solimando on 17/05/15.
//  Copyright (c) 2015 Solidx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewerViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate> {
    
    float _fittedImageSize;
}

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property NSString *urlString;

- (IBAction)onDoubleTap:(id)sender;
- (IBAction)onButtonClick:(id)sender;
- (IBAction)onPan:(id)sender;

@end
