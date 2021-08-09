//
//  TableViewCell.swift
//  WeatherAppTest
//
//  Created by Александр Уткин on 05.08.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let cityNameLabel: UILabel = {
        let cityNameLabel = UILabel()
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        cityNameLabel.textAlignment = .left
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityNameLabel
    }()
    
    let conditionLabel: UILabel = {
        let conditionLabel = UILabel()
        conditionLabel.font = UIFont.boldSystemFont(ofSize: 10)
        conditionLabel.textAlignment = .right
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        return conditionLabel
    }()
    
    let tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont.boldSystemFont(ofSize: 12)
        tempLabel.textAlignment = .left
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cityNameLabel)
        addSubview(conditionLabel)
        addSubview(tempLabel)
        configureStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(weather: Weather)  {
        self.cityNameLabel.text = weather.name
        self.conditionLabel.text = weather.conditionString
        self.tempLabel.text = weather.temperatureString
    }
    
    private func configureStack() {
        let stackView = UIStackView(arrangedSubviews: [cityNameLabel, conditionLabel, tempLabel])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
