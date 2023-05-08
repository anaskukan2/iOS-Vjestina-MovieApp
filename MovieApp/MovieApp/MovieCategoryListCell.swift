import Foundation
import PureLayout
import MovieAppData
import SDWebImage

class MovieCategoryListCell: UICollectionViewCell {
    private var imageView: UIImageView!
    private var favouriteButton: UIButton!
    private var imageView2: UIImageView!
    let details = MovieUseCase()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        styleViews()
        defineLayout()
    }
    
    func createViews() {
        imageView = UIImageView()
        self.addSubview(imageView)
        
        favouriteButton = UIButton()
        imageView.addSubview(favouriteButton)
        
        let imageHeart = UIImage(systemName: "heart")
        imageView2 = UIImageView(image: imageHeart)
        favouriteButton.addSubview(imageView2)
    }
    
    func styleViews() {
        favouriteButton.alpha = 0.6
        favouriteButton.layer.backgroundColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1).cgColor
        favouriteButton.layer.cornerRadius = 16
       
        imageView2.tintColor = .white
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    func defineLayout() {
        imageView.autoPinEdge(toSuperviewEdge: .leading)
        imageView.autoPinEdge(toSuperviewEdge: .top)
        imageView.autoPinEdge(toSuperviewEdge: .bottom)
        imageView.autoPinEdge(toSuperviewEdge: .trailing)
      
        favouriteButton.autoSetDimensions(to: CGSize(width: 32, height: 32))
        favouriteButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        favouriteButton.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        favouriteButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 82)

        imageView2.frame = CGRect(x: 7, y: 9, width: 18, height: 16.13)
    }

    func configureCell(movie: MovieModel) {
        if let posterUrl = URL(string: movie.imageUrl) {
            imageView.sd_setImage(with: posterUrl, placeholderImage: UIImage(systemName: "photo")
            , completed: {[weak self] (image,error, cacheType, imageURL) in
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    print(movie.id)
                } else {
                    self?.imageView.image = image
                }
            })
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
