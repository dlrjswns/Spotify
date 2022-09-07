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

# defer

# ContainerView

