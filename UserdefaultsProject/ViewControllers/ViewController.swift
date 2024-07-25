//
//  ViewController.swift
//  UserdefaultsProject
//
//  Created by Alexey on 25.07.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var dataTextField: UITextField!
    @IBOutlet weak private var dataLabel: UILabel!
    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    
    private let segmentIndexKey = "segmentIndex"
    private let textFieldInputKey = "textFieldInput"
    private let numberOfLaunchesKey = "numberOfLaunches"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func numberSegmentedControlChoosed(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: segmentIndexKey)
        print(sender.selectedSegmentIndex)
    }
    @IBAction func saveButtonPressed() {
        guard let text = dataTextField.text else { return }
        UserDefaults.standard.set(text, forKey: textFieldInputKey)
        print("saved")
    }
    @IBAction func deleteButtonPressed() {
        let keys = [numberOfLaunchesKey, segmentIndexKey, textFieldInputKey]
        
        keys.forEach {
            UserDefaults.standard.set(nil, forKey: $0)
        }
        
        updateUI()
        print("data deleted, ui updated")
    }
    
}

// MARK: - private methods
extension ViewController {
    func updateUI() {
        
        dataLabel.text = "Запусков приложения - \(saveCurrentLaunch())"
        dataTextField.text = UserDefaults.standard.string(forKey: textFieldInputKey)
        segmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: segmentIndexKey)
    }
    
    func saveCurrentLaunch() -> Int {
        let index = UserDefaults.standard.integer(forKey: numberOfLaunchesKey)
        UserDefaults.standard.setValue(index + 1, forKey: numberOfLaunchesKey)
        
        let result = UserDefaults.standard.integer(forKey: numberOfLaunchesKey)
        return result
    }
}
