protocol BaseTableVM {
    var headerTitle: String { get }
    
    var tableViewModel: BaseTableSource { get }
    
    // optional parameters
    var headerSubtitle: String { get }
//    var notifications: [NotificationVM]? { get }
    var hasRefresh: Bool { get }
    var delegate: BaseTableVMDelegate? { get }
}

extension BaseTableVM {
    var headerSubtitle: String { "" }
//    var notifications: [NotificationVM]? { nil }
    var hasRefresh: Bool { false }
    var delegate : BaseTableVMDelegate? { nil }
}

protocol BaseTableVMDelegate {
    func updateView()
}
