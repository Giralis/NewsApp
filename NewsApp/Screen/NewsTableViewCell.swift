//
//  NewsTableViewCell.swift
//  TestTestTestttettstst
//
//  Created by Владимир Тимофеев on 18.11.2021.
//

import UIKit


class NewsTableViewCell: UITableViewCell {

    static let identifier = "cell"
    lazy var imageCache = NSCache<NSString, UIImage>()
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    //MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsImageView)
        allConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: constraints
    private  func allConstraints() {
        newsImageViewConstraints()
        newsTitleLableConstraints()
    }
    private  func newsImageViewConstraints() {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor,constant: -12).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        newsImageView.widthAnchor.constraint(equalToConstant: 190).isActive = true
    }
    private  func newsTitleLableConstraints() {
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 10).isActive = true
        newsTitleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -20).isActive = true
        newsTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: Article){
        newsTitleLabel.text = viewModel.title
        newsImageView.image = UIImage(named: "placeholder")
        if let url = viewModel.urlToImage {
            newsImageView.downloadImageFrom(link: url, contentMode: .scaleToFill)
        }
    }
    
}
