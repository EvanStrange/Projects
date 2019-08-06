import React from 'react';
import { Line } from 'react-chartjs-2';

const temperature = () => {
    return (
        <Line
            data= {temperatureData}
            options={{
                scales: {
                yAxes: [{
                    scaleLabel: {
                    display: true,
                    labelString: 'Degrees Celsius'
                    }
                }],
                xAxes: [{
                    ticks: {
                        display: false
                    }
                }]
                },
                responsive: false,
                maintainAspectRatio: true
            }}
            height={300}
            width={525}
        />
    );
}
const temperatureData = {
    labels: ["07:30:00 PM, Aug 5 2019", "07:30:30 PM, Aug 5 2019", "07:31:00 PM, Aug 5 2019", "07:31:30 PM, Aug 5 2019", "07:32:00 PM, Aug 5 2019", "07:32:30 PM, Aug 5 2019", "07:33:00 PM, Aug 5 2019"],
    datasets: [{
      label: 'Temperature',
      fill: false,
      lineTension: 0.1,
      backgroundColor: 'rgba(102, 0, 255, 0.4)',
      borderColor: 'rgba(102, 0, 255, 1)',
      borderCapStyle: 'butt',
      borderDash: [],
      borderDashOffset: 0.0,
      borderJoinStyle: 'miter',
      pointBorderColor: 'rgba(102, 0, 255, 1)',
      pointBackgroundColor: '#fff',
      pointBorderWidth: 1,
      pointHoverRadius: 5,
      pointHoverBackgroundColor: 'rgba(102, 0, 255, 1)',
      pointHoverBorderColor: 'rgba(220,220,220,1)',
      pointHoverBorderWidth: 2,
      pointRadius: 1,
      pointHitRadius: 10,
      data: [23.4, 23.5, 23.7, 24.0, 23.2, 22.6, 22.4]
    }]
}

export default temperature;