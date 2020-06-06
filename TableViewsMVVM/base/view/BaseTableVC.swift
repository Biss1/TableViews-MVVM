import UIKit

class BaseTableVC<T : BaseTableVM>: UIViewController, UITableViewDelegate, BaseTableVMDelegate {
    @IBOutlet var tableView: UITableView!
    var dataSource: BaseTableViewDataSource?
    var viewModel: T!
    
    //MARK:- View lyfecycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    
    //MARK:- Setup methods
    func setupTableView() {
        preconditionFailure("setupTableView must be overridden")
    }
    
    func setupViewModel() {
        preconditionFailure("setupViewModel must be overridden")
    }
    
    func setupDataSource() {
        guard let tableViewModel = viewModel?.tableViewModel else { return }
        dataSource = BaseTableViewDataSource(vm: tableViewModel)
        dataSource?.cellDelegate = viewModel as? CellDelegate
    }
    
    func setupData() {
        setupDataSource()
        tableView.delegate = self
        tableView.dataSource = dataSource
        reloadTableViewData()
    }
    
    func reloadTableViewData() {
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        tableView.reloadData()
    }
    
    //MARK:- BaseTableVMDelegate
    func updateView() {
        dataSource?.update(viewModel: viewModel.tableViewModel)
        reloadTableViewData()
    }
    
    //MARK:- NavigationBar
    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = viewModel.headerTitle
    }
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        dataSource?.tableView(tableView, viewForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        dataSource?.tableView(tableView, heightForHeaderInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        dataSource?.tableView(tableView, viewForFooterInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        dataSource?.tableView(tableView, heightForFooterInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    //MARK:- MBNavigationBarDelegate
    func scrollView() -> UIScrollView {
        return tableView
    }
    
//    @objc func didPullToRefresh() {
//        downloadData()
//    }
}
