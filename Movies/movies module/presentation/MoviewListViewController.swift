//
//  MoviewListViewController.swift
//  Movies
//
//  Created by azah on 12/30/21.
//

import UIKit
import RxSwift
class MoviewListViewController: UIViewController {
    
    @IBOutlet weak var popularMoviesCollectionView: UICollectionView!
    var popularMoviesList: [MoviesUIViewModel] = []
    private var viewModel: MoviesListViewModel
    private var disposeBag = DisposeBag()

    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MoviewListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerPopularMovieCell()
        setSubscriber()
    }
    
    func registerPopularMovieCell() {
        popularMoviesCollectionView.register(UINib(nibName: "PopularMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PopularMovieCollectionViewCell")
    }
 
    
    private func setSubscriber() {
        viewModel.getPopularMoviesSubject.subscribe({[weak self ] event in
            if let element = event.element {
                self?.handleResult(result: element )
            }
        }).disposed(by: disposeBag)
    }

    
    private func handleResult(result: GetPopularMoviesViewModelStatus) {
        switch result {
        case .fail:
          break
        case .sucess(let data):
            popularMoviesList = data.popularMovies
            popularMoviesCollectionView.reloadData()
        case .loading:
            break
        }

    }
}
extension MoviewListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMoviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMovieCollectionViewCell", for: indexPath) as! PopularMovieCollectionViewCell
        cell.configure(movie: popularMoviesList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: setCollectionViewCellColums(colum: 2, collectionLayout: collectionViewLayout as! UICollectionViewFlowLayout), height: 150)
    }
    func setCollectionViewCellColums(colum: CGFloat, collectionLayout: UICollectionViewFlowLayout) -> CGFloat {
        
         let columns: CGFloat = colum
         let collectionViewWidth = popularMoviesCollectionView.bounds.width
         let flowLayout = collectionLayout
         let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
         let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
         let adjustedWidth = collectionViewWidth - spaceBetweenCells - sectionInsets
        let width: CGFloat = floor(adjustedWidth / colum)
        return width
    }
    
}
