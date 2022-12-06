//
//  ViewController.swift
//  StudentDatabase
//
//  Created by Felix-ITS015 on 27/08/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var rollnoTF: UITextField!
    @IBOutlet weak var mobnoTF: UITextField!
    @IBOutlet weak var marksTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var addrTF: UITextField!
    
    //@IBOutlet weak var dobPick: UIDatePicker!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var displayBtn: UIButton!
    var context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var dateFormatter = DateFormatter()
    var dobDatePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      saveBtn.layer.cornerRadius = 15
      displayBtn.layer.cornerRadius = 15
        var toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onDoneBtn))
        toolBar.setItems([done], animated: true)
        
        dobTF.inputAccessoryView = toolBar
        
        
        dobTF.inputView = dobDatePicker
        dobDatePicker.datePickerMode = .date
        dateFormatter.dateFormat = "dd/MM/yyyy"
        // dobTextField.text = dateFormatter.string(from: dobDatePicker.date)
        dobDatePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        
    }
    
    @objc func dateChanged(){
        dobTF.text = dateFormatter.string(from: dobDatePicker.date)
        //dobTextField.resignFirstResponder()
        
        //view.endEditing(true)
    }
    @objc func onDoneBtn(){
        // dobTextField.text = dateFormatter.string(from: dobDatePicker.date)
        dobTF.resignFirstResponder()
        view.endEditing(true)
    }


    
   
    
    @IBAction func savaBtn(_ sender: UIButton) {
        let stud = Student(context: context)
        stud.rollno = Int64(rollnoTF.text!)!
        stud.name = nameTF.text!
        stud.mobileno = Int64(mobnoTF.text!)!
        stud.marks = Float(marksTF.text!)!
        stud.dob = dobDatePicker.date as NSDate
        print("\(stud.dob)")
        stud.address = addrTF.text!
    
        do{
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
        rollnoTF.text?.removeAll()
        nameTF.text?.removeAll()
        mobnoTF.text?.removeAll()
        marksTF.text?.removeAll()
        addrTF.text?.removeAll()
    }
    
    @IBAction func displayBtn(_ sender: UIButton) {
        var vc = storyboard?.instantiateViewController(withIdentifier: "StudentViewController") as! StudentViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

