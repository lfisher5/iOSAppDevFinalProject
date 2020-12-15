//
//  ScanViewController.swift
//  FitnessApp
//
//  Created by Lauren Fisher on 12/1/20.
//

import UIKit
import AVFoundation
import Photos
import WebKit

class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate  {
    

    var video = AVCaptureVideoPreviewLayer()
    var scannedMachineToAdd: Machine? = nil
    var session: AVCaptureSession!
    let webView = WKWebView()
    @IBOutlet var backToScan: UIBarItem!
    var availableMachineWeightArray : [String] = UserDefaults.standard.object(forKey: "machineWeightArray") as? [String] ?? [String]()
   // var backToScanEnabled: Bool = false
    
    
    override func viewDidLoad() {
        print(availableMachineWeightArray)
        super.viewDidLoad()
        print("hello")
        //backToScanEnabled = true
        //Creating session
        session = AVCaptureSession()
        //define capture device
        if let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) {
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        }
        catch {
            print("error")
        }
            
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        session.startRunning()
    }


}


    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        //backToScan.isEnabled = false
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                self.session.stopRunning()
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                let alert = UIAlertController(title: "Machine Tutorial", message: stringValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Go to Video", style: .default, handler: { (action) in
                    
                    if let link = URL(string: stringValue) {
                        self.view = self.webView
                        let request = URLRequest(url: link)
                        self.webView.load(request)
                        self.backToScan.isEnabled = true
                        //UIApplication.shared.open(link)
                    }
                   
                }))
                alert.addAction(UIAlertAction(title: "Save Machine Info", style: .default, handler: { (action) -> Void in
                    
                    self.scannedMachineToAdd = Machine(name: "", weight: 0, numReps: 0, description: "", tutorialLink: stringValue)
                    let modalVC = self.storyboard?.instantiateViewController(withIdentifier: "addMachineFromScan") as! SavedMachineDetailView
                    let navBarOnModal: UINavigationController = UINavigationController(rootViewController: modalVC)
                    self.present(navBarOnModal, animated: true) {
                        modalVC.machineOptional = self.scannedMachineToAdd
                    }
                    
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
                    self.session.startRunning()
                }))
                present(alert, animated: true, completion: nil)
                
            }

        }
    
    @IBAction func backToScanningButtonPressed(sender: UIBarItem) {
        session = AVCaptureSession()
        //define capture device
        if let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) {
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        }
        catch {
            print("error")
        }
            
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        session.startRunning()
    }
    }
    

 }

