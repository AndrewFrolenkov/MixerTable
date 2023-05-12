//
//  ViewController.swift
//  MixerTable
//
//  Created by Андрей Фроленков on 10.05.23.
//

import UIKit

class ViewController: UIViewController {
  
  let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    return tableView
  }()
  
  var boolArray = [Bool]()
  var array = [String]()
  var indexPathArray = [IndexPath]()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    view.backgroundColor = .white
    
    setupConstraints()
    configureTableView()
    configureBarButtonItem()
    configureTableView()
    
    for i in 0...30 {
      array.append(i.description)
      boolArray.append(false)
    }
    
  }
  
  private func configureTableView() {
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
  }
  
  private func configureBarButtonItem() {
    
    title = "Task 4"
    
    let appearance = UINavigationBarAppearance()
    
    appearance.shadowColor = .clear
    
    appearance.backgroundColor = tableView.backgroundColor
    appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shuffle", style: .plain, target: self, action: #selector(buttonTapped))
  }
  
  private func setupConstraints() {
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])
  }
  
  @objc private func buttonTapped() {
    
    
    for _ in 0...30 {
      
      let randomOne = Int.random(in: 0...30)
      let randomTwo = Int.random(in: 0...30)
      
      
      tableView.moveRow(at: [0, randomOne], to: [0, randomTwo])
      
      
    }
    
    
  }
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 31
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    self.indexPathArray.append(indexPath)
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    var config = cell.defaultContentConfiguration()
    config.text = array[indexPath.row]
    cell.contentConfiguration = config
    
    if boolArray[indexPath.row] {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
    
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let cell = tableView.cellForRow(at: indexPath)
    
    let string = array[indexPath.row]
    if cell?.accessoryType == .checkmark {
      cell?.accessoryType = .none
      boolArray.remove(at: indexPath.row)
      boolArray.insert(false, at: 0)
      array.remove(at: indexPath.row)
      array.insert(string, at: 0)
      
    } else {
      cell?.accessoryType = .checkmark
      boolArray.remove(at: indexPath.row)
      boolArray.insert(true, at: 0)
      array.remove(at: indexPath.row)
      array.insert(string, at: 0)
      
    }
    tableView.deselectRow(at: indexPath, animated: true)
    tableView.moveRow(at: indexPath, to: [0, 0])
    
    
  }
  
}



