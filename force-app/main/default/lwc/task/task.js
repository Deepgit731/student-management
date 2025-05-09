import { LightningElement } from 'lwc';

export default class Task extends LightningElement {
    childData='';
    
        handleDataFromChild(event) {
            this.childData = event.detail;
        }

    
}