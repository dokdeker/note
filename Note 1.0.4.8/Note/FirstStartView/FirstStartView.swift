//
//  FirstStartView.swift
//  Note
//
//  Created by Евгений on 24.12.2020.
//

import UIKit

extension TodayViewController {
    
    
    
    
    func checkFirstStart() {
        if isFirstStartUp == true {
            isFirstStartUp = false
            perform(#selector(presentfirstStartController), with: nil, afterDelay: 0)
            
        }
    }
    
    @objc private func presentfirstStartController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let firstStartView = storyBoard.instantiateViewController(withIdentifier: "firstStartViewId") as! FirstStartViewController
        self.present(firstStartView, animated: true, completion: nil)
    }
}


class FirstStartViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isModalInPresentation = true
        
    }
    
    @IBAction func `continue`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
