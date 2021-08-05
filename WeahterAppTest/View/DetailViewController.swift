//
//  DetailViewController.swift
//  WeatherAppTest
//
//  Created by Александр Уткин on 05.08.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var weatherModel: Weather?
    
    let cityNameLabel: UILabel = {
        let cityNameLabel = UILabel()
        cityNameLabel.text = ""
        cityNameLabel.textAlignment = .center
        cityNameLabel.textColor = .black
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return cityNameLabel
    }()
    
    let conditionLabel: UILabel = {
        let conditionLabel = UILabel()
        conditionLabel.text = ""
        conditionLabel.textAlignment = .center
        conditionLabel.textColor = .black
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return conditionLabel
    }()
    
    let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.text = ""
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .black
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return temperatureLabel
    }()
    
    let pressureValueLabel: UILabel = {
        let pressureValueLabel = UILabel()
        pressureValueLabel.text = ""
        pressureValueLabel.textAlignment = .center
        pressureValueLabel.textColor = .black
        pressureValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return pressureValueLabel
    }()
    
    let windSpeedValueLabel: UILabel = {
        let windSpeedValueLabel = UILabel()
        windSpeedValueLabel.text = ""
        windSpeedValueLabel.textAlignment = .center
        windSpeedValueLabel.textColor = .black
        windSpeedValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return windSpeedValueLabel
    }()
    
    let minTempValueLabel: UILabel = {
        let minTempValueLabel = UILabel()
        minTempValueLabel.text = ""
        minTempValueLabel.textAlignment = .center
        minTempValueLabel.textColor = .black
        minTempValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return minTempValueLabel
    }()
    
    let maxTempValueLabel: UILabel = {
        let maxTempValueLabel = UILabel()
        maxTempValueLabel.text = ""
        maxTempValueLabel.textAlignment = .center
        maxTempValueLabel.textColor = .black
        maxTempValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return maxTempValueLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(cityNameLabel)
        view.addSubview(conditionLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(pressureValueLabel)
        view.addSubview(windSpeedValueLabel)
        view.addSubview(minTempValueLabel)
        view.addSubview(maxTempValueLabel)
        
        let topStack = UIStackView(arrangedSubviews: [cityNameLabel, conditionLabel, temperatureLabel])
        
        topStack.distribution = .equalSpacing
        topStack.axis = .vertical
        topStack.spacing = 2
        topStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topStack)
        
        let leftStack = UIStackView(arrangedSubviews: [pressureValueLabel, windSpeedValueLabel])
        
        leftStack.distribution = .equalSpacing
        leftStack.axis = .vertical
        leftStack.spacing = 2
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftStack)
                
        let rightStack = UIStackView(arrangedSubviews: [minTempValueLabel, maxTempValueLabel])
        
        rightStack.distribution = .equalSpacing
        rightStack.axis = .vertical
        rightStack.spacing = 2
        rightStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightStack)
        
        let bottomStack = UIStackView(arrangedSubviews: [leftStack, rightStack])
        bottomStack.distribution = .equalSpacing
        bottomStack.axis = .horizontal
        bottomStack.spacing = 2
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStack)
        
        let totalStack = UIStackView(arrangedSubviews: [topStack, bottomStack])
        totalStack.distribution = .equalSpacing
        totalStack.axis = .vertical
        totalStack.spacing = 2
        totalStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalStack)
        
        
                        
        
        NSLayoutConstraint.activate([
            totalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            totalStack.heightAnchor.constraint(equalToConstant: 300),
            totalStack.widthAnchor.constraint(equalToConstant: 300)
            
//            totalStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
//            totalStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//            totalStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
//            totalStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        refreshLabels()
        
        
    }
    
    func refreshLabels() {
        cityNameLabel.text = weatherModel?.name
        conditionLabel.text = weatherModel?.conditionString
        if let temp = weatherModel?.temperature {
            temperatureLabel.text = "\(temp)"
        }
        if let pressureMm = weatherModel?.pressureMm {
            pressureValueLabel.text = "\(pressureMm)"
        }
        if let windSpeed = weatherModel?.windSpeed {
            windSpeedValueLabel.text = "\(windSpeed)"
        }
        if let tempMin = weatherModel?.tempMin {
            minTempValueLabel.text = "\(tempMin)"
        }
        if let tempMax = weatherModel?.tempMax {
            maxTempValueLabel.text = "\(tempMax)"
        }
    }
}
