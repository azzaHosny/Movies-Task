//
//  PopularMovieCollectionViewCell.swift
//  Movies
//
//  Created by azah on 12/31/21.
//

import UIKit
import SDWebImage

class PopularMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(movie: MoviesUIViewModel) {
        movieNameLB.text = movie.movieName
        try? movieImage.downloadImage(url: movie.movieImage, placeHolder: UIImage(named: "recent.png"))
    }

}
