import Foundation
import PureLayout
import UIKit
import MovieAppData
import SDWebImage

class MovieCategoriesViewController: UIViewController {
    
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
        view.backgroundColor = .white
        collectionView.register(MovieCategoryCell.self, forCellWithReuseIdentifier: MovieCategoryCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    func defineLayout() {
        collectionView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 25)
        collectionView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        collectionView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 45)
        collectionView.autoPinEdge(toSuperviewSafeArea: .trailing)
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
