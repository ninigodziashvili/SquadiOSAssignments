//
//  NotSingleResponsibility.swift
//  SOLID
//
//  Created by Giorgi Amiranashvili on 13.11.24.
//

import UIKit

/* მოცემულ მაგალითში აპლიკაციის ყველა ლოგიკა თუ მოქმედება ერთიანდება ცალკეულ კლასში:
 UI აგება
 UI ობიექტებისთვის შესაბამისი პარამეტრების გაწერა
 ობიექტის მოდიფიცირება ღილაკზე მოქმედებისას
  
 ეს წეინააღმდეგება single responsibility პრინციპებს რაც გულისხმობს:
 მოდულარობა
 ფუნქციონალით და მოქმედებებით გადავსებული კლასი რაც ამცირებს აპის ეფექტურ მუშაობას
 Reusability ცალკეული ფუნქციების
 */

class NotSingleResponsibility: UIViewController {
    
//ობიექტების იმპლემენტაცია
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Code never lies, but it may confuse the heck out of you."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Debug Your Mood", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var clickNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        labelManager()
    }
    
// ობიექტების კონფიგურაცია
    
    func setupUI() {
        configureLabel()
        configureButton()
    }
    
    func configureLabel() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
    
    func configureButton() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 170),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
// ლეიბლის ტექსტის ცვლილების ლოგიკა
    func labelManager() {
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.clickNumber += 1
            switch self?.clickNumber {
            case 1:
                self?.label.text = "Debugging is like being the detective in a crime movie where you’re also the murderer."
            case 2:
                self?.label.text = "What's the best way to debug? Print everything. Then cry."
            case 3:
                self?.label.text = "Trying your best, but not sucessed? Cry again"
            case 4:
                self?.label.text = "Feature or bug? Let the users decide."
            case 5:
                self?.label.text = "Who needs sleep when you have runtime errors?"
            case 6:
                self?.label.text = "Warning: Coffee levels critically low. Proceed at your own risk."
            default:
                self?.label.text = "Out of comments, in need of documentation."
                self?.clickNumber = 0
            }
        }), for: .touchUpInside)
    }
}
