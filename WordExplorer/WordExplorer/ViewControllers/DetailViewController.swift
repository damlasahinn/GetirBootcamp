//
//  DetailViewController.swift
//  WordExplorer
//
//  Created by Damla Sahin on 20.03.2024.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var synonymLabel1: UILabel!
    @IBOutlet weak var synonymLabel2: UILabel!
    @IBOutlet weak var synonymLabel3: UILabel!
    @IBOutlet weak var synonymLabel4: UILabel!
    @IBOutlet weak var synonymLabel5: UILabel!
    @IBOutlet weak var clearFilterButton: UIButton!
    @IBOutlet weak var adjectiveButton: UIButton!
    @IBOutlet weak var verbButton: UIButton!
    @IBOutlet weak var nounButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var primaryLabel: UILabel!
    var receivedText: String?
    var wordDefinitions: [WordDefinition] = []
    var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let textToSearch = receivedText {
            primaryLabel.text = textToSearch
            viewModel.fetchData(for: textToSearch)
            viewModel.fetchSynonyms(for: textToSearch)
        }
        
        viewModel.didUpdateData = { [weak self] definitions in
            self?.wordDefinitions = definitions
            self?.tableView.reloadData()
        }
        
        viewModel.didUpdateSynonyms = { [weak self] synonyms in
            self?.updateSynonymLabels(with: synonyms)
        }
        
        let labels = [synonymLabel1, synonymLabel2, synonymLabel3, synonymLabel4, synonymLabel5]
        

        for label in labels {
            label?.layer.cornerRadius = 8
            label?.layer.masksToBounds = true
            label?.layer.borderColor = UIColor.lightGray.cgColor
            label?.layer.borderWidth = 1
            label?.backgroundColor = UIColor.white
        }
    }
    
    func updateSynonymLabels(with synonyms: [String]) {
        let synonymLabels = [synonymLabel1, synonymLabel2, synonymLabel3, synonymLabel4, synonymLabel5]
        for (index, label) in synonymLabels.enumerated() {
            label?.text = synonyms.indices.contains(index) ? synonyms[index] : nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSearchVC" {
            if let showVC = segue.destination as? SearchViewController {
                showVC.modalPresentationStyle = .fullScreen
            }
        }
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        viewModel.clearFilters()
        updateButtonStyles()
    }
    
    @IBAction func adjectiveTapped(_ sender: Any) {
        viewModel.toggleFilter("adjective")
        updateButtonStyles()
    }
    
    @IBAction func nounTapped(_ sender: Any) {
        viewModel.toggleFilter("noun")
        updateButtonStyles()
    }
    
    @IBAction func verbTapped(_ sender: Any) {
        viewModel.toggleFilter("verb")
        updateButtonStyles()
    }
    
    
    private func stylizeButton(_ button: UIButton, isActive: Bool) {
        let activeFilterBorderColor = UIColor.blue.cgColor
        button.layer.borderWidth = isActive ? 2 : 0
        button.layer.borderColor = isActive ? activeFilterBorderColor : UIColor.clear.cgColor
        button.layer.cornerRadius = 8
    }

    func updateButtonStyles() {
        let activeFilters = viewModel.filters
        stylizeButton(nounButton, isActive: activeFilters.contains("noun"))
        stylizeButton(verbButton, isActive: activeFilters.contains("verb"))
        stylizeButton(adjectiveButton, isActive: activeFilters.contains("adjective"))
        stylizeButton(clearFilterButton, isActive: !activeFilters.isEmpty)
    }

}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? DetailCell else {
            return UITableViewCell()
        }
        
        let meaning = wordDefinitions[indexPath.section].meanings[indexPath.row]
               cell.configure(with: meaning)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordDefinitions[section].meanings.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return wordDefinitions.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return wordDefinitions[section].meanings.first?.partOfSpeech
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

