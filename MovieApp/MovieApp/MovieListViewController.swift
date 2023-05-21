import Foundation
import MovieAppData
import UIKit
import Combine

class MovieListViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private var router: Router!
    private var viewModel: MovieListViewModel!
    private var movies: [Movie] = []
    private var disposeables = Set<AnyCancellable>()
    
    init(router: Router, viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

    private func buildViews(){
        fetchData()
        createViews()
        styleViews()
        defineLayout()
    }
    
    private func fetchData(){
        viewModel.fetchMovies()
        viewModel
                .$movies
                .receive(on: DispatchQueue.main)
                .sink { [weak self] movies in
                    guard let self = self else { return }
                        self.movies = movies
                        self.collectionView.reloadData()
                }
                .store(in: &disposeables)
    }
    
    private func createViews(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
    }
    
    private func styleViews(){
        self.title = "Movie List"
        
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        view.backgroundColor = .white
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: MovieListCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
                
    }
    
    private func defineLayout(){
        collectionView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 68)
        collectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        collectionView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        collectionView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 58)
    }
        
}

extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCell.identifier, for: indexPath) as? MovieListCell else {
          return UICollectionViewCell()
        }
    
        let index = indexPath.row
        let url = URL(string: movies[index].imageUrl)
        let name = movies[index].name
        let summary = movies[index].summary
        let movieYear = movies[index].year
        cell.configureCell(url: url, name: name, year: "(\(movieYear))", summary: summary)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let movieDetails = viewModel.getMovieDetails(rowIndex: indexPath.row)
            
            if let movieDetails = movieDetails {
                router.showMovieDetails(movieDetails: movieDetails)
            }
        }

}


extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 358, height: 142)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
            12
    }
}
