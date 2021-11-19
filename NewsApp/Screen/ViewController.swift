//
//  ViewController.swift
//  TestTestTestttettstst
//
//  Created by Владимир Тимофеев on 18.11.2021.
//

import UIKit

class ViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    private var news = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        configureTableView()
        getNews()
        setRefreshControl()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    //MARK: getting data
    func getNews() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.news = articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: Refresh Control
    let refreshControl = UIRefreshControl()

    func setRefreshControl() {
       refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
       refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
       tableView.addSubview(refreshControl)
    }

    @objc func refresh(_ sender: AnyObject) {
       getNews()
    }
    
}

//MARK: TableView DataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "passNews", sender: self)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.view.layoutIfNeeded()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else { fatalError() }
        
        let news = news[indexPath.row]
        cell.configure(with: news)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passNews" {
            let indexPath = tableView.indexPathForSelectedRow!
            let detailVC = segue.destination as! DetailViewController
            detailVC.news = news[indexPath.row]
        }
    }
    
}

//MARK: TableView Delegate
extension ViewController: UITableViewDelegate {
    
}
