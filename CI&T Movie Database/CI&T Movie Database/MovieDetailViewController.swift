//
//  MovieDetailViewController.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 26/07/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet var textView: UITextView!

    @IBOutlet var showButton: UIButton!
    @IBOutlet var textViewHeight: NSLayoutConstraint!
    @IBAction func showButtonClick(_ sender: UIButton) {
        if sender.tag == 0 {
            textViewHeight.constant = textView.contentSize.height
            showButton.setTitle("Show Less", for: .normal)
            sender.tag = 1
        } else {
            textViewHeight.constant = 128
            showButton.setTitle("Show More", for: .normal)
            sender.tag = 0
        }
    }

    struct MovieDetailInfo {
        let title: String
        let voteAverage: String
        let duration: String
        let pipe: String = "|"
        let rating: String
        let genres: [String]
        let synopsis: String
    }

    let movieDetailInfo: MovieDetailInfo = .init(title: "John Wick 3: Parabellum", voteAverage: "4.6", duration: "2hr 10", rating: "R", genres: ["Action", "Crime", "Thriller"], synopsis: "With the untimely death of his beloved wife still bitter in his mouth, John Wick, the expert former assassin, receives one final gift from her--a precious keepsake to help John find a new meaning in life now that she is gone. But when the arrogant Russian mob prince, Iosef Tarasov, and his men pay Wick a rather unwelcome visit to rob him of his prized 1969 Mustang and his wife's present, the legendary hitman will be forced to unearth his meticulously concealed identity. Blind with revenge, John will immediately unleash a carefully orchestrated maelstrom of destruction against the sophisticated kingpin, Viggo Tarasov, and his family, who are fully aware of his lethal capacity. Now, only blood can quench the boogeyman's thirst for retribution.")

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
