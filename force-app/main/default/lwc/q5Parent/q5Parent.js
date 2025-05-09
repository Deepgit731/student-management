import { LightningElement } from 'lwc';

export default class Q5Parent extends LightningElement {
        childData;
    
        handleDataFromChild(event) {
            this.childData = event.detail;
        }
}