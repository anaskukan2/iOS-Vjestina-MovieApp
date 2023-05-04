import Foundation
import PureLayout
import MovieAppData
import SDWebImage

class MovieCategoryCell: UICollectionViewCell {
    var indexOf: Int!
    private var titleLabel = UILabel()
    private var moviesURL: [URL?]!
    private var collectionViewCell: UICollectionView!
    let details = MovieUseCase()
    
    static let identifier = String(describing: MovieCategoryCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        styleViews()
        defineLayout()
    }
    
    func createViews() {
        self.addSubview(titleLabel)
        
        collectionViewCell = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout() )
        self.addSubview(collectionViewCell)
    }
    
    func styleViews() {
        self.backgroundColor = .white
        titleLabel.textColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        collectionViewCell.register(MovieCategoryListCell.self, forCellWithReuseIdentifier: "MovieCategoryListCell")
        collectionViewCell.dataSource = self
        collectionViewCell.delegate = self
        
    }
    
    func defineLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        titleLabel.autoSetDimension(.width, toSize: 358)
        titleLabel.autoPinEdge(toSuperviewEdge: .top)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading)
      
        collectionViewCell.autoPinEdge(toSuperviewEdge: .top, withInset: 44)
        collectionViewCell.autoPinEdge(toSuperviewEdge: .leading)
        collectionViewCell.autoPinEdge(toSuperviewEdge: .bottom)
        collectionViewCell.autoPinEdge(toSuperviewEdge: .trailing)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieCategoryCell: UICollectionViewDataSource {
    public func configure(with moviesURL: [URL?], categoryTitle: String) {
        self.moviesURL = moviesURL
        self.titleLabel.text = categoryTitle
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesURL.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCategoryListCell", for: indexPath) as! MovieCategoryListCell?
        if indexOf == 0 {
            cell?.configureCell(movie: details.popularMovies[indexPath.item])
        }
        if indexOf == 1 {
            cell?.configureCell(movie: details.freeToWatchMovies[indexPath.item])
        }
        if indexOf == 2 {
            cell?.configureCell(movie: details.trendingMovies[indexPath.item])
        }
        return cell!
        
    }
}

extension MovieCategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 122, height: 179)
    }
}
