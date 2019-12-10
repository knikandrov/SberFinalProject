//
//  TableViewController.swift
//  SberProject
//
//  Created by Konstantin Nikandrov on 05.12.2019.
//  Copyright © 2019 Konstantin Nikandrov. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let itemService = ItemsService.shared
    let itemPost = ItemPost()
    let tableView = UITableView()
    let thirdVC = ItemViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
        
        print(itemService.items)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemService.items.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
        if let imageURL = URL(string: "http:" + itemService.items[indexPath.row].url) {
            cell.setImage(imageURL: imageURL)
        }
        cell.titleLabel.text = "Брэнд: \(itemService.items[indexPath.row].title)"
        cell.priceLabel.text = "Цена на Lamoda: \(itemService.items[indexPath.row].price)"
        return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 350
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let imageURL = URL(string: "http:" + itemService.items[indexPath.row].url) {
                   thirdVC.setImage(imageURL: imageURL)
               }
        let id = itemService.items[indexPath.row].id
        print(id)
        DispatchQueue.main.async {
            self.itemPost.PostID(withparameter:"\(id)") { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let jsonData):
                    self.itemService.singleItem = [jsonData]
                    DispatchQueue.main.sync {
                        self.thirdVC.descriptionLabel.text = "Описание: \(self.itemService.singleItem[0].description)"
                    }
                }
            }
        }
    
        navigationController?.pushViewController(thirdVC, animated: true)
        
        
    }
    
    func setupUI() {
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
