
import Foundation
import UIKit

class PlacesVC: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 110
        tableView.register(PlaceCell.self, forCellReuseIdentifier: "PlaceCell")
        
        return tableView
        
    }()
    
    private let cityTitle: String = ""
    private let id: Int = 0
    
    var placesArray: [PlacesList] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor.systemOrange
        
    }
    
    
    public func getPlaces(id: Int) {
        NetworkManager.shared.getPlacesListRequest(of: id) { result in
            switch result {
            case .success(let places):
                self.placesArray = places.filter({$0.lang == 1 && $0.city_id == id && $0.visible == true})
            case .failure(_):
                print("error1")
                
            }
        }
    }
    
    
    private func setupViewFav() {
        
        self.view.addSubview(tableView)
        
    }
    
    func setUpViewAndNavBar (name: String) {
        view.backgroundColor = .white
        title = name
    }
    
    
    private func setupView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    
    @objc private func backToMenu () {
        self.dismiss(animated: true)
    }
    
    
}
extension PlacesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return placesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as? PlaceCell else {  return UITableViewCell() }
        cell.setupCell(place: placesArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let placeName = placesArray[indexPath.row].name
        let descriptionText = placesArray[indexPath.row].text
        let photo = placesArray[indexPath.row].photo
        let creationDate = placesArray[indexPath.row].creation_date
        let sound = placesArray[indexPath.row].sound
        let vc = DetailedVC(placeName: placeName, descriptionText:descriptionText, photo: photo, creationDate: creationDate, placeAudio: sound)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension String {
    public func trimHTMLTags() -> String? {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string
    }
}



