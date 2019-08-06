import React from 'react';
import Table from 'react-bootstrap/Table';

const table = () => {
    return (
        <Table striped bordered hover size="sm">
            <thead>
                <tr>
                <th>Timestamp</th>
                <th>Temperature (°C)</th>
                <th>Humidity (%)</th>
                <th>Light (Intensity)</th>
                <th>Soil Moisture (VWC)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>07:30:00 PM, Aug 5 2019</td>
                    <td>23.4</td>
                    <td>54.0</td>
                    <td>682</td>
                    <td>656.93</td>
                </tr>
                <tr>
                    <td>07:30:30 PM, Aug 5 2019</td>
                    <td>23.5</td>
                    <td>54.1</td>
                    <td>683</td>
                    <td>655.32</td>
                </tr>
                <tr>
                    <td>07:31:00 PM, Aug 5 2019</td>
                    <td>23.7</td>
                    <td>54.0</td>
                    <td>683</td>
                    <td>654.93</td>
                </tr>
                <tr>
                    <td>07:31:30 PM, Aug 5 2019</td>
                    <td>24.0</td>
                    <td>53.9</td>
                    <td>682</td>
                    <td>654.21</td>
                </tr>
                <tr>
                    <td>07:32:00 PM, Aug 5 2019</td>
                    <td>23.2</td>
                    <td>53.7</td>
                    <td>685</td>
                    <td>653.80</td>
                </tr>
                <tr>
                    <td>07:32:30 PM, Aug 5 2019</td>
                    <td>22.6</td>
                    <td>53.6</td>
                    <td>686</td>
                    <td>652.93</td>
                </tr>
                <tr>
                    <td>07:33:00 PM, Aug 5 2019</td>
                    <td>22.4</td>
                    <td>53.5</td>
                    <td>685</td>
                    <td>652.71</td>
                </tr>
            </tbody>
        </Table>
    );
}

export default table;