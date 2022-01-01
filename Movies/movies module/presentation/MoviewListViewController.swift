//
//  MoviewListViewController.swift
//  Movies
//
//  Created by azah on 12/30/21.
//

import UIKit
import RxSwift
class MoviewListViewController: UIViewController {
    var pagNumber: Int = 1
    var maxPagNumber: Int = 0
    var popularMoviesList: [MoviesUIViewModel] = []
    private var viewModel: MoviesListViewModel
    private var disposeBag = DisposeBag()
    private var result: Disposable?

    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MoviewListViewController", bundle: nil)
    }
    
    @IBOutlet weak var popularMoviesCollectionView: UICollectionView!

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerPopularMovieCell()
        setCollectionViewDelegates()
        setSubscriber()
        callMoviePopularListRequest()
    }
    
    private func registerPopularMovieCell(){
        popularMoviesCollectionView.register(UINib(nibName: "PopularMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PopularMovieCollectionViewCell")
    }
    
    
//    private func pullToRefresh() {
//        popularMoviesCollectionView.es.addPullToRefresh { [weak self] in
//            guard let self = self else { return }
//            self.popularMoviesList = []
//            self.pagNumber = 0
//            self.popularMoviesCollectionView.reloadData()
//            self.callMoviePopularListRequest()
//            self.popularMoviesCollectionView.es.resetNoMoreData()
//            self.popularMoviesCollectionView.es.stopPullToRefresh(ignoreDate: true)
//        }
//    }

    private func setCollectionViewDelegates(){
        popularMoviesCollectionView.delegate = self
        popularMoviesCollectionView.dataSource = self
    }
 
    private func callMoviePopularListRequest(){
        self.showLoadinIndicator(viewController: self)
        let request = PopularMoviesRequest(api_key: AppConstants.api_key.rawValue, language: AppConstants.language.rawValue, page: pagNumber, region: "")
        viewModel.getPopularMovieList(params: request)
    }
    
    private func setSubscriber(){
        result = viewModel.getPopularMoviesSubject.subscribe({[weak self ] event in
            if let element = event.element {
                self?.handleResult(result: element)
            }
        })
        result?.disposed(by: disposeBag)
    }

    
    private func handleResult(result: GetPopularMoviesViewModelStatus){
        switch result {
        case .fail:
            self.removeLoadingIndicator(viewController: self)
        case .sucess(let data):
            self.removeLoadingIndicator(viewController: self)
            pagNumber = data.pageNum
            maxPagNumber = data.totalNumOfPages
            appendMovies(movies: data.popularMovies)
            popularMoviesCollectionView.reloadData()
        case .loading:
            break
        }
    }
    func appendMovies(movies: [MoviesUIViewModel]){
        if pagNumber <= maxPagNumber {
            popularMoviesList += movies
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
        return CGSize(width: setCollectionViewCellColums(colum: 2, collectionLayout: collectionViewLayout as! UICollectionViewFlowLayout), height: 200)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if pagNumber < maxPagNumber && indexPath.row == popularMoviesList.count - 1 {
            pagNumber += 1
            callMoviePopularListRequest()
        } else if  indexPath.row == 0 &&  pagNumber > 1 {
            pagNumber = 1
            popularMoviesList = []
            callMoviePopularListRequest()
        }
    }
}
