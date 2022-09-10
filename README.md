# UICompositionalLayout

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

# ContainerView

