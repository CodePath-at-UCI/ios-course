
**IOS Unit 2 Walkthrough guide (Tumblr Pt.2)**

**Topics Covered: Segues, View Controllers, Passing Data, Navigation Controllers**


* Add PhotoDetailsViewController
    * Add new View Controller from object library into Main.storyboard
    * add an Image View onto ViewController

* Link Code and Storyboard
    * Create new cocoa touch class in controllers folder, name it PhotoDetailsViewController
    * Set the custom class of the viewcontroller to PhotoDetailsViewController (this way xcode knows which view controller the code is actually referring to)
    * Control drag the UIImageView into the PhotoDetailsViewController, creating an outlet (call this outlet detailImage)
    * Underneath this outlet, create a variable:
        * `var image: UIImage!`

* Embed PhotosViewController inside a Navigation Controller
    * Click on main ViewController (Photos View Controller)
        * Editor -> Embed In -> Navigation Controller

* Pass image to PhotoDetailsVC
    * Create segue from photo cell to photodetailsVC
    * inside PhotosViewController, create new function beneath the getPosts() function
    * `override func prepare(for segue......`
        * `let photoDetailVC = segue.destination as! PhotoDetailsViewController`
        * `let cell = sender as! PhotoCell`
        * `let image = cell.photoView.image`
        * inside the viewDidLoad in PhotoDetailsViewController: `detailImage.image = image`
        * back in photosViewController in the prepare function:`photoDetailVC.image = image`
