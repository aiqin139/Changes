//
//  MoreView.swift
//  Changes
//
//  Created by aiqin139 on 2021/3/10.
//

import SwiftUI

// MARK: More view controller

class MoreViewController: UIViewController {
    var modelData: ModelData

    var data = [["占卦记录"],
                ["占卦须知", "大衍占法", "数字占法", "念念有词"],
                ["占卦三不", "不诚不占", "不义不占", "不疑不占"],
                ["元亨之意", "利贞之意"],
                ["关于软件"]]

    var tableView = UITableView(frame: CGRect(), style: .insetGrouped)
    var logo = UIViewController()

    init(_ modelData: ModelData) {
        self.modelData = modelData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        logo = UIHostingController(rootView: LogoView())
        tableView.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -80)
        tableView.addSubview(logo.view)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "rowViewCell")
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.delegate = self

        self.view.addSubview(tableView)
        self.navigationItem.title = "更多"
        self.navigationController?.navigationBar.prefersLargeTitles = false

        traitCollectionDidChange(nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let selectedRow: IndexPath? = tableView.indexPathForSelectedRow
        if let selectedRowNotNill = selectedRow {
            tableView.deselectRow(at: selectedRowNotNill, animated: animated)
        }
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillLayoutSubviews() {
        let logoViewWidth = Int((self.parent?.view.frame.width)!) - 10
        let logoViewHeight = 100
        let tableViewWidth = Int((self.parent?.view.frame.width)!)
        let tableViewHeight = Int(self.view.bounds.size.height)

        logo.view.frame = CGRect(x: 10, y: -80, width: logoViewWidth, height: logoViewHeight)
        tableView.frame = CGRect(x: 0, y: 0, width: tableViewWidth, height: tableViewHeight)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            tableView.backgroundColor = .black
            logo.view.backgroundColor = .black
            self.view.backgroundColor = .black
        } else {
            tableView.backgroundColor = UIColor(red: 0.9600, green: 0.9700, blue: 0.9800, alpha: 1.0)
            logo.view.backgroundColor = tableView.backgroundColor
            self.view.backgroundColor = tableView.backgroundColor
        }
    }
}

// MARK: - More view controller data source and delegate

extension MoreViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowViewCell")!

        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = data[indexPath.section][indexPath.row]
        if title == "占卦记录" {
            let view = RecordView().environmentObject(self.modelData)
            let hostVC = UIHostingController(rootView: view)
            pushOrShowDetailView(hostVC, title)
        } else {
            let view = RTFReader(fileName: title).navigationTitle(title)
            let hostVC = UIHostingController(rootView: view)
            pushOrShowDetailView(hostVC, title)
        }
    }
}

// MARK: More view navigation controller

class MoreViewNavigationController: CustomNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hostVC = MoreViewController(self.modelData)
        
        self.setViewControllers([hostVC], animated: true)
    }
}

// MARK: SwiftUI Preview

struct MoreViewToSwiftui: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MoreViewNavigationController {
        MoreViewNavigationController(ModelData())
    }
    
    func updateUIViewController(_ uiViewController: MoreViewNavigationController, context: Context) {}
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreViewToSwiftui()
    }
}
