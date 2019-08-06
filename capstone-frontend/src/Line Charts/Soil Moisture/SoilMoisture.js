import React from 'react';
import { Line } from 'react-chartjs-2';

const soilMoisture = () => {
    return (
        <Line
            data= {soilMoistureData}
            options={{
                scales: {
                yAxes: [{
                    scaleLabel: {
                    display: true,
                    labelString: 'Volumetric Water Content'
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
const soilMoistureData = {
    labels: ["07:30:00 PM, Aug 5 2019", "07:30:30 PM, Aug 5 2019", "07:31:00 PM, Aug 5 2019", "07:31:30 PM, Aug 5 2019", "07:32:00 PM, Aug 5 2019", "07:32:30 PM, Aug 5 2019", "07:33:00 PM, Aug 5 2019"],
    datasets: [{
      label: 'Soil Moisture',
      fill: false,
      lineTension: 0.1,
      backgroundColor: 'rgba(0, 255, 255, 0.4)',
      borderColor: 'rgba(0, 255, 255 ,1)',
      borderCapStyle: 'butt',
      borderDash: [],
      borderDashOffset: 0.0,
      borderJoinStyle: 'miter',
      pointBorderColor: 'rgba(0, 255, 255, 1)',
      pointBackgroundColor: '#fff',
      pointBorderWidth: 1,
      pointHoverRadius: 5,
      pointHoverBackgroundColor: 'rgba(0, 255, 255, 1)',
      pointHoverBorderColor: 'rgba(220,220,220,1)',
      pointHoverBorderWidth: 2,
      pointRadius: 1,
      pointHitRadius: 10,
      data: [656.93, 655.32, 654.93, 654.21, 653.80, 652.93, 652.71]
    }]
  }

export default soilMoisture;