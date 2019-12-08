//
//  ViewController.swift
//  SberProject
//
//  Created by Konstantin Nikandrov on 03.12.2019.
//  Copyright © 2019 Konstantin Nikandrov. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let secondVC = TableViewController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        startButton.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        view.addSubview(startButton)
        textField.center = CGPoint(x: view.center.x, y: view.center.y - 50)
        view.addSubview(textField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    var startButton: UIButton = {
        let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        startButton.backgroundColor = UIColor.blue
        startButton.setTitle("Начать", for: .normal)
        startButton.layer.cornerRadius = 15
        startButton.addTarget( self, action: #selector(start), for: .touchUpInside)
        return startButton
    }()
    
    var textField: UITextField = {
       let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        textField.backgroundColor = .white
        return textField
    }()
    
    @objc
    func start(){
       
    navigationController?.pushViewController(secondVC, animated: true)
        
    }
    
   
}



