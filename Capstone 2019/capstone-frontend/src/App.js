import React, { Component } from 'react';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import './App.css';
import Humidity from './Line Charts/Humidity/Humidity';
import Light from './Line Charts/Light/Light';
import SoilMoisture from './Line Charts/Soil Moisture/SoilMoisture';
import Temperature from './Line Charts/Temperature/Temperature';
import Table from './Table/Table';
import Header from './Navbar/Header';
import Footer from './Navbar/Footer';

class App extends Component {
  render() {
    return (
      <div className="App">
        <Header />
        &nbsp;
        <Container>
          <Row>
            <Col>
              <Temperature />
            </Col>
            <Col>
              <Humidity/>
            </Col>
          </Row>
          &nbsp;
          <Row>
            <Col>
              <Light />
            </Col>
            <Col>
              <SoilMoisture />
            </Col>
          </Row>
          &nbsp;
          <Row>
            <Col>
              <Table />
            </Col>
          </Row>
        </Container>
        <Footer />
      </div>
    );
  }
}

export default App;
