//
//  ImageViewController.swift
//  TestTestTestttettstst
//
//  Created by Владимир Тимофеев on 19.11.2021.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
    }
    
    func setImage() {
        detailImageView.image = image
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
