//
//  DetailViewModel.swift
//  WordExplorer
//
//  Created by Damla Sahin on 20.03.2024.
//

import Foundation

class DetailViewModel {
    
    var didUpdateData: (([WordDefinition]) -> Void)?
    private var allDefinitions: [WordDefinition] = []
    var filters: Set<String> = []
    var didUpdateSynonyms: (([String]) -> Void)?

    func fetchData(for word: String) {
        let urlString = "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, let strongSelf = self else {
                return
            }
            
            do {
                let definitions = try JSONDecoder().decode([WordDefinition].self, from: data)
                DispatchQueue.main.async {
                    strongSelf.didUpdateData?(definitions)
                }
                strongSelf.allDefinitions = definitions
                strongSelf.applyFilter()
            } catch {
                print("Error \(error)")
            }
        }
        task.resume()
    }

    func fetchSynonyms(for word: String) {
        let urlString = "https://api.datamuse.com/words?rel_syn=\(word)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else { return }
            
            do {
                let synonyms = try JSONDecoder().decode([Synonym].self, from: data)
                
                let topSynonyms = synonyms.sorted(by: { $0.score > $1.score }).prefix(5).map { $0.word }
                
                DispatchQueue.main.async {
                    self?.didUpdateSynonyms?(topSynonyms)
                }
            } catch {
                print("Error fetching synonyms: \(error)")
            }
        }
        task.resume()
    }
    
    func applyFilter() {
        let filteredDefinitions: [WordDefinition]
        if filters.isEmpty {
            filteredDefinitions = allDefinitions
        } else {
            filteredDefinitions = allDefinitions.map { wordDefinition -> WordDefinition in
                var filtered = wordDefinition
                filtered.meanings = filtered.meanings.filter { self.filters.contains($0.partOfSpeech) }
                return filtered
            }.filter { !$0.meanings.isEmpty }
        }
        
        DispatchQueue.main.async {
            self.didUpdateData?(filteredDefinitions)
        }
    }

    func toggleFilter(_ newFilter: String) {
        if filters.contains(newFilter) {
            filters.remove(newFilter)
        } else {
            filters.insert(newFilter)
        }
        applyFilter()
    }

    func clearFilters() {
        filters.removeAll()
        applyFilter()
    }
    
}
