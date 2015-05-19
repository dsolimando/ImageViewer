//
//  ImageViewerViewController.m
//  ImageViewer
//
//  Created by Damien Solimando on 17/05/15.
//  Copyright (c) 2015 Solidx. All rights reserved.
//

#import "ImageViewerViewController.h"

@implementation ImageViewerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.alpha = 0;
    
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 6.0;
    self.activityIndicator.hidesWhenStopped = YES;
    [self.activityIndicator startAnimating];
    
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);
    dispatch_async(queue, ^{
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlString]]];
        if (self.imageView){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.imageView setImage:image];
                [self.activityIndicator stopAnimating];
                [UIView animateWithDuration:0.2 animations:^{
                    self.imageView.alpha = 1;
                }];
                
            });
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (IBAction)onDoubleTap:(id)sender {
    UITapGestureRecognizer *recognizer = sender;
    
    double scale = 6.0;
    
    if (self.scrollView.zoomScale > 1)
        scale = 1.0;
    
    [self.scrollView zoomToRect:[self zoomRectForScrollView:self.scrollView withScale:scale withCenter:[recognizer locationInView:self.scrollView]] animated:YES];
}

- (IBAction)onSwipe:(id)sender {
    if (self.scrollView.zoomScale > 1)
        return;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.view.alpha = 0;
        self.imageView.alpha = 0;
        self.imageView.transform = CGAffineTransformMakeTranslation(0,  -self.scrollView.frame.size.height / 2);
    } completion:^(BOOL b){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
    
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

@end
