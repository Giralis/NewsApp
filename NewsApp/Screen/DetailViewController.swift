//
//  DetailViewController.swift
//  TestTestTestttettstst
//
//  Created by Владимир Тимофеев on 19.11.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var news: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
        imageViewTap()
    }
    //MARK: set subviews
    func setSubviews() {
        newsTitleLabel.text = news?.title
        newsDescriptionLabel.text = news?.description
        dateLabel.text = getFormattedDate(string: news!.publishedAt)
        
        newsImageView.image = UIImage(named: "placeholder")
        if let url = news.urlToImage {
            newsImageView.downloadImageFrom(link: url, contentMode: .scaleAspectFit)
        }
    }
    
    //MARK: work with date
    func getFormattedDate(string: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        let date: Date? = dateFormatterGet.date(from: string)
        return dateFormatterPrint.string(from: date!);
    }
    
    //MARK: tapGesture on imageView
    func imageViewTap() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.imageTappedMethod(_:)))

        newsImageView.isUserInteractionEnabled = true
        newsImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTappedMethod(_ sender:AnyObject){
        self.performSegue(withIdentifier: "imagePresent", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imagePresent" {
            let imageViewController = segue.destination as! ImageViewController
            imageViewController.image = newsImageView.image
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
