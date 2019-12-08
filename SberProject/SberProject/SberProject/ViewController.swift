//
//  ViewController.swift
//  SberProject
//
//  Created by Konstantin Nikandrov on 03.12.2019.
//  Copyright © 2019 Konstantin Nikandrov. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    var imgData = ItemsService.shared.imageData
    
    private let secondVC = TableViewController()
    private lazy var imagePicker = ImagePicker()
    
    let MyImageView: UIImageView = {
                let MyImageView = UIImageView()
                MyImageView.contentMode = .scaleToFill
                MyImageView.translatesAutoresizingMaskIntoConstraints = false
                MyImageView.layer.masksToBounds = true
                return MyImageView
            }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.present(parent: self, sourceType: sourceType)
    }
  
    
    @objc
    func start(){
    navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @objc
    func OpenCamera() {
        imagePicker.cameraAsscessRequest()
    }
    
    @objc
    func OpenGallery() {
        imagePicker.photoGalleryAsscessRequest()
    }
    
    func setupUI() {
    
        let startButton: UIButton = {
              let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
              startButton.backgroundColor = UIColor.blue
              startButton.setTitle("Поиск одежды", for: .normal)
              startButton.layer.cornerRadius = 15
              startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
              return startButton
          }()
          
        let CameraButton: UIButton = {
             let CameraButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
              CameraButton.backgroundColor = .systemBlue
              CameraButton.setTitle("Сделать фото", for: .normal)
              CameraButton.addTarget(self, action: #selector(OpenCamera), for: .touchUpInside)
              return CameraButton
          }()
        
        let GalleryButton: UIButton = {
            let GalleryButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            GalleryButton.backgroundColor = .systemBlue
            GalleryButton.setTitle("Выбрать фото из галереи", for: .normal)
            GalleryButton.addTarget(self, action: #selector(OpenGallery), for: .touchUpInside)
            return GalleryButton
        }()
        
        
   
        
        view.backgroundColor = .red
        startButton.center = CGPoint(x: view.center.x, y: view.center.y + 150)
        //startButton.frame = view.frame
        view.addSubview(startButton)
     
        CameraButton.center = CGPoint(x: view.center.x - 100, y: view.center.y + 100)
       // CameraButton.frame = view.frame
        view.addSubview(CameraButton)
        
        GalleryButton.center = CGPoint(x: view.center.x + 100, y: view.center.y + 100)
      //  GalleryButton.frame = view.frame
        view.addSubview(GalleryButton)
        
        MyImageView.frame = view.frame
        view.addSubview(MyImageView)
        let safeArea = view.safeAreaLayoutGuide
        
     NSLayoutConstraint.activate([
         MyImageView.bottomAnchor.constraint(equalTo: safeArea.centerYAnchor),
         MyImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
         MyImageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
         //MyImageView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, constant: -100),
         MyImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
         
         ])
    }
   
}

extension ViewController: ImagePickerDelegate {

    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        MyImageView.image = image
        imgData = MyImageView.image!.pngData()!
        print(imgData)
        imagePicker.dismiss()
    }

    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) { imagePicker.dismiss() }

    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed { presentImagePicker(sourceType: .photoLibrary) }
    }

    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        // works only on real device (crash on simulator)
        if accessIsAllowed { presentImagePicker(sourceType: .camera) }
    }
}