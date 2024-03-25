//
//  BoxView.swift
//  WeatherApp
//
//  Created by Лаванда on 22.03.2024.
//

import UIKit

final class BoxView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalTo: self.widthAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    func setup(text: String) {
        DispatchQueue.main.async {
            self.detailLabel.text = text
        }
    }
}
