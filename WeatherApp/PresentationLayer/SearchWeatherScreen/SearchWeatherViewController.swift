//
//  SearchWeatherViewController.swift
//  WeatherApp
//
//  Created by Лаванда on 23.03.2024.
//

import UIKit

class SearchWeatherViewController: UIViewController {
    
    private let baseImageView = UIImageView()
    private let searchTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        baseImageView.image = UIImage(named: "1")
        searchTextField.borderStyle = .roundedRect
        searchTextField.placeholder = "Введите название города"
        
        
        view.addSubview(baseImageView)
        baseImageView.addSubview(searchTextField)
        
        baseImageView.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            baseImageView.topAnchor.constraint(equalTo: view.topAnchor),
            baseImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            baseImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            baseImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            searchTextField.centerYAnchor.constraint(equalTo: baseImageView.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: baseImageView.leadingAnchor, constant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: baseImageView.trailingAnchor, constant: -50)
        ])
    }
}
