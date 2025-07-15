//
//  MoviesGridViewController.swift
//  TheMoviesApp
//
//  Created by Ahmed Moatasem on 15/07/2025.
//

import UIKit

class MoviesGridViewController: UIViewController {
    private let viewModel: MoviesGridViewModel
    private var collectionView: UICollectionView!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    init(viewModel: MoviesGridViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil) 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        loadData()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = "Popular Movies"
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let itemWidth = (view.bounds.width - 48) / 2 // 16*2 (left/right) + 16 (middle spacing) = 48
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.8)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadData() {
        Task {
            await viewModel.loadMovies()
            updateUI()
        }
    }
    
    @MainActor
    private func updateUI() {
        if viewModel.isLoading {
            activityIndicator.startAnimating()
            collectionView.isHidden = true
        } else {
            activityIndicator.stopAnimating()
            collectionView.isHidden = false
            collectionView.reloadData()
            
            if let error = viewModel.error {
                showError(error)
            }
        }
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.loadData()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

extension MoviesGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as! MovieCollectionViewCell
        
        let movie = viewModel.movies[indexPath.item]
        let isFavorite = viewModel.favoriteIds.contains(movie.id)
        cell.configure(with: movie, isFavorite: isFavorite)
        
        cell.onFavoriteTapped = { [weak self] movieId in
            Task { @MainActor [weak self] in
                if let isFavorite = await self?.viewModel.toggleFavorite(movieId: movieId) {
                    cell.favoriteButton.isSelected = isFavorite
                }
            }
        }
        
        return cell
    }
}

extension MoviesGridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.item]
        let detailsVM = MovieDetailsViewModel(movie: movie)
        let detailsVC = MovieDetailsViewController(viewModel: detailsVM)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
