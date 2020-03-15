import UIKit

extension UITableViewCell: ReusableUIElementProtocol { }
extension UITableViewHeaderFooterView: ReusableUIElementProtocol { }

extension UITableView {
    public func register<T: UITableViewCell>(cells: [T.Type]) {
        for cellType in cells {
            
            register(UINib.init(nibName: cellType.reuseIdentifier, bundle: nil),
                     forCellReuseIdentifier: cellType.reuseIdentifier)
        }
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(at indexPath: IndexPath, of type: T.Type) -> T? {
        guard let cell = dequeueReusableCell(withIdentifier: type.reuseIdentifier,
                                             for: indexPath) as? T else {
                                                return nil
        }
        
        return cell
    }
    
    //UITableViewHeaderFooterView
    public func register<T: UITableViewHeaderFooterView>(headerFooterViews: [T.Type]) {
        for headerFooterType in headerFooterViews {
            register(UINib.init(nibName: headerFooterType.reuseIdentifier, bundle: nil),
                     forHeaderFooterViewReuseIdentifier: headerFooterType.reuseIdentifier)
        }
    }
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(of type: T.Type) -> T? {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: type.reuseIdentifier) as? T else {
            return nil
        }
        
        return headerFooterView
    }
}

extension UICollectionViewCell: ReusableUIElementProtocol { }

extension UICollectionView {
    public func register<T: UICollectionViewCell>(cells: [T.Type]) {
        for cellType in cells {
            
            register(UINib.init(nibName: cellType.reuseIdentifier, bundle: nil),
                     forCellWithReuseIdentifier: cellType.reuseIdentifier)
        }
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(at indexPath: IndexPath, of type: T.Type) -> T? {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier,
                                             for: indexPath) as? T else {
                                                return nil
        }
        
        return cell
    }
}
