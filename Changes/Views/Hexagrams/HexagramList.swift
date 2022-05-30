//
//  HexagramList.swift
//  Changes
//
//  Created by aiqin139 on 2021/1/29.
//

import SwiftUI

class HexagramTableViewController: UITableViewController {
    var modelData: ModelData

    var headers = ["基本八卦", "六十四卦"]

    var filteredHexagrams: [Hexagram] = [Hexagram]()
    
    var data: [[Hexagram]] {
        if modelData.searchBarText.isEmpty {
            return [modelData.basicHexagrams, modelData.derivedHexagrams]
        } else {
            return [filteredHexagrams]
        }
    }

    init(_ modelData: ModelData) {
        self.modelData = modelData
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(HostingTableViewCell<HexagramRow>.self, forCellReuseIdentifier: "rowViewCell")
        tableView.separatorStyle = .singleLine
        
        let searchController: UISearchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "搜索"
        searchController.searchBar.setValue("取消", forKey: "cancelButtonText")
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "卦象"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        traitCollectionDidChange(nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            tableView.backgroundColor = .black
        } else {
            tableView.backgroundColor = UIColor(red: 0.9600, green: 0.9700, blue: 0.9800, alpha: 1.0)
        }
    }
}

extension HexagramTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.systemFont(ofSize: 20)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .left
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if modelData.searchBarText.isEmpty {
            return headers[section]
        } else {
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowViewCell") as! HostingTableViewCell<HexagramRow>
        cell.setView(HexagramRow(hexagram: data[indexPath.section][indexPath.row]), parent: self)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hexagram = data[indexPath.section][indexPath.row]
        let hexagramView = HexagramDetail(hexagram: hexagram)
        let hostVC =  UIHostingController(rootView: hexagramView)
        
        pushOrShowDetailView(hostVC, hexagram.name)
    }
}

extension HexagramTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    if let searchBarText = searchController.searchBar.text {
        var allHexagrams: [Hexagram] { modelData.basicHexagrams + modelData.derivedHexagrams }
        filteredHexagrams = allHexagrams.filter { $0.name.hasPrefix(searchBarText) }
        tableView.reloadData()
    }
  }
}

class HexagramNavigationController: CustomNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let hostVC = HexagramTableViewController(self.modelData)
        
        self.setViewControllers([hostVC], animated: true)
    }
}

// MARK: SwiftUI Preview

struct HexagramViewToSwiftui: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HexagramNavigationController {
        HexagramNavigationController(ModelData())
    }
    
    func updateUIViewController(_ uiViewController: HexagramNavigationController, context: Context) {}
}

struct HexagramView_Previews: PreviewProvider {
    static var previews: some View {
        HexagramViewToSwiftui()
    }
}
