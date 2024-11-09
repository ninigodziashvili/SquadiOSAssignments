//
//  ImageViewModel.swift
//  MultithreadingAndConcurrency
//
//  Created by Nika Topuria on 06.11.24.
//

import Foundation
import UIKit

final class ImageViewModel {
    private let networkManager: NetworkManaging
    private let imageProcessor: ImageProcessing
    
    var onImagesUpdated: (() -> Void)?
    
    var images: [UIImage] = [] {
        didSet {
            onImagesUpdated?()
        }
    }
    
    private var imageUrls: [URL] = []
    
    init(
        networkManager: NetworkManaging = NetworkManager(),
        imageProcessor: ImageProcessing = ImageProcessor()
    ) {
        self.networkManager = networkManager
        self.imageProcessor = imageProcessor
    }
    
    
    func fetchImagesWithGCD() {
        let dispatchGroup = DispatchGroup()
        let downloadQueue = DispatchQueue(label: "com.app.imageDownloadQueue", qos: .userInitiated, attributes: .concurrent)
        var downloadedImages = Array<UIImage?>(repeating: nil, count: imageUrls.count)
        
        for (index, url) in imageUrls.enumerated() {
            dispatchGroup.enter()
            
            downloadQueue.async { [weak self] in
                self?.fetchAndProcessImage(from: url) { image in
                    if let image = image {
                        downloadedImages[index] = image
                    }
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.images = downloadedImages.compactMap { $0 }
        }
    }
    
    func fetchImagesWithOperationQueue() {
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = .userInitiated
        operationQueue.maxConcurrentOperationCount = 5
        
        var downloadedImages = Array<UIImage?>(repeating: nil, count: imageUrls.count)
        let completionOperation = BlockOperation { [weak self] in
            DispatchQueue.main.async {
                self?.images = downloadedImages.compactMap { $0 }
            }
        }
        
        for (index, url) in imageUrls.enumerated() {
            let downloadOperation = BlockOperation { [weak self] in
                let semaphore = DispatchSemaphore(value: 0)
                self?.fetchAndProcessImage(from: url) { image in
                    if let image = image {
                        downloadedImages[index] = image
                    }
                    semaphore.signal()
                }
                semaphore.wait()
            }
            
            completionOperation.addDependency(downloadOperation)
            operationQueue.addOperation(downloadOperation)
        }
        
        operationQueue.addOperation(completionOperation)
    }
    
    func fetchImagesWithAsyncAwait() {
        Task(priority: .userInitiated) { [weak self] in
            guard let self = self else { return }
            
            let downloadedImages = await withTaskGroup(of: UIImage?.self) { group in
                for url in self.imageUrls {
                    group.addTask {
                        return await self.fetchAndProcessImageAsync(from: url)
                    }
                }
                
                return await group.reduce(into: [UIImage?]()) { result, image in
                    if let image = image {
                        result.append(image)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.images = downloadedImages.compactMap { $0 }
            }
        }
    }
    
    func updateNumberOfImages(to count: Int) {
        generateImageUrls(numberOfImages: count)
    }
    
    private func generateImageUrls(numberOfImages: Int) {
        let maxImageNumber = 700
        var urls: [URL] = []
        
        for _ in 1...numberOfImages {
            let randomImageNumber = Int.random(in: 1...maxImageNumber)
            if let url = URL(string: "https://yavuzceliker.github.io/sample-images/image-\(randomImageNumber).jpg") {
                urls.append(url)
            }
        }
        
        self.imageUrls = urls
    }
    
    private func fetchAndProcessImage(from url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url else { return }
        networkManager.downloadImage(from: url) { [weak self] image in
            guard let self = self, let image = image else {
                completion(nil)
                return
            }
            self.imageProcessor.applyFilter(to: image) { processedImage in
                completion(processedImage)
            }
        }
    }
    
    private func fetchAndProcessImageAsync(from url: URL?) async -> UIImage? {
        await withCheckedContinuation { continuation in
            self.fetchAndProcessImage(from: url) { image in
                continuation.resume(returning: image)
            }
        }
    }
}
