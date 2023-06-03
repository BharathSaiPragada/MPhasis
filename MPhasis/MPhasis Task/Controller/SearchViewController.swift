//
//  SearchViewController.swift
//  MPhasis Task
//
//  Created by Bharath Sai Pragada on 03/06/23.
//

import UIKit
import SDWebImage
import CoreLocation

class SearchViewController: UIViewController {
    // Outlet:
    @IBOutlet var searchObject: SearchObject!
    
    // ViewModel:
    let viewModel: CountriesViewModel = CountriesViewModel()
    let weatherViewModel: WeatherViewModel = WeatherViewModel()

    // DataSource:
    var countriesData: [CustomTableCellViewModel] = []
    var weatherData: Weather?
    var locationManager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        // Request a user’s location once
        locationManager.requestLocation()
        
        setupTableView()
        bindCountryViewModel()
        bindGeoLocationWeatherViewModel()
    }

// MARK: - Updating UI According to User Selection
    @IBAction func searchOption(_ sender: UISwitch) {
        if sender.isOn {
            updateZipCodeViewUI()
        } else {
            updateCountryViewUI()
        }
    }
    
// MARK: - Search Button Action
    @IBAction func searchBTNAction(_ sender: UIButton) {
        if !searchObject.cityNameView.isHidden {
            let country = searchObject.countryNameTF.text ?? ""
            let state = searchObject.stateNameTF.text ?? ""
            
            if viewModel.validate(countryTF: country, state: state) {
                let endPoint = viewModel.getEndPoint(countryTF: country, state: state)
                viewModel.getCountriesData(countryQuery: endPoint)
            } else {
                //Please enter atleast one text field
                self.alert(message: "Please enter Country or State..!")
            }
        } else {
            let latitude = searchObject.latitudeTF.text ?? ""
            let longitude = searchObject.longitudeTF.text ?? ""
            if weatherViewModel.validate(latitude: latitude, longitude: longitude) {
                weatherViewModel.getWeatherData(lati: latitude, longi: longitude)
            } else {
                //Please enter atleast both Latitude & Longitude
                self.alert(message: "Please enter correct latitude and logitude of the country..!")
            }
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        animateWeatherPopupView(isDismiss: true)
    }
    
    
// MARK: - Data Binding for Country Search
    func bindCountryViewModel() {
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.searchObject.activityIndicator.startAnimating()
                } else {
                    self?.searchObject.activityIndicator.stopAnimating()
                }
            }
        }
        viewModel.countries.bind { [weak self] countries in
            guard let self = self,
                  let countriesData = countries else {
                self?.alert(message: "Currently forecast is not available for this country or state. Please try again..!")
                return
            }
            self.countriesData = countriesData
            self.reloadTableView()
        }
    }
    
// MARK: - Data Binding for Latitude & Longitude Search
    func bindGeoLocationWeatherViewModel() {
        weatherViewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.searchObject.activityIndicator.startAnimating()
                } else {
                    self?.searchObject.activityIndicator.stopAnimating()
                }
            }
        }
        weatherViewModel.weathers.bind { [weak self] weather in
            guard let self = self,
                  let weatherData = weather else {
                self?.alert(message: "Currently forecast is not available for this country or state. Please try again..!")
                return
            }
            self.weatherData = weatherData
            self.reloadWeatherUI(weather: weatherData)
        }
    }
}

// MARK: - Updating UI Realated Methods
extension SearchViewController {
    func updateCountryViewUI() {
        DispatchQueue.main.async {
            self.searchObject.titleLabel.text = "Search With Zip Code"
            self.searchObject.cityNameView.isHidden = true
            self.searchObject.zipCodeView.isHidden = false
            self.searchObject.countryNameTF.text = ""
            self.searchObject.stateNameTF.text = ""
            self.viewModel.dataSource = []
            self.viewModel.countries.value = []
            self.searchObject.latitudeTF.becomeFirstResponder()
        }
    }
    
    func updateZipCodeViewUI() {
        DispatchQueue.main.async {
            self.searchObject.titleLabel.text = "Search With Country Name"
            self.searchObject.cityNameView.isHidden = false
            self.searchObject.zipCodeView.isHidden = true
            self.searchObject.latitudeTF.text = ""
            self.searchObject.longitudeTF.text = ""
            self.searchObject.countryNameTF.becomeFirstResponder()
        }
    }
    
    func reloadWeatherUI(weather: Weather) {
        let customWeather = CustomWeatherModel.init(weatherData: weather)
//        let iconURL = NetworkConstants.shared.iconAddress+customWeather.icon
        let temp_mini = String(format: "%.2f", (customWeather.tempMin/100))
        let temp_max = String(format: "%.2f", (customWeather.tempMax/100))

        DispatchQueue.main.async {
            self.searchObject.icon.sd_setImage(with: customWeather.iconURL)
            self.searchObject.countryName.text = customWeather.name+", "+customWeather.country
            self.searchObject.latitudeLBL.text = "Latitude: "+customWeather.lat.description
            self.searchObject.longitudeLBL.text = "Longitude: "+customWeather.lon.description
            self.searchObject.weatherStatusLBL.text = customWeather.description
            self.searchObject.windSpeedLBL.text = customWeather.windSpeed.description+" m/s"
            self.searchObject.tempMiniLBL.text = temp_mini+" °С"
            self.searchObject.tempMaxLBL.text = temp_max+" °С"
            if let sunRise = customWeather.sunRise.convertToDate() {
                if let dateString = sunRise.convertToString(format: "MMM d, h:mm a") {
                    self.searchObject.sunRiseLBL.text = "Sun Rise: "+dateString
                }
            }
            if let sunSet = customWeather.sunSet.convertToDate() {
                if let dateString = sunSet.convertToString(format: "MMM d, h:mm a") {
                    self.searchObject.sunSetLBL.text = "Sun Set: "+dateString
                }
            }
            self.animateWeatherPopupView(isDismiss: false)
        }
    }
}

// MARK: - CLLocation Manager Delegate Methods
extension SearchViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Request a user’s location once
        locationManager.requestLocation()
    }
    func locationManager( _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation] ) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            // Handle location update
            
            let country = searchObject.countryNameTF.text ?? ""
            let state = searchObject.stateNameTF.text ?? ""
            let latitudeText = searchObject.latitudeTF.text ?? ""
            let longitudeText = searchObject.longitudeTF.text ?? ""
            
            if !weatherViewModel.validate(latitude: latitudeText, longitude: longitudeText) && !viewModel.validate(countryTF: country, state: state) {
                if weatherViewModel.validate(latitude: latitude.description, longitude: longitude.description) {
                    weatherViewModel.getWeatherData(lati: latitude.description, longi: longitude.description)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location delegate error: ", error.localizedDescription)
    }
}
