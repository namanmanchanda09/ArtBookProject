//
//  DetailsVC.swift
//  ArtBookProject
//
//  Created by Naman Manchanda on 14/11/20.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var artistName: UITextField!
    @IBOutlet var yearName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hidekeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        view.addGestureRecognizer(imageTapRecognizer)
    }
    
    @objc func selectImage(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hidekeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        // Saving Data using Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        // Attrbiutes
        newPainting.setValue(nameText.text!, forKey: "name")
        newPainting.setValue(artistName.text!, forKey: "artist")
        if let year = Int(yearName.text!){
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        do{
            try context.save()
            print("success")
        }catch{
            print("error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }

}






