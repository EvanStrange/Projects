import React from 'react';
import { Line } from 'react-chartjs-2';

const humidity = () => {
    return (
        <Line
            data= {humidityData}
            options={{
                scales: {
                yAxes: [{
                    scaleLabel: {
                    display: true,
                    labelString: 'Percent Humidity'
                    }
                }],
                xAxes: [{
                    ticks: {
                        display: false
                    }
                }]
                },
                responsive :false,
                maintainAspectRatio: true
            }}
            height={300}
            width={525}
        />
    );
}
const humidityData = {
    labels: ["07:30:00 PM, Aug 5 2019", "07:30:30 PM, Aug 5 2019", "07:31:00 PM, Aug 5 2019", "07:31:30 PM, Aug 5 2019", "07:32:00 PM, Aug 5 2019", "07:32:30 PM, Aug 5 2019", "07:33:00 PM, Aug 5 2019"],
    datasets: [{
      label: 'Humidity',
      fill:false,
      lineTension: 0.1,
      backgroundColor: 'rgba(255, 51, 153 ,0.4)',
      borderColor: 'rgba(255, 51, 153, 1)',
      borderCapStyle: 'butt',
      borderDash: [],
      borderDashOffset: 0.0,
      borderJoinStyle: 'miter',
      pointBorderColor: 'rgba(255, 51, 153, 1)',
      pointBackgroundColor: '#fff',
      pointBorderWidth: 1,
      pointHoverRadius: 5,
      pointHoverBackgroundColor: 'rgba(255, 51, 153, 1)',
      pointHoverBorderColor: 'rgba(220,220,220,1)',
      pointHoverBorderWidth: 2,
      pointRadius: 1,
      pointHitRadius: 10,
      data: [54.0, 54.1, 54.0, 53.9, 53.7, 53.6, 53.5]
    }]
  }

export default humidity;