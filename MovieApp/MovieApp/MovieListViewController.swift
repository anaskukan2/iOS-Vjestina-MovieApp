import Foundation
import MovieAppData
import UIKit

class MovieListViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    let details = MovieUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

    private func buildViews(){
        createViews()
        styleViews()
        defineLayout()
    }
    
    private func createViews(){
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
    }
    
    private func styleViews(){
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
        details.allMovies.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCell.identifier, for: indexPath) as? MovieListCell else {
          return UICollectionViewCell()
        }
    
        let index = indexPath.row
        let url = URL(string: details.allMovies[index].imageUrl)
        let name = details.allMovies[index].name
        let summary = details.allMovies[index].summary
        let movieYear = details.getDetails(id: details.allMovies[index].id)!.year
        cell.configureCell(url: url, name: name, year: "(\(movieYear))", summary: summary)
        
        return cell
        
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
