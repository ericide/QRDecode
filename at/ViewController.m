//
//  ViewController.m
//  at
//
//  Created by junlei on 15/7/2.
//  Copyright (c) 2015年 HA. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic,strong)AVCaptureSession * captureSession;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSError * error = nil;
    self.captureSession = [[AVCaptureSession alloc]init];
    
    AVCaptureDevice * videoCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput * videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoCaptureDevice error:&error];
    
    // 因为模拟器是没有摄像头的，因此在此最好做一个判断
    if (error) {
        NSLog(@"没有摄像头-%@", error.localizedDescription);
        return;
    } else {
        [self.captureSession addInput:videoInput];
    }
    
    
    
    
    AVCaptureVideoPreviewLayer * previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    previewLayer.frame = [UIScreen mainScreen].bounds;
    
    [self.view.layer addSublayer:previewLayer];
    
    
    
    AVCaptureMetadataOutput * qrdata = [[AVCaptureMetadataOutput alloc]init];
    //必须提前添加此代码,否则添加扫描类型会报错
    [self.captureSession addOutput:qrdata];
    
    [qrdata setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    CGRect rect = CGRectMake(100, 300, 550, 850);
    CGSize size   = CGSizeMake(750, 1334);
    
    [qrdata setRectOfInterest:CGRectMake(rect.origin.y/size.height,rect.origin.x/size.width, rect.size.height/size.height, rect.size.width/size.width)];
    
     [qrdata setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    
    [self.captureSession startRunning];
    
    UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qc"]];
    image.frame = self.view.frame;
    [self.view addSubview:image];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 输出代理方法

// 此方法是在识别到QRCode，并且完成转换

// 如果QRCode的内容越大，转换需要的时间就越长

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection

{
    
    // 会频繁的扫描，调用代理方法
    
    // 1. 如果扫描完成，停止会话
    
    [self.captureSession stopRunning];
    
    // 2. 删除预览图层
    
    //[self.previewLayerremoveFromSuperlayer];
    
    
    
    NSLog(@"%@", metadataObjects);
    
    // 3. 设置界面显示扫描结果
    
    
    
//    if (metadataObjects.count > 0) {
//        
//        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
//        
//        // 提示：如果需要对url或者名片等信息进行扫描，可以在此进行扩展！
//        
//        _captureLabel.text = obj.stringValue;
//        
//    }
    
}

// 在storyBoard中添加的按钮的连线的点击事件,一点击按钮就提示用户打开摄像头并扫描

- (IBAction)capture {
    
    //扫描二维码
    
    //[self readQRcode];
    
}



@end
