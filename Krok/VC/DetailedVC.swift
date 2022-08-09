

import Foundation
import UIKit
import SDWebImage
import AVFoundation


class DetailedVC: UIViewController {
    
    private let backButton = UIButton()
    private var currentPhotoData: CityList?
    private var placeName = ""
    private var descriptionText = ""
    private var photo = ""
    private var creationDate = ""
    private var placeAudio = ""
    private let playButton = UIButton()
    private lazy var changePosition = false
    private var player = AVPlayer()
    var detailesArray: [PlacesList] = []
    
    init(placeName: String, descriptionText: String, photo: String, creationDate: String, placeAudio: String) {
        self.placeName = placeName
        self.descriptionText = descriptionText
        self.photo = photo
        self.creationDate = creationDate
        self.placeAudio = placeAudio
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    public var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .red
        return image
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var creationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var placeNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        view.backgroundColor = .white
        self.descriptionLabel.text = descriptionText
        self.placeNameLabel.text = placeName
        self.creationDateLabel.text = "Дата публiкацыi: \(creationDate)"
        
    }
    
    
    
    private func setupView() {
        image.backgroundColor = .white
        self.view.addSubview(image)
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3),
            image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        image.sd_imageIndicator = SDWebImageActivityIndicator.gray
        image.sd_setImage(with: URL(string: photo))
        
        
        self.view.addSubview(placeNameLabel)
        placeNameLabel.backgroundColor = .white
        placeNameLabel.textAlignment = .center
        placeNameLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        NSLayoutConstraint.activate([
            placeNameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            placeNameLabel.heightAnchor.constraint(equalToConstant: 60),
            placeNameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        setUpPlayButton()
        
        self.view.addSubview(descriptionLabel)
        descriptionLabel.backgroundColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.sizeToFit()
        descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 45),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 250),
            descriptionLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        self.view.addSubview(creationDateLabel)
        creationDateLabel.backgroundColor = .white
        creationDateLabel.textAlignment = .left
        NSLayoutConstraint.activate([
            creationDateLabel.heightAnchor.constraint(equalToConstant: 30),
            creationDateLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            creationDateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])
    }
    
    private func setUpPlayButton() {
        view.addSubview(playButton)
        playButton.tintColor = .systemOrange
        if placeAudio != "" {
            playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            playButton.addTarget(self, action: #selector(changeImageButton), for: .touchUpInside)
        }
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 5),
            playButton.heightAnchor.constraint(equalToConstant: 40),
            playButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    @objc func changeImageButton() {
        setupVoiceActing()
        changePosition.toggle()
        changePosition == false ? playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)  : playButton.setBackgroundImage(UIImage(systemName: "stop.fill"), for: .normal)
        changePosition == false ? player.pause() : player.play()
    }
    private func setupVoiceActing() {
        if placeAudio != "" {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            } catch {
                print ("AVAudioSessionCategoryPlayback not work" )
            }
            guard let url = URL (string: placeAudio) else { return }
            let playerItem:AVPlayerItem = AVPlayerItem(url: url)
            player = AVPlayer (playerItem: playerItem)
        }
    }
}
