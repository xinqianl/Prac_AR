//
//  TestViewController.m
//  SquareCam 
//
//  Created by Xinqian Li on 8/14/16.
//
//

#import "BodyViewController.h"
#import "UIImage+animatedGIF.h"
@interface BodyViewController ()

@end

@implementation BodyViewController

- (void)viewDidLoad {
    self.flag = YES;
    [super viewDidLoad];
    self.title = @"Body";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(helper)
     forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"Try clothes" forState:UIControlStateNormal];
    button.frame = CGRectMake(100.0, 250.0, 160.0, 40.0);
    [self.view addSubview:button];
    [self helper];
    [self performBackgroundTask];
    // Do any additional setup after loading the view.
    
}
//-(void)viewDidDisappear:(BOOL)animated{
//    self.flag = NO;
//}
- (void)performBackgroundTask
{
    dispatch_queue_t serverDelaySimulationThread = dispatch_queue_create("com.xxx.serverDelay", nil);
    dispatch_async(serverDelaySimulationThread, ^{
        while (self.flag) {
            
            [NSThread sleepForTimeInterval:0.2];
            [self query];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            }
                           );
        }
    });
    
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    self.flag = NO;
//    [super viewWillAppear:animated];
//}

- (void) query{
    
    NSString *link = @"http://ec2-184-72-73-84.compute-1.amazonaws.com/job";
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:link];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if(error == nil)
    {
                                                            
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                            
    self.idNum = [[jsonResponse valueForKey:@"itemId"] intValue];
    NSString *action= [jsonResponse valueForKey:@"action"];
    NSString *part = [jsonResponse valueForKey:@"part"];
    NSLog(@"part %@", part);
    NSLog(@"outside if clause action %@", action);
    NSLog(@"outside id %li", self.idNum);
    if([action isEqualToString:@"toShow"]){
        NSLog(@"inside action %@",action);
        NSLog(@"inside id %li", self.idNum);
        if([part isEqualToString:@"Up"]){
            if(self.idNum == 1){
                [self.imgView1 setFrame:CGRectMake(150, 310, 308, 342)];
                self.imgView1.image = [UIImage imageNamed:@"indian.png"];

            }
            if(self.idNum == 3){
                [self.imgView1 setFrame:CGRectMake(150, 310, 287, 319)];
                self.imgView1.image = [UIImage imageNamed:@"green.png"];
            }
            if(self.idNum==2){
                [self.imgView1 setFrame:CGRectMake(150, 310, 287, 319)];
                self.imgView1.image = [UIImage imageNamed:@"purple.png"];
            }
        }
        if([part isEqualToString:@"Down"]){
            if(self.idNum == 7){
                [NSThread sleepForTimeInterval:2.0];
                [self.imgView2 setFrame:CGRectMake(185, 580, 210, 190)];
                self.imgView2.image = [UIImage imageNamed:@"shorts.png"];
            }
            if(self.idNum == 8){
                [self.imgView2 setFrame:CGRectMake(200, 550, 183, 209)];
                self.imgView2.image = [UIImage imageNamed:@"shorts3.png"];
            }
        }
    }
    
    [imagePickerController setCameraOverlayView:self.imgView];
                                                            
    //[self presentModalViewController:imagePickerController animated:YES];
                                                            
                                                        }
                                                        
                                                    }];
    
    [dataTask resume];
}
- (void) helper{
    if (popoverController)
        return;
    
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    
    imagePickerController.mediaTypes = [NSArray arrayWithObject:@"public.image"];
    
    imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;


    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500, 600)];
    
    self.imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(126, 520, 120, 130)];
    self.imgView2.image = nil;
    
    
    self.imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(88, 350, 200, 200)];
    self.imgView1.image = nil;
    // green/purple done
//    [self.imgView1 setFrame:CGRectMake(150, 310, 287, 319)];
//    self.imgView1.image = [UIImage imageNamed:@"green.png"];
//
//    [self.imgView2 setFrame:CGRectMake(200, 580, 190, 190)];
//    self.imgView2.image = [UIImage imageNamed:@"jeans.png"];
    
    [self.imgView addSubview:self.imgView2];
    [self.imgView addSubview:self.imgView1];
    
    
//    [self.imgView addSubview:self.imgView3];
//    [self.imgView addSubview:self.imgView4];
    
    
//***** add gif
//    UIImage* mygif = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"http://i63.tinypic.com/5a4yeo.gif"]];
//    UIImageView *test = [[UIImageView alloc] initWithFrame:CGRectMake(0, 730, 800, 300)];
//    test.image = mygif;
//    [self.imgView addSubview:test];
    
    [imagePickerController setCameraOverlayView:self.imgView];
    
    [self presentModalViewController:imagePickerController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
