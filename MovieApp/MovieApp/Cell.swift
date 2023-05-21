
import UIKit
import PureLayout

class Cell: UICollectionViewCell {
    
    static let cellIdentifier = "Cell"
    
    private var name: UILabel!
    private var role: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func buildViews() {
        createViews()
        layoutViews()
    }
    
    private func createViews() {
        name = UILabel()
        contentView.addSubview(name)

        role = UILabel()
        contentView.addSubview(role)
    }
    
    private func layoutViews() {
        name.autoPinEdge(toSuperviewEdge: .top, withInset: 3)
        name.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        name.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        role.autoPinEdge(.top, to: .bottom, of: name, withOffset: 3)
        role.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        role.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        role.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
    }
    
    func configure(name: String, role: String) {
        self.name.text = name
        self.name.font = .systemFont(ofSize: 14, weight: .bold)
        self.role.text = role
        self.role.font = .systemFont(ofSize: 14)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.name.text = nil
        self.role.text = nil
    }
}
