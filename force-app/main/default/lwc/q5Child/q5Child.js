import { LightningElement } from 'lwc';

export default class Q5Child extends LightningElement {
    handleSendData() {
        const event = new CustomEvent('senddata', {
            detail: 'Data from Child'
        });
        this.dispatchEvent(event);
    }
}