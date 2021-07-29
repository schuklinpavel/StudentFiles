//
//  StudentTableViewController.swift
//  StudentFiles
//
//  Created by Pasha on 27.07.2021.
//

import UIKit

class StudentTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBSegueAction func addEditStudent(_ coder: NSCoder, sender: Any?) -> AddEditStudentTableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let student = students[indexPath.row]
            return AddEditStudentTableViewController(coder: coder, student: student)
        } else {
            return AddEditStudentTableViewController(coder: coder, student: nil)
        }
    }
    
    @IBAction func unwindToStudentTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
              let sourceViewController = segue.source as? AddEditStudentTableViewController,
              let student = sourceViewController.student else {
            return
        }

        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            students[selectedIndexPath.row] = student
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: students.count, section: 0)
            students.append(student)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentTableViewCell
        let student = students[indexPath.row]
        
        cell.update(with: student)
        cell.showsReorderControl = true

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedStudent = students.remove(at: fromIndexPath.row)
        students.insert(movedStudent, at: to.row)
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    var students: [Student] = [
        Student(lastName: "Иванов", firstName: "Пётр", averageScore: 4),
        Student(lastName: "Петров", firstName: "Иван", averageScore: 4),
        Student(lastName: "Ivanov", firstName: "Pavel", averageScore: 4),
        Student(lastName: "Smirnov", firstName: "Пётр", averageScore: 5),
        Student(lastName: "Иванов", firstName: "Igor", averageScore: 3),
    ]
}
