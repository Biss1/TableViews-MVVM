import UIKit

extension UIView {
    // Loads the UIView from nib, when given UIView custom class
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    // Loads the UIView from nib, when given UIView.type custom class
    class func loadViewTypeFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)![0] as! T
    }
    
    // Returns the compressed height of the UIView
    func compressedHeight() -> CGFloat {
        let size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGFloat(ceilf(Float(size.height)))
    }
}
