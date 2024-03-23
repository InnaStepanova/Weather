//
//  SearchWeatherViewController.swift
//  WeatherApp
//
//  Created by Лаванда on 23.03.2024.
//

import UIKit

class SearchWeatherViewController: UIViewController {
    
    private let baseImageView = UIImageView()
    private let searchTextField = UISearchTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func configure() {
        baseImageView.image = UIImage(named: "1")
        searchTextField.borderStyle = .roundedRect
        searchTextField.placeholder = "Введите название города"
        searchTextField.delegate = self  // Установим делегат для текстового поля
        
        view.addSubview(baseImageView)
        view.addSubview(searchTextField)
        
        baseImageView.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            baseImageView.topAnchor.constraint(equalTo: view.topAnchor),
            baseImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            baseImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            baseImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            searchTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}

// Добавим расширение для делегата
extension SearchWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  // Скрываем клавиатуру при нажатии на "done"
        navigationController?.pushViewController(LocationWeatherModuleFactory().make(), animated: true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = nil
    }
}
