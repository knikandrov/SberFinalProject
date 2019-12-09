//
//  TableViewController.swift
//  SberProject
//
//  Created by Konstantin Nikandrov on 05.12.2019.
//  Copyright © 2019 Konstantin Nikandrov. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var items = [Items]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    let itemService = ItemsService.shared
    let itemPost = ItemPost()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
      DispatchQueue.main.async {
          self.itemPost.Post { [weak self] result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let jsonData):
                        self?.items = jsonData
                    }
                }
      }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
        if let imageURL = URL(string: "http:" + items[indexPath.row].url) {
            cell.setImage(imageURL: imageURL)
        }
        return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 350
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thirdVC = ItemViewController()
        if let imageURL = URL(string: "http:" + items[indexPath.row].url) {
                   thirdVC.setImage(imageURL: imageURL)
               }
        let id = items[indexPath.row].id
        print(id)
        DispatchQueue.main.async {
            self.itemPost.PostID(withparameter:"\(id)") { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let jsonData):
                    self.itemService.singleItem = [jsonData]
                }
            }
        }
        
        navigationController?.pushViewController(thirdVC, animated: true)
    }
    
    func setupUI() {
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor)
            ])
    }
    
}
