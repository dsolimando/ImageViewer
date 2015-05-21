//
//  ImageViewerViewController.m
//  ImageViewer
//
//  Created by Damien Solimando on 17/05/15.
//  Copyright (c) 2015 Solidx. All rights reserved.
//

#import "ImageViewerViewController.h"

@implementation ImageViewerViewController {
    BOOL _swipe;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _swipe = false;
    
    self.imageView.alpha = 0;
    
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 6.0;
    self.activityIndicator.hidesWhenStopped = YES;
    [self.activityIndicator startAnimating];
    self.panGestureRecognizer.delegate = self;
    self.view.contentMode = UIViewContentModeScaleAspectFit;
    
    
    
    self.closeButton.transform = CGAffineTransformMakeRotation(M_PI_2/2);
    
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);
    dispatch_async(queue, ^{
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlString]]];
        if (self.imageView){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.imageView setImage:image];
                NSLog(@"%f",self.imageView.image.size.height);
                NSLog(@"%f",self.imageView.frame.size.height);
                _fittedImageSize = self.imageView.image.size.height *(self.view.frame.size.width/self.imageView.image.size.width);
                [self.activityIndicator stopAnimating];
                [UIView animateWithDuration:0.2 animations:^{
                    self.imageView.alpha = 1;
                }];
                
            });
        }
    });
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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

- (IBAction)onButtonClick:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL completed){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)onPan:(id)sender {
    
    if (self.scrollView.zoomScale == 1) {
        UIPanGestureRecognizer *panRecognizer = (UIPanGestureRecognizer*)sender;
        
        _swipe = ABS([panRecognizer velocityInView:self.view].y) > 2000;
        
        if ([panRecognizer state] == UIGestureRecognizerStateEnded && !_swipe) {
            
            [UIView animateWithDuration:0.2 animations:^{
                self.imageView.transform = CGAffineTransformMakeTranslation(0, 0);
            }];
        } else if (!_swipe) {
            self.imageView.transform = CGAffineTransformMakeTranslation(0, [panRecognizer translationInView:self.view].y);
        } else if(_swipe) {
            [UIView animateWithDuration:0.2 animations:^{
                self.view.alpha = 0;
                int toGo;
                if ([panRecognizer translationInView:self.view].y > 0)
                    toGo = self.scrollView.frame.size.height / 2;
                else
                    toGo = -self.scrollView.frame.size.height / 2;
                self.imageView.transform = CGAffineTransformMakeTranslation(0, toGo);
            } completion:^(BOOL b){
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }

    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    self.closeButton.alpha = 0;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    if (scale == 1) {
        [UIView animateWithDuration:0.2 animations:^{
            self.closeButton.alpha = 1;
        }];
       
    }
    else {
        int insetTop = -((self.imageView.frame.size.height/2) - (_fittedImageSize*scale/2));
        self.scrollView.contentInset = UIEdgeInsetsMake(insetTop, 0, insetTop, 0);
    }
}


- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
    
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
