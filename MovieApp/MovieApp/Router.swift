import UIKit

class Router: NSObject, UITabBarControllerDelegate {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startScreen(in window: UIWindow?) {

        let favoriteMoviesViewController = createFavoritesController()
        let tabBarController = createTabBarController(with: [createCategoriesController(), favoriteMoviesViewController])

        navigationController.setViewControllers([tabBarController], animated: false)
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
    }
   
    func createCategoriesController() -> UIViewController{
        let movieCategoriesViewController = MovieCategoriesViewController(router: self)
        movieCategoriesViewController.tabBarItem = UITabBarItem(
          title: "Movie List",
          image: UIImage(systemName: "house"),
          selectedImage:  UIImage(systemName: "house.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal))
        return movieCategoriesViewController
    }
    
    func createFavoritesController() -> UIViewController{
        let favoritesViewController = FavouritesViewController()
        favoritesViewController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image:  UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal))
        return favoritesViewController
    }
    
    private func createTabBarController(with controllers: [UIViewController]) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
        tabBarController.viewControllers = controllers
        return tabBarController
      }
    
    func showMovieDetails(movieDetails: MovieDetailsModel) {
        let movieDetailsViewController = MovieDetailsViewController(viewModel: MovieDetailsViewModel(movieDetails: movieDetails))
        
        movieDetailsViewController.title = "Movie Details"
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
}

