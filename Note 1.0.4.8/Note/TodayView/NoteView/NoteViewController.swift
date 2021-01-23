//
//  File.swift
//  Note
//
//  Created by Евгений on 10.12.2020.
//

import UIKit

protocol NoteCellDelegate {
    func resignKeyboard()
}

extension NoteViewController: NoteDelegate {
    func checkPatternNote() {
        if patternNoteView == NoteStatus.read {
//            statusCell = "endEditTableCell"
            patternNoteView = NoteStatus.edit
            loadPatternNote()
//            editbuttonOutlet.setImage(UIImage(systemName: "ellipsis.circle.fill"), for: .normal)
            editbuttonOutlet.setTitle("Готово", for: .normal)
        }
    }

    func adaptiveScrollForKeyboard() {
        
//            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
//            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//        })
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

            noteTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
            noteTableView.scrollIndicatorInsets = noteTableView.contentInset

   
        
    }
    
    
    func checkCheckMarkButton() {
        checkMarkIsOnCheck()
    }
    
    func createNoteCell() {
        reloadCell()
        noteCellItems.insert(NoteCell(isCheckList: false, isDone: false, body: "" ), at: indexCellFromNoteCell)
        noteTableView.reloadData()
    }
    
    //MARK: - Rewrite Edited Cell
    func rewriteEditedCell() {
        Note.head = headTextFieldOutlet.text!
        
        todayNoteItems[usedIndexCell].head = Note.head
        todayNoteItems[usedIndexCell].body = Note.body
        todayNoteItems[usedIndexCell].colorMark = Note.colorMark
        todayNoteItems[usedIndexCell].isFold = Note.isFold
//        noteItems[usedIndexCell].amountLine = textView.calcAmountOfLines()
        todayNoteItems[usedIndexCell].noteCell = noteCellItems
        
        
        //MARK: Check time switchers and rewrite time
        if startTimeSwitcherOutlet.isOn == true {
            todayNoteItems[usedIndexCell].startTime = Note.startTime
        } else {
            todayNoteItems[usedIndexCell].startTime = nil
        }
        
        if endTimeSwitcherOutlet.isOn == true {
            todayNoteItems[usedIndexCell].endTime = Note.endTime
        } else {
            todayNoteItems[usedIndexCell].endTime = nil
        }
        
        
        updateDelegate?.reloadTable()
        updateDelegate?.saveTodayData()
    }
    
    
    func deleteCell(index: Int) {
        reloadCell()
        print("cell with index: \(index) will delete")
        noteCellItems.remove(at: index)
        noteTableView.reloadData()
    }
    
    func createCheckListCell() {
        reloadCell()
        noteCellItems.insert(NoteCell(isCheckList: true, isDone: false, body: "" ), at: indexCellFromNoteCell)
        noteTableView.reloadData()
//        indexCellFromNoteCell = noteCellItems.count - 1
//        DispatchQueue.main.async {
        
//            let index = IndexPath(row: noteCellItems.count - 1, section: 0)
//        print("scroll will go to: \(index) index")
//            noteTableView.scrollToRow(at: index, at: .bottom, animated: true)
//        }
    }
    
    
    func reloadCell() {
        noteTableView.beginUpdates()
        noteTableView.endUpdates()
    }
    
    
    func printSmth() {
        print("{EEE{E{E{{E{E")
        print("{EEE{E{E{{E{E")
        print("{EEE{E{E{{E{E")
    }
    
    
    func reloadNoteTable() {
        noteTableView.reloadData()
        print("noteTableView reloaded")
    }
}

struct Note {
    static var head = String()
    static var body = String()
    static var colorMark = String()
    static var isFold = Bool()
    static var amountLine = Int()
    
    static var startTime = String()
    static var endTime = String()
    
}


var noteCellItems: [NoteCell] = []



class NoteViewController: UIViewController {
    
//    let controller = NoteTableCell()
    var updateNoteCellDelegate: NoteCellDelegate?
    let datePicker = UIDatePicker()
    var markNumber = 0
    var pointMarkActiveStatus: Bool = false
    var numberMarkActiveStatus: Bool = false
    
    weak var updateDelegate: MethodDelegate?
    
    // MARK: - OUTLETS
    @IBOutlet weak var stackViewMarks: UIStackView!
    @IBOutlet weak var headViewLabel: UILabel!
    @IBOutlet weak var slider: UIView!
//    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var createButtonOutlet: UIButton!
    @IBOutlet weak var editbuttonOutlet: UIButton!
    @IBOutlet weak var canselButtonOutlet: UIButton!
    @IBOutlet weak var headTextFieldOutlet: UITextField!
    @IBOutlet weak var headLabelTopConst: NSLayoutConstraint!
    @IBOutlet weak var markNumberOutlet: UIButton!
    @IBOutlet weak var markPointOutlet: UIButton!
    @IBOutlet weak var fromHeadToColorMarkBar: NSLayoutConstraint!
    @IBOutlet weak var foldCellOutlet: UIButton!
    @IBOutlet weak var timeButtonOutlet: UIButton!
    
    @IBOutlet weak var timeView: UIStackView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var startTimePickerOutlet: UIDatePicker!
    
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var endTimePickerOutlet: UIDatePicker!
    
    @IBOutlet weak var startTimeSwitcherOutlet: UISwitch!
    @IBOutlet weak var endTimeSwitcherOutlet: UISwitch!
    
    @IBOutlet weak var orangeMarkButton: UIButton!
    @IBOutlet weak var redMarkButton: UIButton!
    @IBOutlet weak var greyMarkButton: UIButton!
    
    @IBOutlet weak var noteTableView: UITableView!
    @IBOutlet weak var checkMarkButton: UIButton!
    
    @IBOutlet weak var editNoteTableOutlet: UIButton!
    
    
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTableView.delegate = self
        noteTableView.dataSource = self
        
        loadPatternNote()
        
        checkEmptyNote()
        checkFoldButton()
        
        turnEditNoteButton()
        updateColorise()
//        textView.textContainerInset = UIEdgeInsets(top: 9, left: 18, bottom: 0, right: 18)
        noteTableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 50, right: 0)
        noteTableView.register(UINib(nibName: "NoteTableCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
        
        noteTableView.estimatedRowHeight = 100
        noteTableView.rowHeight = UITableView.automaticDimension
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
//
            
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            reloadCell()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [self] in
            noteTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            noteTableView.scrollIndicatorInsets = noteTableView.contentInset
            
//            noteTableView.scrollToRow(at: IndexPath(row: indexCellFromNoteCell, section: 0), at: .bottom, animated: false)
        })
        }
//
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        noteTableView.contentInset = .zero
        noteTableView.scrollIndicatorInsets = noteTableView.contentInset
    }
    
    

    
    

    
    // MARK: - keyboard willDisappear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        


    }
    
    override func viewSafeAreaInsetsDidChange() {
        noteTableView.reloadData()
    }
    
    @objc func keyboardWillDisappear() {
//        returnDefoultScrollRange()
    }
    
    
    
    
    // MARK: - Action Button
    
    @IBAction func createButton(_ sender: Any) {
        Note.head = headTextFieldOutlet.text!
        noteTableView.reloadData()


        todayNoteItems.insert(NoteData(head: Note.head,
                                  body: Note.body,
                                  colorMark: Note.colorMark,
                                  isDone: false,
                                  isFold: Note.isFold,
                                  amountLine: 10,
                         startTime: Note.startTime,
                         endTime: Note.endTime,
                         noteCell: noteCellItems),
                                  at: 0)

        
        checkEmptyHead()
        updateDelegate?.reloadTable()
        
        self.dismiss(animated: true)
    }
    
    
    @IBAction func editButton(_ sender: Any) {
        print(patternNoteView)
        if patternNoteView == NoteStatus.read {
            patternNoteView = NoteStatus.edit
            loadPatternNote()
            
            editbuttonOutlet.setTitle("Готово", for: .normal)
            print(patternNoteView)
        } else if patternNoteView == NoteStatus.edit {
            rewriteEditedCell()
            pointMarkAction(isActive: false)
            numberMarkAction(isActive: false)
            patternNoteView = NoteStatus.read
            
            loadPatternNote()
            updateColorise()
            noteTableView.reloadData()
            timeSettingsIsShow = false
            editbuttonOutlet.setTitle("Править", for: .normal)
            
        }
        
        print(patternNoteView)
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func markNumberButton(_ sender: Any) {
        if numberMarkActiveStatus == false {
            pointMarkAction(isActive: false)
            numberMarkAction(isActive: true)
            
        } else  {
            numberMarkAction(isActive: false)
        }
        updateColorise()
    }
    
    
    @IBAction func markPointButton(_ sender: UIButton) {
        
        if pointMarkActiveStatus == false {
            numberMarkAction(isActive: false)
            pointMarkAction(isActive: true)
        } else  {
            pointMarkAction(isActive: false)
        }
        updateColorise()
    }
    
    
    @IBAction func foldCellButton(_ sender: UIButton) {
        
        if Note.isFold == false {
            foldButtonAction(isActive: true)
        } else {
            foldButtonAction(isActive: false)
        }
    }
    
    
    //MARK: - Fold cell / Animation && status foldCellButton
    func foldButtonAction(isActive: Bool) {
        
        if isActive == true {
            
            foldCellOutlet.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right.circle.fill",
                                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 21)),
                                    for: .normal)
            foldCellOutlet.tintColor = .systemBlue
            
            Note.isFold = true
            
        } else if isActive == false {
            
            
            foldCellOutlet.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 21)),for: .normal)
            foldCellOutlet.tintColor = .systemGray
            
            Note.isFold = false
        }
        
    }
    
    
    //MARK: - check fold button pressed
    func checkFoldButton() {
        if Note.isFold == true {
            foldButtonAction(isActive: true)
        } else {
            foldButtonAction(isActive: false)
        }
    }
    
    
    //MARK: - Edit note: numberMark
    func numberMarkAction(isActive: Bool) {
        if isActive == true {
            
//            if textView.text.contains("Введите вашу заметку") || textView.text.isEmpty == true  {
//                textView.alpha = 0.7
//                markNumber = 0
//                textView.text = "\(markNumber + 1).    "
//                textView.becomeFirstResponder()
//
//            } else {
//                markNumber = 0
//                textView.text += "\n\n\(markNumber + 1).    "
//                textView.becomeFirstResponder()
//            }
            
            
            markNumberOutlet.setImage(UIImage(systemName: "list.number",withConfiguration: UIImage.SymbolConfiguration(pointSize: 16)),for: .normal)
            markNumberOutlet.backgroundColor = .systemGray
            markNumberOutlet.layer.cornerRadius = 4
            markNumberOutlet.tintColor = .white
            
            numberMarkActiveStatus = true
        
        } else if isActive == false {
            
            markNumberOutlet.backgroundColor = .none
            markNumberOutlet.setImage(UIImage(systemName: "list.number", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
            markNumberOutlet.tintColor = .systemGray
            
            numberMarkActiveStatus = false
        }
        
    }
    
    
    //MARK: - Edit note: pointMark
    func pointMarkAction(isActive: Bool) {
        if isActive == true {
            
//            if textView.text.contains("Введите вашу заметку") || textView.text.isEmpty == true  {
//                textView.alpha = 0.7
//                textView.text = "●    "
//                textView.becomeFirstResponder()
//
//            } else {
//
//                textView.text += "\n\n●    "
//                textView.becomeFirstResponder()
//            }
            
            
            markPointOutlet.setImage(UIImage(systemName: "list.bullet",withConfiguration: UIImage.SymbolConfiguration(pointSize: 16)),for: .normal)
            markPointOutlet.backgroundColor = .systemGray
            markPointOutlet.layer.cornerRadius = 4
            markPointOutlet.tintColor = .white
            
            pointMarkActiveStatus = true
            
        } else if isActive == false {
            markPointOutlet.backgroundColor = .none
            markPointOutlet.setImage(UIImage(systemName: "list.bullet", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
            markPointOutlet.tintColor = .systemGray
            
            pointMarkActiveStatus = false
        }
        
    }
    
    
    
    


    
    
    
    
    
}





