//
//  WishStoringViewControlle.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 30.09.2025.
//
import UIKit

final class WishStoringViewController: UIViewController, UITableViewDelegate { //HW3
    
    init(backgroundColor: UIColor) { //HW4
        self.backgroundColor = backgroundColor //HW4
        super.init(nibName: nil, bundle: nil) //HW4
    } //HW4
    
    
    required init?(coder: NSCoder) { //HW4
        fatalError("init(coder:) has not been implemented") //HW4
    } //HW4
    private var backgroundColor: UIColor //HW4
    private let defaults = UserDefaults.standard //HW3
    
    enum Constants { //HW3
        static let tableCornerRadius: CGFloat = 12 //HW3
        static let tableOffset: Double = 0 //HW3
        
        static let sectionsCount = 2 //HW3
        static let addSection = 0 //HW3
        static let listSection = 1 //HW3
        
        static let wishesKey: String = "arrayOfWishes" //HW3
        
        static let buttonBottom: CGFloat = 50 //HW3
        static let buttonSide: CGFloat = 20 //HW3
        static let buttonText: String = "Add Your Wish" //HW3
        static let buttonHeight: CGFloat = 40 //HW3
        static let buttonRadius: CGFloat = 12 //HW3
        
        static let textViewRadius: CGFloat = 12 //HW3
        
        static let tableEstimatedRowHeight: CGFloat = 120 //HW3
        
        static let addSectionReturnValue: Int = 1 //HW3
        static let defaultReturnValue: Int = 0 //HW3
    } //HW3
    
    private enum ReuseID { //HW3
        static let add = "AddWishCell" //HW3
        static let written = "WrittenWishCell" //HW3
    } //HW3
    
    private let table: UITableView = UITableView(frame: .zero) //HW3
    private var wishArray: [String] = [] //HW3
    private let addWishButton2: UIButton = UIButton(type: .system) //HW3
    private let textView = UITextView() //HW3
    
    var addWish: ((String) -> Void)? //HW3
    
    override func viewDidLoad() { //HW3
        super.viewDidLoad() //HW3
        view.backgroundColor = backgroundColor //HW4
        configureTable() //HW3
        wishArray = defaults.array(forKey: Constants.wishesKey) as? [String] ?? [] //HW3
    } //HW3
    
    private func configureTable() { //HW3
        table.backgroundColor = backgroundColor
        view.addSubview(table) //HW3
        table.dataSource = self //HW3
        table.separatorStyle = .none //HW3
        table.layer.cornerRadius = Constants.tableCornerRadius //HW3
        table.pin(to: view, Constants.tableOffset) //HW3
        table.rowHeight = UITableView.automaticDimension //HW3
        table.estimatedRowHeight = Constants.tableEstimatedRowHeight //HW3
        
        table.register(AddWishCell.self, forCellReuseIdentifier: ReuseID.add) //HW3
        table.register(WrittenWishCell.self, forCellReuseIdentifier: ReuseID.written) //HW3
        table.dataSource = self //HW3
        table.delegate = self //HW3
        
    } //HW3
    
}
// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource { //HW3
    func numberOfSections(in tableView: UITableView) -> Int { Constants.sectionsCount } //HW3

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //HW3
        switch section { //HW3
        case Constants.addSection:  return Constants.addSectionReturnValue //HW3
        case Constants.listSection: return wishArray.count //HW3
        default: return Constants.defaultReturnValue //HW3
        } //HW3
    } //HW3

    func tableView(_ tableView: UITableView, //HW3
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell { //HW3
        switch indexPath.section { //HW3
        case Constants.addSection: //HW3
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseID.add, for: indexPath) //HW3
            guard let addCell = cell as? AddWishCell else { return cell } //HW3
            addCell.addWish = { [weak self] newWish in //HW3
                guard let self else { return } //HW3
                self.wishArray.append(newWish) //HW3
                self.defaults.set(self.wishArray, forKey: Constants.wishesKey) //HW3
                let idx = IndexSet(integer: Constants.listSection) //HW3
                self.table.reloadSections(idx, with: .automatic) //HW3
            } //HW3
            return addCell //HW3
         
        case Constants.listSection: //HW3
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseID.written, for: indexPath) //HW3
            guard let wishCell = cell as? WrittenWishCell else { return cell } //HW3
            wishCell.configure(with: wishArray[indexPath.row]) //HW3
           wishCell.onDelete = { [weak self, weak wishCell] in //HW3
               guard //HW3
                   let self, //HW3
                   let cell = wishCell, //HW3
                   let idx = tableView.indexPath(for: cell) //HW3
               else { return } //HW3

               self.wishArray.remove(at: idx.row) //HW3
               self.defaults.set(self.wishArray, forKey: Constants.wishesKey) //HW3
               tableView.deleteRows(at: [idx], with: .automatic) //HW3
           } //HW3
            return wishCell //HW3
        default: //HW3
            return UITableViewCell() //HW3
        } //HW3
    } //HW3
} //HW3
