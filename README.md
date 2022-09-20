# UICompositionalLayout
* UICompositionalLayout은 복잡한 UICollectionView를 구성하기위해 사용할 수 있는 UI이다
* UICollectionView를 생성할때 생성자 두번째 layout인자에 넣어줄 수 있다

## UICompositionalLayout 사용법
``Swift
let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )

            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

            // Vertical group in horizontal group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(390)
                ),
                subitem: item,
                count: 3
            )

            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(390)
                ),
                subitem: verticalGroup,
                count: 1
            )

            // Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryViews
            return section
```
* section, group, item 단위로 각각 만들어줄 수 있다 
* 아마 section과 item은 감이 오겠지만 group은 생소할 수 있는데 쉽게 이해하기위해 한 줄에 몇개를 표현할 것인가를 생각해보면 이해가 수월할 것이다 
* 위 코드에서 group을 확인해보면 count를 이용하여 한줄에 몇개를 삽입해줄것인지 표현가능하고 subitem으로 verticalGroup을 넣어서 horizontalGroup에 vertical대로 쌓인 데이터를 가로로 넘기게 가능하다 

```Swift
let supplementaryViews = [
    NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(50)
        ),
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .top
    )
]

let section = NSCollectionLayoutSection(group: horizontalGroup)
section.orthogonalScrollingBehavior = .groupPaging
section.boundarySupplementaryItems = supplementaryViews
return section
```
* 위 코드는 기존 UICollectionView에서 헤더를 넣어줄때처럼 하나의 섹션을 잡아 header를 추가가능하다 
* UICompositionalLayout에서 header를 삽입할때는 위 코드에서처럼 boundarySupplementaryItems를 사용하였고 
  elementKind와 alignment를 이용하여 header를 넣어줄 수 있다 

# DispatchGroup
* 우리는 기존에 다수의 스레드를 관리하기위해 DispatchQueue를 이용하여 관리하였습니다 
  즉, 원하는 스레드에 task를 넣어서 처리해주었죠 

## 그렇다면 DispatchGroup은 언제 사용될까요 ??
* 작업을 하다보면은 초기화면을 구성하려할때 API를 비동기적으로 받아와서 뿌려주는 경우가 많을 것입니다 
* 위와 같은 경우에서 다수의 API호출을 하여 그냥 뿌려주는 코드만 작성하지만 우리가 원하는 것은 모든 API를 호출하고 데이터를 받아오고 이를 뿌려준 이후에 
  화면에 보여주고 싶을 것입니다 

* 이때와 같은 순간에 DispatchGroup이라는 것을 사용한다면 여러개의 task를 하나의 그룹으로 묶어서 그 그룹에 속해있는 task가 종료되어야 이를 확인하고 작업해주는 코드를 작성할 수 있습니다 

## DispatchGroup의 사용법
```Swift
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        var newReleases: NewReleasesResponse?
        var featuredPlaylist: FeaturedPlaylistsResponse?
        var recommendations: RecommendationsResponse?

        // New Releases
        APICaller.shared.getNewReleases { result in
            defer {
                print("ASdfasdf?")
                group.leave()
            }
            switch result {
            case .success(let model):
                print("뭐임 = \(model)")
                newReleases = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        // Featured Playlists
        APICaller.shared.getFeaturedPlayLists { result in
            defer {
                group.leave()
            }

            switch result {
            case .success(let model):
                print("model12 = \(model)")
                featuredPlaylist = model
            case .failure(let error):
                print(error.localizedDescription)

            }
        }

        // Recommended Tracks
        APICaller.shared.getRecommendedGenres { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }

                APICaller.shared.getRecommendations(genres: seeds) { recommendedResult in
                    defer {
                        group.leave()
                    }

                    switch recommendedResult {
                    case .success(let model):
                        print("model = \(model)")
                        recommendations = model

                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .main) {
            guard let newAlbums = newReleases?.albums.items,
                  let playlists = featuredPlaylist?.playlists.items,
                  let tracks = recommendations?.tracks else {
                fatalError("Models are nil")
            }
            
            self.configureModels(
                newAlbums: newAlbums,
                playlists: playlists,
                tracks: tracks
            )
        }
```
* 위 코드를 보면은 APICaller를 이용해 NewRelease, FeaturedPlaylist, RecommendationTrack 총 3개의 데이터를 받아오게된다
* 앞서 말했던 경우처럼 3개의 데이터를 모두 왔을 경우를 기다리고 받아왔을 경우 화면에 뿌려주는 경우이다 
* DispatchGroup객체를 만든 후 enter()를 이용해 그룹에 task를 추가합니다 
* 그리고 APICaller를 통해 데이터를 가져온 이후 defer를 이용해 마무리에 leave()를 해줌으로써 추가했던 task를 나가게한다 
* 마지막으로 notify(queue:)를 이용하여 해당 그룹의 모든 task가 leave되기를 대기하고있다가 전부 leave한다면 notify의 블록을 실행하게 됩니다

# defer
* defer는 이를 쓴 해당 함수내부의 동작을 모든 마치고 함수를 종료하기직전에 실행할 구문을 작성할 수 있는 역할을 담당

```Swift
// New Releases
    APICaller.shared.getNewReleases { result in
        defer {
            print("ASdfasdf?")
            group.leave()
        }
        switch result {
        case .success(let model):
            print("뭐임 = \(model)")
            newReleases = model
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
```
* 위 코드는 앞서 설명했던 DispatchGroup에서 그룹으로 묶은 해당 작업을 notify를 통해 대기하는 코드를 작성할 경우 
  우리가 의도한바로 동작하기위해선 반드시 APICaller를 통해 호출한 데이터작업이 성공하든 실패하든 동작을 마치면 해당 그룹에 leave를 통해 알려줘야한다 

* 위와 같은 이유로 defer를 함수를 이용해 항상 동작의 마무리에 leave를 이용해 알려준다 

# ContainerView
* 보통 하나의 뷰 컨트롤러에서는 하나의 루트 뷰를 담당하게 된다, 허나 이때 내가 원하는 뷰 컨트롤러에서 다른 뷰 컨트롤러의 루트 뷰를 관리하고자할때 
  ContainerView를 사용할 수 있다 

* 이때 사용하는것이 내가 ContainerViewController로써 역할을 하고자하는 뷰 컨트롤러에 원하는 뷰 컨트롤러를 addChild를 이용해 추가해주고 
  addSubView를 이용해 뷰를 추가해준다면 원하는 작업이 가능하다

# NotificationCenter

# UISearchController
