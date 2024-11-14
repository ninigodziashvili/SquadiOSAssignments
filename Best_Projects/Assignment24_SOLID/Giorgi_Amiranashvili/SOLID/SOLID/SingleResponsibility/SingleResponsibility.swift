//
//  SingleResponsibility.swift
//  SOLID
//
//  Created by Giorgi Amiranashvili on 13.11.24.
//


import UIKit

/*
 მოცემულ მაგალითში დაცულია  SingleResponsibility პრინციპი:
 გამოყოფილია ცალკეული მოქმედების ქვეშ კლასები
 რაც აპლიკაციას მოდულარობას გარჩევადობასა და
 ეფექტურ მუშაობას უზრუნველყოფს.
 
 // MARK: საკამათო საკითხი: SingleResponsibility გულისხმობს ცალკეულ კლასში მხოლოდ ერთ ცვლილებას მე კი სამი მაქვს:
 UI ობიექტების ინიცირება
 UI ობიექტების პარამეტრების გაწერა
 ღილაკზე მოქმედების ლოგიკა
 
 ვფიქრობ singleResponsibility პრინციპი არ გულისხმობს მის
 ბუკვალურ გაგებას და საჭიროა ბალანსის დაცვა სიმარტივესა და
 მოდულარობას შორის. მნიშვნელოვანია  ერთი მხრივ ავირიდოთ კლასის და აპლიკაციის გადატვირთვა
 ერთად თავმოყრილი მრავალი ფუნქციონალით
 და მეორე მხრივ კოდის სტრუქტურის ზედმეტი გართულება მრავალი კლასის შექმნით.
 */
// კლასი UI აგების ლოგიკით

class SingleResponsibility: UIViewController {
    
    private let labelManager = LabelManager()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureButtonAction()
    }
    
    private func setupUI() {
        configureLabel()
        configureButton()
    }
    
    private func configureLabel() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
    
    private func configureButton() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 170),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureButtonAction() {
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.labelManager.updateLabel(for: self?.label)
        }), for: .touchUpInside)
    }
}
// კლასი ღილაკზე მოქმედების ლოგიკით
class LabelManager {
    private var clickNumber: Int = 1
    
    func updateLabel(for label: UILabel?) {
        guard let label = label else { return }
        
        switch clickNumber {
        case 1:
            label.text = "Debugging is like being the detective in a crime movie where you’re also the murderer."
        case 2:
            label.text = "What's the best way to debug? Print everything. Then cry."
        case 3:
            label.text = "Trying your best, but not successful? Cry again."
        case 4:
            label.text = "Feature or bug? Let the users decide."
        case 5:
            label.text = "Who needs sleep when you have runtime errors?"
        case 6:
            label.text = "Warning: Coffee levels critically low. Proceed at your own risk."
        default:
            label.text = "Out of comments, in need of documentation."
            clickNumber = 0
        }
        
        clickNumber += 1
    }
}
