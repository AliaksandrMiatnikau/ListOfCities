

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
        setupTabBar()
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
    
    private func setupVCs() {
        viewControllers = [
            createNavController(for: CitiesVC(), title: NSLocalizedString("Гарады", comment: ""), image: UIImage(systemName: "map")!, selectedImage: nil),
            createNavController(for: SettingsVC(), title: NSLocalizedString("Наладкi", comment: ""), image: UIImage(systemName: "gear")!, selectedImage: nil),
            
        ]
        
    }
    private func setupTabBar() {
        
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
    }
}

