//
//  SearchWeatherViewController.swift
//  WeatherApp
//
//  Created by Лаванда on 23.03.2024.
//

import UIKit

protocol SearchWeatherScreenViewProtocol: AnyObject {
    func showMessage()
}

class SearchWeatherScreenViewController: UIViewController {
    
    let presenter: SearchWeatherScreenPresenterProtocol
   
    private let baseImageView = UIImageView()
    private let searchTextField = UISearchTextField()
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Я не нашел такого города. Попробуй снова."
        label.numberOfLines = 2
        label.textColor = .darkGray
        label.isHidden = true
        return label
    }()
    
    init(presenter: SearchWeatherScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        view.addSubview(messageLabel)
        
        baseImageView.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            baseImageView.topAnchor.constraint(equalTo: view.topAnchor),
            baseImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            baseImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            baseImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            searchTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            messageLabel.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor),
            messageLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10)
        ])
    }
}

extension SearchWeatherScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            presenter.cheak(city: text)
        }
        textField.text = nil
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            self.messageLabel.isHidden = true
        }
    }
}

extension SearchWeatherScreenViewController: SearchWeatherScreenViewProtocol {
    func showMessage() {
        DispatchQueue.main.async {
            self.messageLabel.isHidden = false
        }
    }
}
