import Foundation
import PureLayout
import UIKit
import MovieAppData
import SDWebImage

class MovieCategoriesViewController: UIViewController {
    private var titleLabel: UILabel!
    private var collectionView: UICollectionView!
    private var categories: [[MovieModel]]!
    private var categorieTitles: [String]!
    let details = MovieUseCase()
    
    private var router: Router
    
    init(router: Router) {
       self.router = router
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews(){
        createViews()
        styleViews()
        defineLayout()
    }
    
    func createViews() {
        titleLabel = UILabel()
        view.addSubview(titleLabel)
        
        categories = [[MovieModel]]()
        categories.append(details.popularMovies)
        categories.append(details.freeToWatchMovies)
        categories.append(details.trendingMovies)
        
        categorieTitles = ["What's popular", "Free to Watch", "Trending"]

        let flowlayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout )
        view.addSubview(collectionView)
    }
    
    func styleViews() {
        titleLabel.text = "Movie List"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        
        view.backgroundColor = .white
        collectionView.register(MovieCategoryCell.self, forCellWithReuseIdentifier: MovieCategoryCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    func defineLayout() {
        titleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 70)
        titleLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 143)
        titleLabel.autoPinEdge(toSuperviewSafeArea: .trailing)

        
        collectionView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 25)
        collectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        collectionView.autoPinEdge(toSuperviewSafeArea: .trailing)
        collectionView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 45)
    }

}

extension MovieCategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCategoryCell.identifier, for: indexPath) as? MovieCategoryCell else { return UICollectionViewCell() }
     
     let categoryURL = categories[indexPath.section].map { URL(string: $0.imageUrl) }
     let title = categorieTitles[indexPath.item]
     cell.configure(with: categoryURL, categoryTitle: title)
         
     return cell
   }
}

extension MovieCategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 374, height: 223)
    }
}
