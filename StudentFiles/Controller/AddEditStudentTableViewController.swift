//
//  AddEditStudentTableViewController.swift
//  StudentFiles
//
//  Created by Pasha on 27.07.2021.
//

import UIKit

class AddEditStudentTableViewController: UITableViewController {

    var student: Student?

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var averageScoreTextField: UITextField!

    @IBOutlet weak var saveButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        if let student = student {
            firstNameTextField.text = student.firstName
            lastNameTextField.text = student.lastName
            averageScoreTextField.text = "\(student.averageScore)"

            title = "Редактирование"
        } else {
            title = "Добавление"
        }
    }

    init?(coder: NSCoder, student: Student?) {
        self.student = student
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Navigation

    fileprivate func showAlert(title: String, message: String) {
        var alertStyle = UIAlertController.Style.actionSheet
        if UIDevice.current.userInterfaceIdiom == .pad {
          alertStyle = UIAlertController.Style.alert
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alertController.addAction(action)

        self.present(alertController, animated: true, completion: nil)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "saveUnwind" else {
            return true
        }

        if let firstName = firstNameTextField.text,
           let lastName = lastNameTextField.text,
           let averageScoreText = averageScoreTextField.text {
            let averageScore = Int(averageScoreText) ?? 0

            if firstName.isEmpty || lastName.isEmpty || averageScoreText.isEmpty {
                showAlert(title: "Ошибка", message: "Все поля обязательны")
                return false
            }

            if !firstName.isLatinOrCyrillic || !lastName.isLatinOrCyrillic {
                showAlert(title: "Ошибка",
                          message: "В полях \"Имя\" и \"Фамилия\" должны быть русские или " +
                          "английские символы без пробелов")
                return false
            }

            if averageScore > 5 || averageScore < 1 {
                showAlert(title: "Ошибка", message: "В поле \"Средний балл\" должно быть число от 1 до 5")
                return false
            }

            student = Student(lastName: lastName, firstName: firstName, averageScore: averageScore)
            return true
        }
        return false
    }

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    var isLatinOrCyrillic: Bool {
        let upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
        let lower = "abcdefghijklmnopqrstuvwxyzабвгдеёжзийклмнопрстуфхцчшщъыьэюя"

        for char in self.map({ String($0) }) {
            if !upper.contains(char) && !lower.contains(char) {
                return false
            }
        }

        return true
    }
}
