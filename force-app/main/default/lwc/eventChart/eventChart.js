import { LightningElement, track } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import CHARTJS from '@salesforce/resourceUrl/ChartJS';
import getEventStats from '@salesforce/apex/EventController.getEventStats';

export default class EventChart extends LightningElement {
  @track error;

  chartjsInitialized = false;
  chart;

  renderedCallback() {
    if (this.chartjsInitialized) {
      return;
    }
    this.chartjsInitialized = true;

    loadScript(this, CHARTJS)
      .then(() => {
        return getEventStats();
      })
      .then(result => {
        this.initializeChart(result);
      })
      .catch(error => {
        this.error = error.body ? error.body.message : error.message;
      });
  }

  initializeChart(data) {
    const ctx = this.template.querySelector('canvas.chart').getContext('2d');

    const labels = data.map(item => item.eventName);
    const counts = data.map(item => item.count);

    this.chart = new window.Chart(ctx, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [{
          label: 'Event Count',
          data: counts,
          backgroundColor: 'rgba(148, 235, 54, 0.7)',
          borderColor: 'rgb(187, 54, 235)',
          borderWidth: 1
        }]
      }, 
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true,
            precision: 0
          }
        }
      }
    });
  }
}