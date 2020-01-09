![Group 3@3x](https://user-images.githubusercontent.com/14952997/72066784-5dba3d80-32d9-11ea-9daf-d8012b2009a4.png)
# LondonBusTimes
London Bus Times is a app that gets buses infomation in the London area. 

## LondonBusTimes
I enjoy walking long distances in London, and occasionally I find myself in unfamilar areas and I always need to know where the nearest bus stop is, what buses will arrive to the bus stop, and how long they would take. 

The London Bus Times app is really easy to use. The user just opens the app and it will display all the local bus stops around the user's current location. At also supplies the buses that arrives to each stop and the times too. 


<img width="285" alt="Screenshot 2020-01-09 11 30 49" src="https://user-images.githubusercontent.com/14952997/72066650-0fa53a00-32d9-11ea-88ff-9fc143fc225e.png">


## Development
Development of this app requires of Transport for London API. The Transport for London's API provides the app the location of each bus stop, bus number and the arrive time. This information is retrieved in a JSON format.  The Combine Framework is used to process the changes of the bus's arrival times.  The Timer publish is used to trigger an API request to get an updated buses arrival time. This happens every 60 seconds.  To display the retrieved data a UICollectionView is displayed on the view. In each UICollectionViewCell has information for a single bus stop. Also a MKMapView is used in each cell to show where is bus stop is from the user is.  CocoaPods is installed in the app to use a Lottie, a 3rd party Library for animation. 


## Requirements 
To use the London Bus Times app the user is required to have installed iOS 13 verison or later. The resaon for this is that Apple released the Combine framework to only work with iOS 13 or later versions. I have developed the app to use UICollectionViewDiffableDataSource for the UICollectionView, this also requires the use to have installed  iOS 13 verison or later. 


