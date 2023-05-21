import Foundation
import PureLayout
import MovieAppData
import SDWebImage

class MovieCategoryCell: UICollectionViewCell {
    
    private var titleLabel: UILabel!
    private var moviesURL: [URL?]!
    private var collectionViewCell: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    
    static let identifier = String(describing: MovieCategoryCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        styleViews()
        defineLayout()
    }
    
    func createViews() {
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        
        flowLayout = UICollectionViewFlowLayout()
        
        collectionViewCell = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
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

extension MovieCategoryCell{
    public func configure(with moviesURL: [URL?], categoryTitle: String) {
        self.moviesURL = moviesURL
        self.titleLabel.text = categoryTitle
    }
}

extension MovieCategoryCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesURL.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCategoryListCell", for: indexPath) as! MovieCategoryListCell? else { return UICollectionViewCell() }
        
//        let movie =
//        cell.configureCell(movie: moviesURL[indexPath.item])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 122, height: 179)
    }
}
