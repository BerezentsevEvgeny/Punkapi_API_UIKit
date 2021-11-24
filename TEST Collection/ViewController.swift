//
//  ViewController.swift
//  TEST Collection
//
//  Created by Евгений Березенцев on 22.06.2021.
//

import Alamofire

class ViewController: UIViewController {
    
    var beers: [WelcomeElement] = []
    var beerImage: UIImage = UIImage(systemName: "house")!

    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        
        guard let collectionView = collectionView else { return }
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
    
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        
        fetchData { result in
            switch result {
            case .success(let allBeers):
                self.updateUI(with: allBeers)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        

    }

    private func configureLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(220))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func fetchData(complition: @escaping (Result<[WelcomeElement],Error>)->Void) {
        AF.request("https://api.punkapi.com/v2/beers?page=2&per_page=10").responseData { response in
            if let data = response.data {
                do {
                    let beer = try JSONDecoder().decode([WelcomeElement].self, from: data)
                    complition(.success(beer))
                }
                catch {
                    complition(.failure(error))
                }
            }
        }
    }
    
    
    func updateUI(with beers: [WelcomeElement]) {
        DispatchQueue.main.async {
            self.beers = beers
            
            self.collectionView?.reloadData()
        }
    }
}


extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        let beerItem = beers[indexPath.row]
        let imageUrlString = beerItem.imageURL
        AF.request(imageUrlString).responseData { response in
            guard let imageData = response.data else { return }
            guard let image = UIImage(data: imageData) else { return }
            cell.configureCell(with: beerItem.name, and: image)
    
        }
            return cell
    }
}

