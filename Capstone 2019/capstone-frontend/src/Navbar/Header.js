import React from 'react';
import logo from '../logo.png';

const header = () => {
    return (
        <header className="App-header">
          <img src={logo} className="Logo" alt="logo" />
          <h1 className="App-title">flowr</h1>
        </header>
    );
}

export default header;