import UIKit
import MovieAppData
import Kingfisher

class MovieListCell: UICollectionViewCell {
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var summaryLabel: UILabel!
    
    static let identifier = String(describing: MovieListCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        styleViews()
        defineLayout()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func createViews() {
        imageView = UIImageView()
        contentView.addSubview(imageView)
        
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        
        summaryLabel = UILabel()
        contentView.addSubview(summaryLabel)
    }
    
    private func styleViews() {
        backgroundColor = .systemBackground
        layer.masksToBounds = false
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 4, height: 8)
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        imageView.clipsToBounds = true
        
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        summaryLabel.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)
        summaryLabel.font = .systemFont(ofSize: 12)
        summaryLabel.numberOfLines = 0
        summaryLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    private func defineLayout() {
        imageView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .trailing)
        imageView.autoSetDimensions(to: CGSize(width: 97, height: 142))
        imageView.autoPinEdge(toSuperviewEdge: .leading)
        imageView.autoPinEdge(toSuperviewEdge: .top)
        
        titleLabel.autoSetDimension(.width, toSize: 250)
        titleLabel.autoSetDimension(.height, toSize: 40)
        titleLabel.autoPinEdge(.leading, to: .trailing, of: imageView, withOffset: 16)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12, relation: .greaterThanOrEqual)
        
        summaryLabel.autoSetDimension(.width, toSize: 233)
        summaryLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 8)
        summaryLabel.autoPinEdge(.leading, to: .trailing, of: imageView, withOffset: 16)
        summaryLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
        summaryLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 12, relation: .greaterThanOrEqual)
    }
    
    func configureCell(url: URL?, name: String?, year: String?, summary: String?) {
        guard let url, let name, let year, let summary else { return }
        self.imageView.kf.setImage(with: url)
        self.titleLabel.text = name + year
        self.summaryLabel.text = summary
    }
}

