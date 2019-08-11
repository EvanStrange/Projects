import React from 'react';
import { Line } from 'react-chartjs-2';

const light = () => {
    return (
        <Line
            data= {lightData}
            options={{
                scales: {
                yAxes: [{
                    scaleLabel: {
                    display: true,
                    labelString: 'Light Intensity'
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
const lightData = {
    labels: ["07:30:00 PM, Aug 5 2019", "07:30:30 PM, Aug 5 2019", "07:31:00 PM, Aug 5 2019", "07:31:30 PM, Aug 5 2019", "07:32:00 PM, Aug 5 2019", "07:32:30 PM, Aug 5 2019", "07:33:00 PM, Aug 5 2019"],
    datasets: [{
      label: 'Light',
      fill: false,
      lineTension: 0.1,
      backgroundColor: 'rgba(204, 255, 51, 0.4)',
      borderColor: 'rgba(204, 255, 51, 1)',
      borderCapStyle: 'butt',
      borderDash: [],
      borderDashOffset: 0.0,
      borderJoinStyle: 'miter',
      pointBorderColor: 'rgba(204, 255, 51, 1)',
      pointBackgroundColor: '#fff',
      pointBorderWidth: 1,
      pointHoverRadius: 5,
      pointHoverBackgroundColor: 'rgba(204, 255, 51, 1)',
      pointHoverBorderColor: 'rgba(220,220,220,1)',
      pointHoverBorderWidth: 2,
      pointRadius: 1,
      pointHitRadius: 10,
      data: [682, 683, 683, 682, 685, 686, 685]
    }]
  }

export default light;