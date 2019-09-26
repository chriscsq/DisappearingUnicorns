//
//  DetailsViewController.swift
//  DisappearingUnicorns
//
//  Created by Chris Chau on 2019-09-25.
//  Copyright © 2019 Chris Chau. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    var playerInfo: PlayerData?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let playerInfo = playerInfo {
            photoView.image = playerInfo.photo
            nameLabel.text = playerInfo.name
            rankLabel.text = "Rank #\(playerInfo.rank)"
            pointsLabel.text = "\(playerInfo.points) points"
        }
        // Do any additional setup after loading the view.
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
