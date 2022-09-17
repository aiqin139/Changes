//
//  PredictionView.swift
//  Changes
//
//  Created by aiqin139 on 2021/1/28.
//

import SwiftUI

// MARK: - Prediction picker view

struct PredictionPicker: View {
    @ObservedObject var modelData: ModelData
    
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

// MARK: - Prediction view controller

class PredictionViewController: UIViewController {
    var modelData: ModelData

    var data = ["所占何事", "数字卦（占小事）", "大衍卦（占大事）"]

    var tableView = UITableView(frame: CGRect(), style: .insetGrouped)
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

        image = UIHostingController(rootView: RotateEightTrigrams())
        
        tableView.register(HostingTableViewCell<PredictionPicker>.self, forCellReuseIdentifier: "rowViewCell")
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.delegate = self

        self.view.addSubview(image.view)
        self.view.addSubview(tableView)
        self.navigationItem.title = "占卦"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        traitCollectionDidChange(nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let selectedRow: IndexPath? = tableView.indexPathForSelectedRow
        if let selectedRowNotNill = selectedRow {
            tableView.deselectRow(at: selectedRowNotNill, animated: animated)
        }
    }
    
    override func viewWillLayoutSubviews() {
        let imageWidth = (self.parent?.view.frame.width)! * 0.8
        let imageHeight = (self.parent?.view.frame.height)! * 0.4
        let imageViewWidth = Int((imageHeight > (self.parent?.view.frame.width)!) ? imageWidth : imageHeight)
        let imageViewY = Int((self.navigationController?.navigationBar.frame.height)!)
        let imageViewX = (Int((self.parent?.view.frame.width)!) - imageViewWidth) / 2
        
        let tableViewY = imageViewY + imageViewWidth
        let tableViewWidth = Int((self.parent?.view.frame.width)!)
        let tableViewHeight = Int(self.view.bounds.size.height) - tableViewY
        
        image.view.frame = CGRect(x: imageViewX, y: imageViewY, width: imageViewWidth, height: imageViewWidth)
        tableView.frame = CGRect(x: 0, y: tableViewY, width: tableViewWidth, height: tableViewHeight)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            tableView.backgroundColor = .black
            self.view.backgroundColor = .black
        } else {
            tableView.backgroundColor = UIColor(red: 0.9600, green: 0.9700, blue: 0.9800, alpha: 1.0)
            self.view.backgroundColor = .white
        }
    }
}

// MARK: - Prediction view controller data source and delegate

extension  PredictionViewController: UITableViewDataSource, UITableViewDelegate  {
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

// MARK: - Prediction navigation controller

class PredictionNavigationController: CustomNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hostVC = PredictionViewController(self.modelData)

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
