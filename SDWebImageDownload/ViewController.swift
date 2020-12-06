

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var label: UILabel!
    
    let urlImage = "https://unsplash.com/photos/TIMCZe9JghI/download?force=true&w=640"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func grabImage(_ sender: UIButton) {
        let imageManager = SDWebImageManager()
        guard let downloadURL = URL(string: urlImage) else { return }
        
        imageManager.loadImage(with: downloadURL, options: []) { (receivedSize, totalSize, url) in
            let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
            print("Downloading progress: \(percentage)%")
        } completed: { (image, data, err, cacheType, finished, url) in
            if finished {
                guard let image = image, let url = url else { return }
                self.image.image = image
                let message = """
                Image size:
                \(image.size)
                
                Cashe:
                \(cacheType.rawValue)

                Url:
                \(url)

                """
                
                print(message)
                self.label.text = message
            } else {
                print("Loading image did not finish")
            }
        }

        
    }
    
    @IBAction func fetchImage(_ sender: UIButton) {
        guard let downloadURL = URL(string: urlImage) else { return }
        
        let placeholder = UIImage(named: "logo")
        
        image.sd_setImage(with: downloadURL, placeholderImage: placeholder, options: []) { (image, err, cacheType, url) in
            if let err = err {
                print(err.localizedDescription)
            }
            guard let image = image, let url = url else { return }
            
            let message = """
            Image size:
            \(image.size)
            
            Cashe:
            \(cacheType.rawValue)

            Url:
            \(url)

            """
            
            print(message)
            self.label.text = message
            
            
            
        }
    }
    
}


