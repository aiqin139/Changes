//
//  PredictionView.swift
//  Changes
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

struct PredictionPicker: View {
    @State var modelData: ModelData
    
    var body: some View {
        VStack(alignment: .center) {
            Text("所占何事").bold()
            
            Picker("Purpose", selection: $modelData.fortuneTellingPurpose) {
                ForEach(Purposes.allCases) { purpose in
                    Text(purpose.rawValue).tag(purpose)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }
}

class PredictionTableViewController: UIViewController {
    var modelData: ModelData

    var data = ["所占何事", "数字卦（占小事）", "大衍卦（占大事）"]

    var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: UITableView.Style.insetGrouped)
    var image = UIViewController()

    init(_ modelData: ModelData) {
        self.modelData = modelData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        image = UIHostingController(rootView: RotateImage(image: "先天八卦图"))

        tableView.register(HostingTableViewCell<PredictionPicker>.self, forCellReuseIdentifier: "rowViewCell")
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.delegate = self

        self.view.addSubview(image.view)
        self.view.addSubview(tableView)
        self.view.backgroundColor = (UITraitCollection.current.userInterfaceStyle == .dark) ? .black : .white
        self.navigationItem.title = "占卦"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let selectedRow: IndexPath? = tableView.indexPathForSelectedRow
        if let selectedRowNotNill = selectedRow {
            tableView.deselectRow(at: selectedRowNotNill, animated: animated)
        }
    }
    
    override func viewWillLayoutSubviews() {
        let imageViewY = Int((self.navigationController?.navigationBar.frame.height)!)
        let imageViewX = Int((self.parent?.view.frame.width)! * 0.1)
        let imageViewWidth = Int((self.parent?.view.frame.width)! * 0.8)
        let tableViewY = imageViewY + imageViewWidth
        let tableViewWidth = Int((self.parent?.view.frame.width)!)
        let tableViewHeight = Int(self.view.bounds.size.height)

        image.view.frame = CGRect(x: imageViewX, y: imageViewY, width: imageViewWidth, height: imageViewWidth)
        tableView.frame = CGRect(x: 0, y: tableViewY, width: tableViewWidth, height: tableViewHeight)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.view.backgroundColor = (UITraitCollection.current.userInterfaceStyle == .dark) ? .black : .white
    }
}

extension  PredictionTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        }
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowViewCell") as! HostingTableViewCell<PredictionPicker>

        if indexPath.row == 0 {
            cell.setView(PredictionPicker(modelData: modelData), parent: self)
            cell.selectionStyle = .none
        } else {
            cell.textLabel?.text = data[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = data[indexPath.row]

        if title == "数字卦（占小事）" {
            let view = DigitalPredictionView().environmentObject(modelData)
            let hostVC = UIHostingController(rootView: view)
            pushOrShowDetailView(hostVC, "数字卦")
        } else if title == "大衍卦（占大事）" {
            let view = DayanPredictionView().environmentObject(modelData)
            let hostVC = UIHostingController(rootView: view)
            pushOrShowDetailView(hostVC, "大衍卦")
        }
    }
}

class PredictionNavigationController: CustomNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hostVC = PredictionTableViewController(self.modelData)

        self.setViewControllers([hostVC], animated: true)
    }
}

// MARK: Swiftui Preview

struct PredictionViewToSwiftui: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PredictionNavigationController {
        PredictionNavigationController(ModelData())
    }
    func updateUIViewController(_ uiViewController: PredictionNavigationController, context: Context) {}
}

struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionViewToSwiftui()
    }
}
