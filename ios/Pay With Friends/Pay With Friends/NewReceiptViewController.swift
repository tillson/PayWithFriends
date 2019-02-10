//
//  NewReceipt.swift
//  Pay With Friends
//
//  Created by Charles on 2/9/19.
//  Copyright © 2019 Dangling Pointers LLC. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import WVCheckMark

class NewReceiptViewController: UIViewController {
    
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var checkmark: WVCheckMark!
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        
        navigationController?.navigationBar.tintColor = .white
        
        captureButton.layer.cornerRadius = 15
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            cameraView.layer.addSublayer(videoPreviewLayer!)
            
            captureSession?.startRunning()
            
        } catch { print(error) }

    }
    
    @IBAction func captureClicked(_ sender: Any) {
        
        var capturePhotoOutput: AVCapturePhotoOutput?
        capturePhotoOutput = AVCapturePhotoOutput()
        capturePhotoOutput?.isHighResolutionCaptureEnabled = true
        
        captureSession?.addOutput(capturePhotoOutput!)
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .on
        
        capturePhotoOutput!.capturePhoto(with: photoSettings, delegate: self)
        
        
    }
    
}

extension NewReceiptViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                     previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                 resolvedSettings: AVCaptureResolvedPhotoSettings,
                 bracketSettings: AVCaptureBracketedStillImageSettings?,
                 error: Error?) {
        guard error == nil,
            let photoSampleBuffer = photoSampleBuffer else {
                print("Error capturing photo: \(String(describing: error))")
                return
        }
        guard let imageData =
            AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) else {
                return
        }
        
        
        let capturedImage = UIImage.init(data: imageData , scale: 0.001)!
        
        let data = capturedImage.jpegData(compressionQuality: 0.000001)!
        checkmark.start()
        NetworkManager.shared.uploadReceipt(data: data, onSuccess: { response in
            print(response)
            self.navigationController?.popViewController(animated: true)
        }, onFailure: { error in
            print(error)
        })

    }
}
