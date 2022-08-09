

import Foundation
import UIKit
import SDWebImage

class CityCell: UITableViewCell {
    
    private var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    private var text: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return text
    } ()
    
    
    private func setUI() {
        contentView.addSubview(text)
        contentView.addSubview(image)
        text.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 20, weight: .light)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100),
            text.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
            text.centerYAnchor.constraint(equalTo: image.centerYAnchor)
        ])
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(city: CityList) {
        image.sd_imageIndicator = SDWebImageActivityIndicator.gray
        image.sd_setImage(with: URL(string: city.logo))
        text.text = city.name
        
    }
}
