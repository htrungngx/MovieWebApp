import './App.css';
import Row from './Row';
import requests from './requests';
import Banner from './Banner';
import Nav from './Nav';

function App() {
  return (
    <div className="app">
      <Nav />

      <Banner />

      <Row title="NETFLIX ORGINALS" fetchURL={requests.fetchNetflixOriginals} isLargeRow/>
      <Row title="Trending Now" fetchURL={requests.fetchTrending} />
      <Row title="Top Rated" fetchURL={requests.fetchTopRated} />
      <Row title="Action Movies" fetchURL={requests.fetchActionMovies} />
      <Row title="Comedy Movies" fetchURL={requests.fetchComedyMovies} />
      <Row title="Horror Movies" fetchURL={requests.fetchHorrorMovies} />
      <Row title="Romance Movies" fetchURL={requests.fetchRomanceMovies} />
      <Row title="Documentaries" fetchURL={requests.fetchDocumantaries} />
    </div>
  );
}

export default App;

// API key: e2f1c0909e8043a32438d0ca2f944f13
// API Request: https://api.themoviedb.org/3/movie/550?api_key=e2f1c0909e8043a32438d0ca2f944f13
// API Read Access Token: eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMmYxYzA5MDllODA0M2EzMjQzOGQwY2EyZjk0NGYxMyIsInN1YiI6IjYyNGVlMDJiYjc2Y2JiMDA2ODI0MDhiOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6ceT22BDuSZkj6QrdepGoGFjAysLvqBL98aV-XW7gL8