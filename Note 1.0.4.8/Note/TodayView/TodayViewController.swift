//
//  TodayViewController.swift
//  Note
//
//  Created by Евгений on 10.12.2020.
//

import UIKit

enum ColorMark {
    static var red = "red"
    static var orange = "orange"
    static var gray = "gray"
    static var green = "green"
}


protocol MethodDelegate: class {
    func reloadTable()
    func fadeOutBlackBG()
    func saveTodayData()
    
}


struct NoteData: Codable{
    var head: String
    var body: String
    var colorMark: String
    var isDone: Bool
    var isFold: Bool
    var amountLine: Int
    
    var startTime: String?
    var endTime: String?
    
    var noteCell = [NoteCell]()
}


struct NoteCell: Codable {
    var isCheckList: Bool?
    var isDone:Bool?
    var body: String?
}

var todayNoteItems:[NoteData] = []





class TodayViewController: UIViewController {
    
   
    var isFirstStartUp:Bool = true
    let darkView = UIView()
    let userDefaults = UserDefaults.standard
    let createNoteViewController = NoteViewController()
    var headerStatus:String = Header.free
    var currentLitDate = String()
    
    private let noteViewId = "noteViewId"
    private let sortViewId = "sortViewId"
    
    
    // MARK: - OUTLETS
    @IBOutlet weak var todayTabBar: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var createNoteButtonOutlet: UIButton!
    @IBOutlet weak var editTableButtonOutlet: UIButton!
    @IBOutlet weak var sortButtonOutlet: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var headerOutlet: UIView!
    @IBOutlet weak var todayButStackRightConst: NSLayoutConstraint!
    @IBOutlet weak var todayButtonStackViewOutlet: UIStackView!
    @IBOutlet weak var todayLabelLeftConst: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTodayData()
        
        checkEnableHeadButton()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CustomTableCell1", bundle: nil), forCellReuseIdentifier: "FirstCustomCell")
        
        
        checkFirstStart()
    }
    
    
    // MARK: - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        
        //MARK: Check date
        checkDate()
        
        
        //MARK: Get a bg image for TodayView
        if bgImage.size.width != 0 {
            backgroundImageView.image = bgImage
        
            
        //MARK: Save image
            UserDefaults.standard.register(defaults: ["bg":bgImage.jpegData(compressionQuality: 100)!])
            UserDefaults.standard.set(bgImage.jpegData(compressionQuality: 100), forKey: "bg")
            
        }
    }
    
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //MARK: For note
        if segue.identifier == noteViewId {
            if let createVC = segue.destination as? NoteViewController {
                createVC.updateDelegate = self
            }
        }
        
        //MARK: For sort
        if segue.identifier == sortViewId {
            if let createVCSort = segue.destination as? SortViewController {
                createVCSort.updateDelegate = self
            }
        }
    }
    
    
    // MARK: - LOAD TODAY DATA
    func loadTodayData() {
        
        // MARK:  Load Notes
        if let data = UserDefaults.standard.data(forKey: "note") {
            do {
                let decoder = JSONDecoder()
                todayNoteItems = try decoder.decode([NoteData].self, from: data)
                
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        
        
        // MARK:  Load bg image
        if UserDefaults.standard.object(forKey: "bg") != nil {
            if let imageData = UserDefaults.standard.value(forKey: "bg") as? Data{
                let imageFromData = UIImage(data: imageData)
                backgroundImageView.image = imageFromData!
                bgImage = imageFromData!
            }
        }
        
        
        // MARK:  Load block firstStart Veiw
        if UserDefaults.standard.object(forKey: "firstStart") != nil {
            isFirstStartUp = userDefaults.object(forKey: "firstStart") as! Bool
            
        }
    }
    
    
    // MARK: - BUTTON ACTIONS
    
    @IBAction func editTableButton(_ sender: Any) {
        tableView.isEditing.toggle()
//        view.layoutIfNeeded()
        if tableView.isEditing == false {
            reloadTable()
            editTableButtonOutlet.setImage(UIImage(systemName: "arrow.up.arrow.down.square"), for: .normal)
//            editTableButtonOutlet.tintColor = .systemBlue
            createNoteButtonOutlet.isEnabled = true
            sortButtonOutlet.isEnabled = true
            
        } else {
            editTableButtonOutlet.setImage(UIImage(systemName: "arrow.up.arrow.down.square.fill"), for: .normal)
//            editTableButtonOutlet.tintColor = .systemRed
            createNoteButtonOutlet.isEnabled = false
            sortButtonOutlet.isEnabled = false
            
        }
    }
    
    
    @IBAction func createNoteButton(_ sender: Any) {
        patternNoteView = NoteStatus.create
    }
    
    
    @IBAction func sortButton(_ sender: UIButton) {
        
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        darkView.frame = self.view.frame
        self.view.addSubview(darkView)
        UIView.animate(withDuration: 0.3, delay: 0,
                       options: .curveEaseIn ){ [self] in
            
            darkView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }
        
    }
    
    
    func checkEnableHeadButton() {
        if todayNoteItems.count >= 2{
            editTableButtonOutlet.isEnabled = true
            sortButtonOutlet.isEnabled = true
        } else {
            editTableButtonOutlet.isEnabled = false
            sortButtonOutlet.isEnabled = false
        }
    }
    
    
}


// MARK: - UITableViewDataSource
extension TodayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todayNoteItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCustomCell", for: indexPath) as! CustomCell
        
        cell.setupTodayCell(headText: todayNoteItems[indexPath.row].head,
                   noteText: todayNoteItems[indexPath.row].body,
                   markColor: todayNoteItems[indexPath.row].colorMark,
                   isDone: todayNoteItems[indexPath.row].isDone,
                   isFold: todayNoteItems[indexPath.row].isFold,
                   amountLine: todayNoteItems[indexPath.row].amountLine,
                   startTime: todayNoteItems[indexPath.row].startTime ?? "",
                   endTime: todayNoteItems[indexPath.row].endTime ?? "",
                   cell: cell)
        
        return cell
    }
    
    
}




// MARK: - MethodDelegate
extension TodayViewController: MethodDelegate {
    
    func saveTodayData() {
        
        //MARK: Save table data
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(todayNoteItems)
            UserDefaults.standard.set(data, forKey: "note")

        } catch {
            print("Unable to Encode Note (\(error))")
        }
        
        
        //MARK: Save firstStartUp status
        userDefaults.set(isFirstStartUp, forKey: "firstStart")
        
        
        print("SAVED: TodayData")
    }
    
    
    
    func reloadTable() {
        tableView.reloadData()
        checkEnableHeadButton()
        saveTodayData()
        
        print("Table has been reloaded")
    }
    
    
    func fadeOutBlackBG() {
        UIView.animate(withDuration: 0.3, delay: 0,
                       options: .curveEaseIn, animations:{ [self] in
                        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
                       }) { (completed) in
            self.darkView.removeFromSuperview()
        }
    }
    
    
}

