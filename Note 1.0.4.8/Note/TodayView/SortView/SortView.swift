//
//  SortView.swift
//  Note
//
//  Created by Евгений on 19.12.2020.
//

import UIKit

enum Sort {
    static var moreImportantUp: String = "moreImportantUp"
    static var lessImportantUp: String = "lessImportantUp"
    static var `nil`: String = ""
    static var autoSort: Bool = false
    static var moveDoneToDown: Bool = false
}

var patternSort:String = ""

class SortViewController: UIViewController {

    weak var updateDelegate: MethodDelegate?
    
    @IBOutlet weak var sortView: UIView!
    
    @IBOutlet weak var listLineGray: UIView!
    @IBOutlet weak var listLineGrayX: NSLayoutConstraint!
    @IBOutlet weak var listLineGrayY: NSLayoutConstraint!
    @IBOutlet weak var listLineGrayTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var listLineOrange: UIView!
    @IBOutlet weak var listLineOrangeX: NSLayoutConstraint!
    @IBOutlet weak var listLineOrangeY: NSLayoutConstraint!
    @IBOutlet weak var listLineOrangeTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var listLineRed: UIView!
    @IBOutlet weak var listLineRedX: NSLayoutConstraint!
    @IBOutlet weak var listLineRedY: NSLayoutConstraint!
    @IBOutlet weak var listLineRedTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var markGray: UIView!
    @IBOutlet weak var markOrange: UIView!
    @IBOutlet weak var markRed: UIView!
    
    @IBOutlet weak var moreImportantButtonOutlet: UIButton!
    @IBOutlet weak var lessImportantButtonOutlet: UIButton!
    
    @IBOutlet weak var applyButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        patternSort = Sort.nil
    }
    
    
    //MARK: - Action SortView Button
    
    @IBAction func moreImportantButton(_ sender: UIButton) {
        if patternSort == Sort.moreImportantUp {
            patternSort = Sort.nil
            nilListAnimation()
            
            UIView.animate(withDuration: 0.3, delay: 0,
                           options: .curveEaseIn) { [self] in
                moreImportantButtonOutlet.backgroundColor = .systemGray4
                lessImportantButtonOutlet.backgroundColor = .systemGray4
            }
            
        } else {
            
            patternSort = Sort.moreImportantUp
            moreImportantUpAnimation()
        }
        checkApplybutton()
    }
    
    
    @IBAction func lessImportantButton(_ sender: UIButton) {
        
        if patternSort == Sort.lessImportantUp {
            patternSort = Sort.nil
            nilListAnimation()
            
            UIView.animate(withDuration: 0.3, delay: 0,
                           options: .curveEaseIn) { [self] in
                moreImportantButtonOutlet.backgroundColor = .systemGray4
                lessImportantButtonOutlet.backgroundColor = .systemGray4
            }
            
        } else {
            
            patternSort = Sort.lessImportantUp
            lessImportantUpAnimation()
        }
        checkApplybutton()
    }
    
    
    
    
    @IBAction func applyButton(_ sender: UIButton) {
        sortArray()
        
        updateDelegate?.fadeOutBlackBG()
        updateDelegate?.reloadTable()
        self.dismiss(animated: true)
    }
    
    
    
    @IBAction func closeViewButton(_ sender: UIButton) {
        updateDelegate?.fadeOutBlackBG()
        self.dismiss(animated: true)
    }
    
    
    func checkApplybutton() {
        if patternSort.isEmpty == true {
            applyButtonOutlet.isEnabled = false
            applyButtonOutlet.backgroundColor = .gray
        } else {
            applyButtonOutlet.isEnabled = true
            applyButtonOutlet.backgroundColor = .systemBlue
        }
    }
    
    
    //MARK: - SORT EXAMPLE Animation
    func nilListAnimation(){
        UIView.animate(withDuration: 0.6, delay: 0,
                       usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0,
                       options: .curveEaseIn) { [self] in
            
            listLineOrangeX.constant = 0
            listLineOrangeY.constant = -22
            listLineOrangeTrailing.constant = 10
            
            listLineGrayX.constant = 0
            listLineGrayY.constant = 0
            listLineGrayTrailing.constant = 10
            
            listLineRedX.constant = 0
            listLineRedY.constant = 22
            listLineRedTrailing.constant = 10

            view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.6, delay: 0.15,
                       usingSpringWithDamping: 0.3, initialSpringVelocity: 1.0,
                       options: .curveEaseIn) { [self] in
            markOrange.transform = .identity
        }
        UIView.animate(withDuration: 0.6, delay: 0.3,
                       usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0,
                       options: .curveEaseIn) { [self] in
            markGray.transform = .identity
        }
        UIView.animate(withDuration: 0.6, delay: 0.45,
                       usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0,
                       options: .curveEaseIn) { [self] in
            markRed.transform = .identity
        }
    }
    
    
    
    func moreImportantUpAnimation(){
        UIView.animate(withDuration: 0.6, delay: 0,
                       usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0,
                       options: .curveEaseIn) { [self] in
            
            moreImportantButtonOutlet.backgroundColor = .systemGray2
            lessImportantButtonOutlet.backgroundColor = .systemGray4
            
            listLineRedX.constant = 0
            listLineRedY.constant = -22
            listLineRedTrailing.constant = 10
            
            listLineOrangeX.constant = 10
            listLineOrangeY.constant = 0
            listLineOrangeTrailing.constant = 20
            
            listLineGrayX.constant = 20
            listLineGrayY.constant = 22
            listLineGrayTrailing.constant = 30
            
            view.layoutIfNeeded()
        }
        
        
        UIView.animate(withDuration: 0.6, delay: 0.15,
                       usingSpringWithDamping: 0.3, initialSpringVelocity: 1.0,
                       options: .curveEaseIn) { [self] in
            markRed.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }
        UIView.animate(withDuration: 0.6, delay: 0.3,
                       usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0,
                       options: .curveEaseIn) { [self] in
            markOrange.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
        }
        UIView.animate(withDuration: 0.6, delay: 0.45,
                       usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0,
                       options: .curveEaseIn) { [self] in
            markGray.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }
        
    }
    
    func lessImportantUpAnimation(){
        UIView.animate(withDuration: 0.6, delay: 0,
                       usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0,
                       options: .curveEaseIn) { [self] in
            
            moreImportantButtonOutlet.backgroundColor = .systemGray4
            lessImportantButtonOutlet.backgroundColor = .systemGray2
            
            listLineGrayX.constant = 0
            listLineGrayY.constant = -22
            listLineGrayTrailing.constant = 10
            
            listLineOrangeX.constant = 10
            listLineOrangeY.constant = 0
            listLineOrangeTrailing.constant = 20
            
            listLineRedX.constant = 20
            listLineRedY.constant = 22
            listLineRedTrailing.constant = 30
            
            view.layoutIfNeeded()
        }
        
        
        UIView.animate(withDuration: 0.6, delay: 0.15,
                       usingSpringWithDamping: 0.3, initialSpringVelocity: 1.0,
                       options: .curveEaseIn) { [self] in
            markGray.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }
        UIView.animate(withDuration: 0.6, delay: 0.3,
                       usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0,
                       options: .curveEaseIn) { [self] in
            markOrange.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
        }
        UIView.animate(withDuration: 0.6, delay: 0.45,
                       usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0,
                       options: .curveEaseIn) { [self] in
            markRed.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }
    }

    
}
