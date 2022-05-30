//
//  MoreView.swift
//  Changes
//
//  Created by aiqin139 on 2021/3/10.
//

import SwiftUI

class MoreTableViewController: UITableViewController {
    var modelData: ModelData

    var data = [["图标"],
                ["占卦记录"],
                ["占卦须知", "大衍占法", "数字占法", "念念有词"],
                ["占卦三不", "不诚不占", "不义不占", "不疑不占"],
                ["元亨之意", "利贞之意"],
                ["关于软件"]]

    init(_ modelData: ModelData) {
        self.modelData = modelData
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(HostingTableViewCell<LogoView>.self, forCellReuseIdentifier: "rowViewCell")
        tableView.separatorStyle = .singleLine
        
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension MoreTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        return 50
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowViewCell") as! HostingTableViewCell<LogoView>

        if indexPath.section == 0 {
            cell.setView(LogoView(), parent: self)
            cell.selectionStyle = .none
        } else {
            cell.textLabel?.text = data[indexPath.section][indexPath.row]
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = data[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 { return }
        
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

class MoreViewNavigationController: CustomNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hostVC = MoreTableViewController(self.modelData)
        
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
