//
//  TableViewController.swift
//  WeatherAppTest
//
//  Created by Александр Уткин on 05.08.2021.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    var emptyCity = Weather()
    var citiesArray = [Weather]()
    var filteredCitiesArray = [Weather]()
    var cities = ["Ставрополь","Екатеринбург","Тюмень","Краснодар","Новороссийск","Уфа","Пермь","Чита","Глазов","Омск"]
    let networkWeatherManager = NetworkWeatherManager()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.delegate = self
        
        let addButton = UIButton(type: .custom)
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(.blue, for: .normal)
        addButton.addTarget(self, action: #selector(addNewCity), for: .touchUpInside)
        
        let item1 = UIBarButtonItem(customView: addButton)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: CellIdentifier.cellIdentifier)
        addCities()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc func addNewCity(_ sender: Any) {
        alertPlusCity(name: "City", placeholder: "Enter city name") { (city) in
            getCoordinateFrom(city: city) { (coordinate, error) in
                guard let _ = coordinate else {
                    self.showAlert(nameCity: city, success: false)
                    return }
                self.showAlert(nameCity: city, success: true)
                self.cities.append(city)
                self.citiesArray.append(self.emptyCity)
                self.filteredCitiesArray.append(self.emptyCity)
                self.addCities()
            }
        }
    }
    
    func addCities() {
        if self.citiesArray.isEmpty {
            self.citiesArray = Array(repeating: emptyCity, count: self.cities.count)
            self.filteredCitiesArray = self.citiesArray
        }
        getCityWeather(citiesArray: cities) { (index, weather) in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.cities[index]
            self.filteredCitiesArray[index] = self.citiesArray[index]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCitiesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cellIdentifier, for: indexPath) as! TableViewCell
        
        var weather = Weather()
        weather = filteredCitiesArray[indexPath.row]
        cell.configure(weather: weather)
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            
            let editionRow = self.cities[indexPath.row]
            if let index = self.cities.firstIndex(of: editionRow) {
                self.filteredCitiesArray.remove(at: index)
                self.citiesArray.remove(at: index)
                self.cities.remove(at: index)
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = DetailViewController()
        destination.weatherModel = filteredCitiesArray[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCitiesArray = searchText.isEmpty ? citiesArray : citiesArray.filter({ (city) -> Bool in
            return city.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        tableView.reloadData()
    }
    
    
}
