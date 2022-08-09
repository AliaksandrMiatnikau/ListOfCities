

import UIKit

class CitiesVC: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 110
        tableView.register(CityCell.self, forCellReuseIdentifier: "CityCell")
        
        return tableView
    }()
    
    
    var cityArray: [CityList] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpViewAndNavBar()
        setupView()
        
        NetworkManager.shared.getCitiesListRequest{ result in
            switch result {
            case.success(let cities):
                self.cityArray = cities.filter({$0.lang == 1})
            case.failure(_):
                print("error")
            }
        }
    }
    
    private func setUpViewAndNavBar() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        title = "Гарады"
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

extension CitiesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCell else {  return UITableViewCell() }
        cell.setupCell(city: cityArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = PlacesVC()
        self.navigationController?.pushViewController(vc, animated: true)
        let cityId = cityArray[indexPath.row].id
        let cityName = cityArray[indexPath.row].name
        vc.getPlaces(id: cityId)
        vc.setUpViewAndNavBar(name: cityName)
    }
}




