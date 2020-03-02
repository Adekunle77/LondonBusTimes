<img width="183" alt="Screenshot 2020-01-09 12 16 58" src="https://user-images.githubusercontent.com/14952997/72067287-40d23a00-32da-11ea-8b3b-9af6e72745c0.png">

# London Bus Times
The London Bus Times app provides the user with information for London buses. 

## London Bus Times
I enjoy walking long distances in London, and occasionally I find myself in unfamilar areas and I always need to know where the nearest bus stop is, what buses will arrive to the bus stop, and how long they would take. 

The London Bus Times app is really easy to use. The user just opens the app and it will display all the local bus stops around the user's current location. At also supplies the buses that arrives to each stop and the times too. 

<img width="285" alt="Screenshot 2020-01-09 11 30 49" src="https://user-images.githubusercontent.com/14952997/72066650-0fa53a00-32d9-11ea-88ff-9fc143fc225e.png">


## Development
Development of this app requires the use of Transport for London API. The Transport for London's API provides the app with the location of each bus stop, bus number and the arrival time. This information is retrieved in a JSON format. The Combine Framework is used to process the changes of the bus's arrival times. The Timer publish is used to trigger an API request to get the updated bus arrival time. This happens every 60 seconds. The retrieved data is displayed on a UICollectionView. Each UICollectionViewCell has information for each bus stop. Also, an MKMapView is used in each cell to show where each bus stop is around the user. CocoaPods is installed in the app to use a Lottie, a 3rd party Library for animation.


## Requirements 
To use the London Bus Times app the user is required to have installed iOS 13 verison or later. The resaon for this is that Apple released the Combine framework to only work with iOS 13 or later versions. I have developed the app to use UICollectionViewDiffableDataSource for the UICollectionView, this also requires the use to have installed  iOS 13 verison or later. 

Using UICollectionViewDiffableDataSource the code below is all that is used to set up UICollectionView data source. 

```Swift
    private func setSourceSetUp() {
        collectionViewDataSource = CollectionViewDataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, stop: Stop) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                            for: indexPath) as? BusStopCell else { fatalError("Cannot create new cell") }
            cell.backgroundColor = .white
            guard let coordinates = self.dataSource.coordinates else { return cell }
            cell.updateCell(with: stop, coordinates: coordinates)
            return cell
        }
    }
 ```
