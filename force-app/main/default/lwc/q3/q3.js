import { LightningElement } from 'lwc';

export default class Q3 extends LightningElement {
    inputText = ''; 
    displayedText = '';

    handleInputChange(event) {
        this.inputText = event.target.value;
    }

    handleButtonClick() {
        this.displayedText = this.inputText;
    }
}
