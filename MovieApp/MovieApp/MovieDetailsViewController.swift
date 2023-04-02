import PureLayout
import UIKit
import MovieAppData

class MovieDetailsViewController: UIViewController{
    
    private var movieImageView: UIImageView!
    private var starIconImageView: UIImageView!
    private var ratingLabel: UILabel!
    private var userScoreLabel: UILabel!
    private var nameLabel: UILabel!
    private var yearLabel: UILabel!
    private var releseDateLabel: UILabel!
    private var categoriesLabel: UILabel!
    private var durationLabel: UILabel!
    private var overviewLabel: UILabel!
    private var summaryLabel: UILabel!
    private var crewMembersView: UICollectionView!
    private var detailsLabel: MovieDetailsModel = {
            guard let details = MovieUseCase().getDetails(id: 111161) else {
                exit(1)
            }
            return details
        }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews(){
        createAndLayout()
        styleViews()
    }
    
    private func createAndLayout(){
        movieImageView = UIImageView(image: UIImage(named: "movieImage"))
        view.addSubview(movieImageView)
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        movieImageView.autoPinEdge(toSuperviewEdge: .leading)
        movieImageView.autoPinEdge(toSuperviewEdge: .trailing)
        movieImageView.autoPinEdge(toSuperviewEdge: .top)
        movieImageView.autoSetDimension(.height, toSize: 327)
        
        ratingLabel = UILabel()
        ratingLabel.text = String(detailsLabel.rating)
        userScoreLabel = UILabel()
        userScoreLabel.text = "User score"
        let group1StackView = UIStackView(arrangedSubviews: [ratingLabel, userScoreLabel])
        movieImageView.addSubview(group1StackView)
        group1StackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        group1StackView.autoPinEdge(toSuperviewEdge: .top, withInset: 90)
        group1StackView.spacing = 8
        
        nameLabel = UILabel()
        nameLabel.text = String(detailsLabel.name)
        yearLabel = UILabel()
        yearLabel.text = "(" + String(detailsLabel.year) + ")"
        let group2StackView = UIStackView(arrangedSubviews: [nameLabel, yearLabel])
        movieImageView.addSubview(group2StackView)
        group2StackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        group2StackView.autoPinEdge(.top, to: .bottom, of: group1StackView, withOffset: 16)
        group2StackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
    
    
        releseDateLabel = UILabel()
        releseDateLabel.text = String(detailsLabel.releaseDate) + " (US)"
        movieImageView.addSubview(releseDateLabel)
        releseDateLabel.autoPinEdge(.top, to: .bottom, of: group2StackView, withOffset: 16)
        releseDateLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        
        categoriesLabel = UILabel()
        let categoriesMap = detailsLabel.categories.map {categorie in "\(categorie)" }.joined(separator: ",")
        categoriesLabel.text = categoriesMap
        durationLabel = UILabel()
        durationLabel.text = String(detailsLabel.duration / 60) + "h " + String(detailsLabel.duration % 60) + "m"
        let group3StackView = UIStackView(arrangedSubviews: [categoriesLabel, durationLabel])
        movieImageView.addSubview(group3StackView)
        group3StackView.autoPinEdge(.top, to: .bottom, of: releseDateLabel, withOffset: 0)
        group3StackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        group3StackView.spacing = 8
        
        /*starIconImageView = UIImageView(image: UIImage(named: "star-512"))
        movieImageView.addSubview(starIconImageView)
        starIconImageView.contentMode = .scaleAspectFill
        starIconImageView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        starIconImageView.autoPinEdge(.top, to: .bottom, of: group3StackView, withOffset: 16)
        starIconImageView.autoSetDimension(.height, toSize: 32)*/
        
        overviewLabel = UILabel()
        overviewLabel.text = "Overview"
        view.addSubview(overviewLabel)
        overviewLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        overviewLabel.autoPinEdge(.top, to: .bottom, of: movieImageView, withOffset: 22)
        
        summaryLabel = UILabel()
        summaryLabel.text = detailsLabel.summary
        view.addSubview(summaryLabel)
        summaryLabel.numberOfLines = 0
        summaryLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        summaryLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        summaryLabel.autoPinEdge(.top, to: .bottom, of: overviewLabel, withOffset: 16)
        
        /*let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3) - 32, height: 50)
        crewMembersView = UICollectionView(frame: CGRect(x: 0, y: 0,width: view.bounds.width, height: view.bounds.height),
                                          collectionViewLayout: flowLayout)
        view.addSubview(crewMembersView)
                
        crewMembersView.dataSource = self
        crewMembersView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        crewMembersView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        crewMembersView.autoPinEdge(.top, to: .bottom, of: summaryLabel, withOffset: 27)
        crewMembersView.autoPinEdge(toSuperviewEdge: .bottom)*/
        
        
        
    }
   
    private func styleViews(){
        view.backgroundColor = .white
        
        ratingLabel.textColor = .white
        ratingLabel.font = UIFont(name: "ProximaNova-Extrabold", size: 16)

        userScoreLabel.textColor = .white
        userScoreLabel.font = UIFont(name: "ProximaNova-Semibold", size: 14)

        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "ProximaNova-Bold", size: 24)

        yearLabel.textColor = .white
        yearLabel.font = UIFont(name: "ProximaNova-Bold", size: 24)
        
        releseDateLabel.textColor = .white
        releseDateLabel.font = UIFont(name: "ProximaNova-Regular", size: 14)

        categoriesLabel.textColor = .white
        categoriesLabel.font = UIFont(name: "ProximaNova-Regular", size: 14)
        
        durationLabel.textColor = .white
        durationLabel.font = UIFont(name: "ProximaNova-Regular", size: 14)

        overviewLabel.textColor = .black
        overviewLabel.font = UIFont(name: "ProximaNova-Extrabold", size: 20)
        
        summaryLabel.textColor = .black
        summaryLabel.font = UIFont(name: "ProximaNova-Regular", size: 14)
    }

}

