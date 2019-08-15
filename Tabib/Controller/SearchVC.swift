//
//  SearchVC.swift
//  Tabib
//
//  Created by Ahmed on 8/15/19.
//  Copyright © 2019 Ahmed, ORG. All rights reserved.
//

import UIKit
import Firebase

class SearchVC: UIViewController {

    @IBOutlet weak var speializationTF: DesignableUITextField!
    @IBOutlet weak var cityTF: DesignableUITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var tablView: UITableView!
    
    let specializations = ["أسنان","عظام","انف واذن وحنجرة","نساء وتوليد","باطنة","اطفال وحديثي ولادة","مخ وأعصاب","جلدية","جراحة اطفال","قلب وأوردة دموية","أورام","تخسيس وتغذية","عيون","علاج طبيعي واصابات ملاعب","نطق وتخاطب","ذكورة وعقم","روماتيزم","صدر وجهاز تنفسي","جراحة تجميل","جراحة عامة"]
    let cities = ["سوهاج","اخميم","البلينا","المراغة"," المنشاة","دار السلام","جرجا","جهينة","ساقلته","طما","طهطا","العسيرات"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        
        searchBtn.AddRoundedShadowButn()
        
        tablView.register(UINib(nibName: "searchResultCell", bundle: nil), forCellReuseIdentifier: searchResultCell.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // authantication
        if Auth.auth().currentUser == nil{
            let vc = LoginVC.getInstance()
            present(vc, animated: true)
        }
    }
    
    fileprivate func setupTextFields(){
        
        speializationTF.delegate = self
        cityTF.delegate = self
        
        let speializationPicker = UIPickerView()
        let cityPicker = UIPickerView()
        speializationTF.inputView = speializationPicker
        cityTF.inputView = cityPicker
        speializationPicker.delegate = self
        cityPicker.delegate = self
        
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        AuthController.logout { (success) in
            if success!  {
                let vc = LoginVC.getInstance()
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablView.dequeueReusableCell(withIdentifier: searchResultCell.id) as! searchResultCell
        cell.num = indexPath.row
        return cell
    }
    
    
}

extension SearchVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cityTF.inputView {
            return cities.count
        } else {
            return specializations.count
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cityTF.inputView {
            return cities[row]
        } else {
            return specializations[row]
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cityTF.inputView {
            cityTF.text = cities[row]
        } else {
            speializationTF.text = specializations[row]
        }
        view.endEditing(true)
    }
    
    
}

extension SearchVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField is DesignableUITextField{
            let tf = textField as! DesignableUITextField
            tf.bottomBorderColor = #colorLiteral(red: 0.01094562653, green: 0.7326540351, blue: 0.7138233781, alpha: 1)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField is DesignableUITextField{
            let tf = textField as! DesignableUITextField
            tf.bottomBorderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
}
