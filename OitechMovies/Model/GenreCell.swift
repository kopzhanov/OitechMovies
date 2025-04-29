import UIKit
import SnapKit

class GenreCell: UICollectionViewCell {
    static let identifier = "GenreCell"

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(label)
        label.snp.makeConstraints { $0.edges.equalToSuperview().inset(8) }

        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        
        contentView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.7)
        contentView.layer.cornerRadius = 14
        contentView.clipsToBounds = true
    }

    func configure(with genre: String) {
        label.text = genre
    }
}
