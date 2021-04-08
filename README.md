## 개요 :wave:
- 프로젝트 명 : YAKBBAL
<br><br>
- 일정 : 2020.08 ~ 2020.09
<br><br>
- 프로젝트 목적
    - 약 먹는 시간을 자주 깜빡하거나, 주기적으로 약을 복용하고 있는 사용자들을 위한, 약 정보(성분, 부작용, 효능, 용법) 검색 및 문자 알람 서비스

- 팀원
    - 총 인원 6 명
    
- 담당 업무
    - 약 검색 기능, 약 복용 페이지 구현
    - 약 검색시 해당 약 정보, 효능, 용법, 주의사항을 알려주는 기능
    - 회원관련된 모든 기능( 로그인, 로그아웃, 회원가입, 회원수정, 회원탈퇴 )구현에 대한 서포트
    - 게시판 관련 모든 기능 구현에 대한 서포트
    - 약학 정보원 보도 자료 크롤링 기능 구현에 대한 서포트

- 공통 업무
    - 공공데이터 포털 API를 이용하여 데이터 파싱 후 DB에 저장 부분
    - 약 복용 주기 입력시 그래프 보기 기능
         
## 프로젝트 정보 :punch:

### 개발 환경
* language : HTML5 + CSS3, javascript, node, java
* library : jQuery, jsoup, canvasjs
* server : Apache Tomcat 8.0
* DB : MySQL 5.6
* API : Naver Map API, kakao Map API, JavaMail API, 공공데이터 포털 Open API ( 식품의약품안전처_의약품 부작용 정보 서비스, 의약품 제품 허가정보 서비스 )
* OS/Tool : windows 10, Eclipse
      
### 실행 환경
* windows 10
* java8
* eclipse-mars

### ERD

![ERD](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/YAKBBAL_ERD.png)

    
### 구현기능

* 로그인, 로그아웃 기능
* 회원가입, 회원수정, 회원탈퇴 기능
* 카카오 우편 API이용하여 편리한 주소입력 기능
* 실시간 약학 정보원 보도자료 웹 크롤링 기능
* 자유 게시판 작성 기능
* 게시판 댓글 기능
* 고객 지원 게시판( 비밀글 형식 ), 답글 기능
* 게시판 제목 검색 기능
* 약 검색시 해당 약 정보, 효능, 용법, 주의사항을 알려주는 기능
* 약 복용 주기 입력시, 약 효능 그래프 확인 기능
* 주요 도시 약국 위치 찾기 기능
* 문자 API를 이용한 약 복용주기 알림 기능
* 관리자와 실시간 채팅 기능
* JavaMail API을 사용한 기능
    - 비밀번호 찾기 기능
    - 메일 전송 기능

### 핵심기능

#### 약 정보 검색
- 개발 동기
    - 일반 사람들이 약을 복용할때 설명서를 잊어버리거나, 원하는 약의 정보를 찾고 싶을때 편리하게 이용 할 수 있는 약 정보 검색 기능을 구현
- 기능 설명
    - 원하는 약의 이름을 검색창에 입력하면, DB에서 매칭되는 약 정보들의 목록을 확인 가능
    - 약을 검색 하면 한 글자라도 포함이된 약 목록은 모두 불러오기 때문에 불러온, 약 목록에서 원하는 약의 정보를 선택해 확인 가능

> 복용중인 약의 기본 정보, 효능, 용법, 주의사항 검색하기
     
![medicine](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/%EC%95%BD%EA%B2%80%EC%83%89.PNG)

> Code ( 약 검색 기능 )

* /WebContent/search/searchMain.jsp

![search](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/search.png)

* Code 설명 
    * 약 검색은 jquery의 autocomplete를 이용해서 구현
    * source는 자동 완성으로 검색 목록을 출력할 대상을 지정하는데, 검색 조건에 만족하는 약 검색 목록을 DB에서 가져와서 대상으로 지정
    * DB에 검색 리스트 데이터 요청시 ajax를 이용해 비동기 방식으로 요청
    * minLiength 옵션을 설정해, 최소 글자가 1글자라도 찍히면 autocomplete가 작동
    * delay 옵션 사용, 검색창에 글이 작성되고 난 후 목록을 가져오기까지의 시간을 생각해 500ms 딜레이 설정 
    
> [Github에 저장된 autocomplete 확인하기](https://github.com/SbinSho/JSPModel2_Project/blob/master/WebContent/search/searchMain.jsp)    

---

* /src/com/serach/action/SearchAction.java

![searchAction](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/searchAction.png)

* Code 설명
    * autocomplete에서 ajax로 약 정보 리스트를 GET방식으로 요청
        * 요청을 받아 약 정보를 불러오는 searchACtion의 search_medicine 메소드를 실행
    * 이때 request 영역에 담겨있는 parameter값 "param"을 가져와, search_medicine 메소드의 파라미터 값으로 전달

> [Github에 저장된 searchAction 확인하기](https://github.com/SbinSho/JSPModel2_Project/blob/master/src/com/serach/action/SearchAction.java)    

---

* /src/com/search/db/serachDAO.java

![searchDAO](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/searchDAO.png)

* Code 설명 ( 약 검색 )
    * search_medicine을 요청한 쪽에서 전달한 약 정보 이름을 이용해 DB에서 조회
    * 조회가 완료되면, 조회된 리스트 목록을 ArrayList에 담아서 반환

> [Github에 저장된 searchDAO 확인하기](https://github.com/SbinSho/JSPModel2_Project/blob/master/src/com/search/db/serachDAO.java)    

---

> 복용중인 약의 기본 정보, 효능, 용법, 주의

* /WebContent/search/search.jsp

![medicine_search](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/약정보검색.png)

* 원하는 약의 이름을 검색하게 되면, 현재 검색한 약의 이름을 가지고 serach.jsp 페이지로 이동
* 페이지로 이동하게 되면 ajax를 이용해 DB에서 현재 약의 이름에 해당하는 정보를 조회하여 사용자 화면에 출력

> [Github에 저장된 search 페이지 확인하기](https://github.com/SbinSho/JSPModel2_Project/blob/master/WebContent/search/search.jsp)  


#### 약 복용 그래프 & 문자 발송
- 개발 동기
    - 주기적으로 약을 복용해야하는 사람들을 위해 복용 주기만 입력하면 그래프를 통해 한눈에 알아보기 쉽도록 표현하고, 실용성을 위해 복용 시간에 맞춰진 문자 메시지 서비스를 제공함으로써 일상생활에서 도움이 되고자 구현
- 기능 설명
    - 원하는 약을 검색하고 복용 시작 버튼을 눌러 주기를 입력
    - 입력이 완료되면 현재 복용중인 약을 한눈에 볼 수 있는 페이지로 이동하고, 원하는 약의 효능효과의 그래프 보기 버튼을 눌러 그래프를 확인 가능
    
> 현재 복용중인 약에서 그래프 선택하기 

![graph](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/복용시작.png)


> 복용 주기에 맞춰 시각적으로 확인이 가능한, 약 효능 그래프

![graph2](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/복용그래프(효과발현).png)

* 약 동력 공식

![official](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/약공식.png)
     
> Code ( 그래프 그리기 )

* /WebContent/member/graph.jsp

![chart](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/chart.png)

* Code 설명 ( 그래프 그리기 )
    * 그래프는 JavaScript의 canvasjs를 사용해 표현
    * CanvasJS.Chart 객체 생성시 title은 그래프의 제목을, axisX X축의 설정, axisY Y축의 설정, data 렌더링 할 차트 유형을 설정 가능
    * axisX의 title 속성 값을 이용해 x축의 제목을 "시간"으로 설정, axisY의 suffix 속성값을 "%"로 접미사를 설정
    * data 속성을 이용해 렌더링 할 차트의 유형을 설정
        * type은 출력하는 선의 종류, yValueFormatString은 y 축 값의 출력 포맷 형식 지정
        * toolTipContent은 차트 그래프를 마우스 오버시 그래프의 정보를 출력하는 방식을 지정
        * dataPoints는 차트에 그려야 하는 각 값을 지정 해준다.
            * dataPoint 속성에 사용되는 일반적인 값은 3 가지로 x,y 및 레이블
    
> [Github에 저장된 graph 코드 확인하기](https://github.com/SbinSho/JSPModel2_Project/blob/master/WebContent/member/graph.jsp) 

---

> 약 복용 주기를 등록하여 복용 시간에 맞춰, 사용자에게 문자 메시지 전송

* /WebContent/member/a.jsp
     
![message](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/%EB%AC%B8%EC%9E%90%EB%A9%94%EC%8B%9C%EC%A7%80.PNG)

> [Github에 저장된 문자 메시지 전송 코드 확인하기](https://github.com/SbinSho/JSPModel2_Project/blob/master/WebContent/member/a.jsp) 

#### 약국 지도 API
- 개발 동기
    - 필요한 약을 검색한 후 약국 지도를 확인하여 사용자와 가까운 위치에 있는 약국을 빠르게 확인 할 수 있도록 약국 지도를 만듬
- 기능 설명
    - 원하는 약국의 위치를 clustering, marker 기능으로 확인이 가능

> API를 이용하여 원하는 위치의 약국 검색

* clustering 기능

![map_clustering](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/%EC%A7%80%EB%8F%84.PNG)
      
* marker 기능

![map_marker](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/%EC%A7%80%EB%8F%842.PNG)


> [Github에 저장된 clustering, marker 코드 확인하기](https://github.com/SbinSho/JSPModel2_Project/blob/master/WebContent/javascripts/MarkerClustering.js) 

#### 관리자와 실시간 채팅 기능

> 관리자 채팅 기능

![실시간채팅](https://github.com/SbinSho/JSPModel2_Project/blob/master/img/실시간채팅.png)

* Java의 WebSocket을 이용하여 채팅기능 구현
* 관리자 IP 등록 후, 다른 IP에서 메시지를 입력 시, 관리자 컴퓨터에  고객문의 수 만큼 대화 창 생성
* 고객의 실시간 채팅창 퇴장 시, 관리자의 채팅창도 사라지도록 구현


## 마치며
### 프로젝트의 부족한점
- 설계 단계의 시간 투자가 많이 적다보니, 프로젝트 수행시 많은 어려움을 경험
    - 프로젝트 자체가 정리되지 않고 많이 복잡한 느낌, 팀 프로젝트이라서 분업을 하다보니 더욱 더 설계 단계가 중요하다 생각함
- OPEN API를 처음 사용하다 보니 원하는 결과만 바로 뽑거나, 서비스에 맞게 데이터를 가공하는데 어려움, 불필요하게 front에서 한번 더 가공해서 출력해야함
    - API를 자주 사용해보며 여러 방식의 포맷에 대한 데이터 가공 연습 필요
- 약국 찾기 기능 서비스 이용시 원활하게 보기가 힘듬( 부드럽지 않고 조금씩 끊김 ), 주요 광역도시 이외는 약국을 확인 할 수 없음
    - clustering, marker 기능 최적화 및 주요 광역도시 이외 다른 지역까지 약국 지도 확대 필요
