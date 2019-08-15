//
//  UserDataVC.swift
//  Tabib
//
//  Created by Ahmed on 8/15/19.
//  Copyright © 2019 Ahmed, ORG. All rights reserved.
//

import UIKit
import Photos

class UserDataVC: UIViewController {

    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var nameTF: DesignableUITextField!
    @IBOutlet weak var phoneTF: DesignableUITextField!
    
    @IBOutlet weak var ageTF: DesignableUITextField!
    @IBOutlet weak var hieghtTF: DesignableUITextField!
    @IBOutlet weak var wieghtTF: DesignableUITextField!
    @IBOutlet weak var h_pressureTF: DesignableUITextField!
    @IBOutlet weak var L_pressureTF: DesignableUITextField!
    @IBOutlet weak var sugarTF: DesignableUITextField!
    
    @IBOutlet weak var bttomConstrain: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        configTextFields()
    }
    
    func configTextFields(){
        phoneTF.addDoneButtonOnKeyboard()
        phoneTF.delegate = self
        ageTF.addDoneButtonOnKeyboard()
        ageTF.delegate = self
        hieghtTF.addDoneButtonOnKeyboard()
        hieghtTF.delegate = self
        wieghtTF.addDoneButtonOnKeyboard()
        wieghtTF.delegate = self
        h_pressureTF.addDoneButtonOnKeyboard()
        h_pressureTF.delegate = self
        L_pressureTF.addDoneButtonOnKeyboard()
        L_pressureTF.delegate = self
        sugarTF.addDoneButtonOnKeyboard()
        sugarTF.delegate = self
    }
    
    
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func doneBtnPressed(_ sender: UIButton) {
        endEditing()
        
        guard nameTF.hasValue, phoneTF.hasValue else { return }
        
    }
    
    // set profile image
    fileprivate func presentPhotoPickerController() {
        DispatchQueue.main.async {
            let myPickerController = UIImagePickerController()
            myPickerController.allowsEditing = true
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true)
        }
    }
    @IBAction func selectPhotoPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status{
                case .authorized:
                    self.presentPhotoPickerController()
                    
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized{
                        self.presentPhotoPickerController()
                    }
                case .restricted:
                    let alert = UIAlertController(title: "Photo Library Restricted", message: "Photo Library is restricted and cannot be accessed", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                case .denied:
                    let alert = UIAlertController(title: "Photo Library Denied", message: "Photo Library is denied and cannot be accessed, Please go to setting and update it", preferredStyle: .alert)
                    let goToSetting = UIAlertAction(title: "go To Setting", style: .default, handler: { (action) in
                        DispatchQueue.main.async {
                            let url = URL(string: UIApplication.openSettingsURLString)
                            UIApplication.shared.open(url!, options: [:])
                        }
                    })
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                    
                    alert.addAction(cancel)
                    alert.addAction(goToSetting)
                    self.present(alert, animated: true)
                @unknown default:
                    break
                }
            }
        }
    }
    

}


extension UserDataVC: UITextFieldDelegate{
    
    //MARK:- text field Delegates
    func endEditing(){
        bttomConstrain.constant = 24
        view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        bttomConstrain.constant = 300
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing()
    }
    
}

extension UserDataVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage{
            self.imgPhoto.image = image
        }
        else if let image = info[.originalImage] as? UIImage{
            self.imgPhoto.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
