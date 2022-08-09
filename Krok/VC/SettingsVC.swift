

import UIKit

class SettingsVC: UIViewController {
    
    
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Наладкi"
        
        
        self.view.addSubview(label)
        label.backgroundColor = .white
        label.textAlignment = .center
        label.text = "тут могуць быць наладкi"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        
    }
    
}
