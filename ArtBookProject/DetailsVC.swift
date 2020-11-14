//
//  DetailsVC.swift
//  ArtBookProject
//
//  Created by Naman Manchanda on 14/11/20.
//

import UIKit

class DetailsVC: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var artistName: UITextField!
    @IBOutlet var yearName: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hidekeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hidekeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
    }
    

}
