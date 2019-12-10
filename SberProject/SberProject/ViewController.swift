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
    let itemPost = ItemPost()
    var itemsLocal = ItemsService.shared
    var imageView : UIImageView!
    let secondVC = TableViewController()
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
        self.view.layer.opacity = 1
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.present(parent: self, sourceType: sourceType)
    }
  
    let startButton: UIButton = {
                 let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
                 startButton.backgroundColor = UIColor.white
                 //startButton.setTitle("Поиск одежды", for: .normal)
                 startButton.setImage(UIImage(named: "search"), for: .normal)
                 startButton.layer.cornerRadius = 40
                 startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
                 return startButton
             }()
    
    @objc
    func start(){
        UIView.transition(with: self.view, duration: 1.5, options: .transitionFlipFromBottom, animations: {
            self.startButton.layer.opacity = 0
            self.view.layer.opacity = 0
        }, completion: {
            _ in
        DispatchQueue.main.async {
        self.itemPost.Post(withmedia: self.imgData) { [weak self] result in
                switch result {
                case .failure(let error):
                print(error)
                case .success(let jsonData):
                self!.itemsLocal.items = jsonData
                DispatchQueue.main.async {
                    self!.secondVC.tableView.reloadData()
                }
                
            }
        }
    }
        self.navigationController?.pushViewController(self.secondVC, animated: true)
        })
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
              let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
              startButton.backgroundColor = UIColor.white
              //startButton.setTitle("Поиск одежды", for: .normal)
              startButton.setImage(UIImage(named: "search"), for: .normal)
              startButton.layer.cornerRadius = 40
              startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
              return startButton
          }()
          
        let CameraButton: UIButton = {
             let CameraButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
              CameraButton.backgroundColor = .systemBlue
              CameraButton.layer.cornerRadius = 40
              CameraButton.setImage(UIImage(named: "photo"), for: .normal)

              //CameraButton.setTitle("Сделать фото", for: .normal)
              CameraButton.addTarget(self, action: #selector(OpenCamera), for: .touchUpInside)
              return CameraButton
          }()
        
        let GalleryButton: UIButton = {
            let GalleryButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            GalleryButton.backgroundColor = .systemBlue
            GalleryButton.layer.cornerRadius = 40
            GalleryButton.setImage(UIImage(named: "gallery"), for: .normal)
            //GalleryButton.setTitle("Выбрать фото из галереи", for: .normal)
            GalleryButton.addTarget(self, action: #selector(OpenGallery), for: .touchUpInside)
            return GalleryButton
        }()
        
        let background = UIImage(named: "launchscreen")
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        startButton.center = CGPoint(x: view.center.x, y: view.center.y + 150)
        view.addSubview(startButton)
     
        CameraButton.center = CGPoint(x: view.center.x - 100, y: view.center.y + 100)
        view.addSubview(CameraButton)
        
        GalleryButton.center = CGPoint(x: view.center.x + 100, y: view.center.y + 100)
        view.addSubview(GalleryButton)
        
        MyImageView.frame = view.frame
        view.addSubview(MyImageView)
        let safeArea = view.safeAreaLayoutGuide
        
     NSLayoutConstraint.activate([
         MyImageView.bottomAnchor.constraint(equalTo: safeArea.centerYAnchor),
         MyImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
         MyImageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
         MyImageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
         
         ])
    }
   
}

extension ViewController: ImagePickerDelegate {

    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        MyImageView.image = image
        imgData = MyImageView.image!
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
