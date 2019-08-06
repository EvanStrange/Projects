import React from 'react';
import githubLogo from '../GitHub_Logo_White.png';
import '../App.css';

const footer = () => {
    return (
        <footer className="App-footer">
          <p className="Footer-text">Developed by Bailey Dalton and Evan Strange, Capstone 2019</p>
          <a href="https://github.com/bambambambi/capstone">
            <img className="GitHub-Logo" src={githubLogo} href="#" height="50" width="110"/>
          </a>
        </footer>
    );
}

export default footer;