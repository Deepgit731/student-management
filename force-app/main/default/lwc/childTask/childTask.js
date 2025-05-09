import { LightningElement } from 'lwc';

export default class ChildTask extends LightningElement {
    a='';
    handleSendData(event){
        this.a = event.target.value;
    }
    handleSendData() {
        const event = new CustomEvent('myevent', {
            detail: this.a
        });
        this.dispatchEvent(event);
    
    }
}