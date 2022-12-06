//
//  StudentViewController.swift
//  StudentDatabase
//
//  Created by Felix-ITS015 on 27/08/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {
    
    
    @IBOutlet weak var studTableView: UITableView!
    let dateformatter = DateFormatter()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var studArr: [Student] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        dateformatter.dateFormat = "dd/MM/yyyy"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchStudData()
    }
    func fetchStudData() {
        do{
            studArr = try context.fetch(Student.fetchRequest())
            studTableView.reloadData()
        }catch let error{
            print(error.localizedDescription)
        
    }
    }
}
extension StudentViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  studArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StudentTableViewCell
        let obj = studArr[indexPath.row]
        cell.rollnoLabel.text = String(obj.rollno)
        cell.nameLabel.text = obj.name
        cell.mobnoLabel.text = String(obj.mobileno)
        cell.marksLabel.text = String(obj.marks)
       // let date = dateformatter.date(from: obj.dob)
       //cell.dobLabel.text = dateformatter.string(from: date)
        print("obj:\(obj.dob)")
        cell.addrLabel.text = obj.address
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
             var obj = studArr[indexPath.row]
            
            // Action Sheet
            
        let ac = UIAlertController(title: "Operation", message: nil, preferredStyle: .actionSheet)
            
            let editAction = UIAlertAction(title: "Update", style: .default) { (act) in
                self.editStudAction(obj: obj)
            }
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (act) in
                self.deleteStud(obj: obj)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(editAction)
            ac.addAction(deleteAction)
            ac.addAction(cancelAction)
            
            present(ac, animated: true, completion: nil)
        }
        func editStudAction(obj:Student){
            let ac = UIAlertController(title: "Edit Student Info", message: nil, preferredStyle: .alert)
            
            ac.addTextField(configurationHandler: nil)
            ac.addTextField(configurationHandler: nil)
            ac.addTextField(configurationHandler: nil)
            ac.addTextField(configurationHandler: nil)
            ac.addTextField(configurationHandler: nil)
            ac.addTextField(configurationHandler: nil)
            
            ac.textFields![0].text = String(obj.rollno)
            ac.textFields![1].text = obj.name
            ac.textFields![2].text = String(obj.mobileno)
            ac.textFields![3].text = String(obj.marks)
            ac.textFields![4].text = dateformatter.string(from: obj.dob! as Date)
            ac.textFields![5].text = obj.address
            
            let saveAction = UIAlertAction(title: "Save", style: .default) { (act) in
                
                self.saveEditedValuesOfRollno(obj: obj, newValue: (ac.textFields![0].text!), newName: (ac.textFields![1].text!), newmobNo: (ac.textFields![2].text!), newmarks: (ac.textFields![3].text!),newDate:(ac.textFields![4].text!), newAddr: (ac.textFields![5].text!))
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(saveAction)
            ac.addAction(cancelAction)
            present(ac, animated: true, completion: nil)
        }
    func saveEditedValuesOfRollno(obj: Student,newValue: String, newName: String, newmobNo: String, newmarks: String, newDate:String,newAddr: String){
            obj.rollno = Int64(newValue)!
            obj.name = newName
            obj.mobileno = Int64(newmobNo)!
            obj.marks = Float(newmarks)!
            //obj.dob = newAddr as NSDate
            obj.address = newAddr
            do{
                try context.save()
                fetchStudData()
            }catch let error{
                print(error.localizedDescription)
            }
        }
        func deleteStud(obj:Student){
            do{
                context.delete(obj)
                try context.save()
                fetchStudData()
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    

