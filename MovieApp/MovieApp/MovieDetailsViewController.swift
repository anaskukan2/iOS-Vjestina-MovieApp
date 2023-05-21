import PureLayout
import UIKit
import MovieAppData

class MovieDetailsViewController: UIViewController{
    
    private var movieImageView: UIImageView!
    private var starIconImageView: UIImageView!
    private var ratingLabel: UILabel!
    private var userScoreLabel: UILabel!
    private var group1StackView: UIStackView!
    private var nameLabel: UILabel!
    private var yearLabel: UILabel!
    private var group2StackView: UIStackView!
    private var releseDateLabel: UILabel!
    private var categoriesLabel: UILabel!
    private var group3StackView: UIStackView!
    private var durationLabel: UILabel!
    private var overviewLabel: UILabel!
    private var summaryLabel: UILabel!
    private var crewMembersView: UICollectionView!
    
    private var viewModel: MovieDetailsViewModel!
        
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        prepareAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performAnimation()
    }
    
    private func prepareAnimation() {
        nameLabel.transform = nameLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        ratingLabel.transform = ratingLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        userScoreLabel.transform = userScoreLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        yearLabel.transform = yearLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        releseDateLabel.transform = releseDateLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        categoriesLabel.transform = categoriesLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        durationLabel.transform = durationLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        overviewLabel.transform = overviewLabel
            .transform
            .translatedBy(x: -view.frame.width, y: 0)
        crewMembersView.alpha = 0
    }
    
    private func performAnimation() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            animations: {
                self.nameLabel.transform = .identity
                self.ratingLabel.transform = .identity
                self.userScoreLabel.transform = .identity
                self.yearLabel.transform = .identity
                self.releseDateLabel.transform = .identity
                self.categoriesLabel.transform = .identity
                self.durationLabel.transform = .identity
                self.overviewLabel.transform = .identity
            }, completion: { _ in
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0.3,
                    animations: {
                        self.crewMembersView.alpha = 1
                    })
            })
    }
    
    private func buildViews(){
        createViews()
        styleViews()
        defineLayout()
        
    }


    private func createViews(){
        movieImageView = UIImageView(image: UIImage(named: "movieImage"))
        view.addSubview(movieImageView)
       
        
        ratingLabel = UILabel()
        userScoreLabel = UILabel()
        group1StackView = UIStackView(arrangedSubviews: [ratingLabel, userScoreLabel])
        movieImageView.addSubview(group1StackView)
        
        
        nameLabel = UILabel()
        yearLabel = UILabel()
        group2StackView = UIStackView(arrangedSubviews: [nameLabel, yearLabel])
        movieImageView.addSubview(group2StackView)
    
        releseDateLabel = UILabel()
        movieImageView.addSubview(releseDateLabel)

        
        categoriesLabel = UILabel()
        durationLabel = UILabel()
        group3StackView = UIStackView(arrangedSubviews: [categoriesLabel, durationLabel])
        movieImageView.addSubview(group3StackView)

        
        starIconImageView = UIImageView(image: UIImage(named: "star-512"))
        movieImageView.addSubview(starIconImageView)
    
        overviewLabel = UILabel()
        view.addSubview(overviewLabel)
        
        
        summaryLabel = UILabel()
        view.addSubview(summaryLabel)

        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3) - 32, height: 50)
        crewMembersView = UICollectionView(frame: CGRect(x: 0, y: 0,width: view.bounds.width, height: view.bounds.height),
                                          collectionViewLayout: flowLayout)
        view.addSubview(crewMembersView)
                
        
    }
   
    private func styleViews(){
        self.title = "Movie Details"
        view.backgroundColor = .white
        
        ratingLabel.text = String(viewModel.movieDetails.rating)
        ratingLabel.textColor = .white
        ratingLabel.font = .systemFont(ofSize: 20, weight: .bold)

        userScoreLabel.text = "User score"
        userScoreLabel.textColor = .white
        userScoreLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        nameLabel.text = String(viewModel.movieDetails.name)
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)

        yearLabel.text = "(" + String(viewModel.movieDetails.year) + ")"
        yearLabel.textColor = .white
        yearLabel.font = .systemFont(ofSize: 24, weight: .bold)

        releseDateLabel.text = String(viewModel.movieDetails.releaseDate) + " (US)"
        releseDateLabel.textColor = .white
        releseDateLabel.font = .systemFont(ofSize: 14)

        let categoriesMap = viewModel.movieDetails.categories.map {categorie in "\(categorie)" }.joined(separator: ",")
        categoriesLabel.text = categoriesMap
        categoriesLabel.textColor = .white
        categoriesLabel.font = .systemFont(ofSize: 14)
        
        durationLabel.text = String(format: "%dh %dm", viewModel.movieDetails.duration / 60, viewModel.movieDetails.duration % 60)
        durationLabel.textColor = .white
        durationLabel.font = .systemFont(ofSize: 14)
        
        overviewLabel.text = "Overview"
        overviewLabel.textColor = .black
        overviewLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        summaryLabel.text = viewModel.movieDetails.summary
        summaryLabel.textColor = .black
        summaryLabel.font = .systemFont(ofSize: 14)
    }
    
    private func defineLayout(){
        
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.clipsToBounds = true
        movieImageView.autoPinEdge(toSuperviewSafeArea: .leading)
        movieImageView.autoPinEdge(toSuperviewSafeArea: .trailing)
        movieImageView.autoPinEdge(toSuperviewSafeArea: .top)
        movieImageView.autoSetDimension(.height, toSize: 327)
        

        group1StackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        group1StackView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 90)
        group1StackView.spacing = 8
        

        group2StackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        group2StackView.autoPinEdge(.top, to: .bottom, of: group1StackView, withOffset: 16)
        group2StackView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        
        releseDateLabel.autoPinEdge(.top, to: .bottom, of: group2StackView, withOffset: 16)
        releseDateLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        
        
       
        group3StackView.autoPinEdge(.top, to: .bottom, of: releseDateLabel, withOffset: 0)
        group3StackView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        group3StackView.spacing = 8
        
        starIconImageView.clipsToBounds = true
        starIconImageView.contentMode = .scaleAspectFit
        starIconImageView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        starIconImageView.autoPinEdge(.top, to: .bottom, of: group3StackView, withOffset: 16)
        starIconImageView.autoSetDimension(.height, toSize: 32)
        starIconImageView.autoSetDimensions(to: CGSize(width: 32, height: 32))
        

        overviewLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        overviewLabel.autoPinEdge(.top, to: .bottom, of: movieImageView, withOffset: 22)
        overviewLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        overviewLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 20)
        
        summaryLabel.numberOfLines = 0
        summaryLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
        summaryLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
        summaryLabel.autoPinEdge(.top, to: .bottom, of: overviewLabel, withOffset: 16)
        
         
         crewMembersView.dataSource = self
         crewMembersView.delegate = self
         crewMembersView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        
         crewMembersView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16)
         crewMembersView.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16)
         crewMembersView.autoPinEdge(.top, to: .bottom, of: summaryLabel, withOffset: 27)
         crewMembersView.autoPinEdge(toSuperviewSafeArea: .bottom)
    }
}

extension MovieDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell?
        
        return cell!
    }
    
    

}

class MovieDetailsViewModel {
    
    let movieDetails: MovieDetailsModel!
    
    init(movieDetails: MovieDetailsModel) {
        self.movieDetails = movieDetails
    }
    
}
